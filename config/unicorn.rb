root = ENV['BUDGET_PRODUCTION_PATH']
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.rainybudget.sock"
worker_processes 6
timeout 30
