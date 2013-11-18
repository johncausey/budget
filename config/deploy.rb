require "bundler/capistrano"

server ENV['BUDGET_IP_ADDRESS'], :web, :app, :db, primary: true

set :application, "rainybudget"
set :user, ENV['BUDGET_PRODUCTION_USER']
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
set :repository, "git@github.com:johncausey/budget.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

# Return production logs in terminal through capistrano
namespace :prolog do
  desc "Return the production.log file; append '-s lines=value' for specific line count." 
  task :shot, :roles => :app do
    env = "production"
    lines = variables[:lines] || 200
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( tail -n#{lines} #{deploy_to}/#{shared_dir}/log/production.log )
  end

  desc "Return the production.log file in real time."
  task :live, :roles => :app do
    env = "production"
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( tail -f #{deploy_to}/#{shared_dir}/log/production.log )
  end
end

# Execute console environments for production
desc "Remote console" 
task :console, :roles => :app do
  env = "production"
  server = find_servers(:roles => [:app]).first
  run_with_tty server, %W( ./script/rails console #{env} )
end

desc "Remote dbconsole" 
task :dbconsole, :roles => :app do
  env = "production"
  server = find_servers(:roles => [:app]).first
  run_with_tty server, %W( ./script/rails dbconsole #{env} )
end

def run_with_tty(server, cmd)
  command = []
  command += %W( ssh -t #{gateway} -l #{self[:gateway_user] || self[:user]} ) if     self[:gateway]
  command += %W( ssh -t )
  command += %W( -p #{server.port}) if server.port
  command += %W( -l #{user} #{server.host} )
  command += %W( cd #{current_path} )
  command += [self[:gateway] ? '\&\&' : '&&']
  command += Array(cmd)
  system *command
end

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
