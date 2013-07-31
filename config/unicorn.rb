root = "/home/deployer/apps/rainybudget/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.rainybudget.sock"
worker_processes 6
timeout 30
