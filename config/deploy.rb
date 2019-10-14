set :application, 'lotuspay'
set :repo_url, 'git@github.com:pradeepvenkatkv/data.git'



set :deploy_to, '/home/ubuntu/lotuspay'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :scm, :git
set :user, "ubuntu"
set :domain, "3.19.228.79"
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system }
set :keep_releases, 5

set :format, :pretty
set :log_level, :debug
set :pty,  false
set :assets_roles, [:web, :app]

set :ssh_options, {
#    keys: %w(/home/ec2/skill_test.pem),
    forward_agent: true,
    auth_methods: ["publickey"],
    keys: ["/home/sathishkumar/bru.pem"]
    #auth_methods: %w(password)
}
role :ubuntu, "ubuntu@3.19.228.79"


# set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
set  :sidekiq_default_hooks, true
set  :sidekiq_pid, -> {  File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')}
set  :sidekiq_env, fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set  :sidekiq_log, -> {  File.join(shared_path, 'log', 'sidekiq.log')}
set  :sidekiq_options, -> {  nil}
set  :sidekiq_require, -> { nil}
set  :sidekiq_tag, -> { nil}
set  :sidekiq_config, -> { nil}
set  :sidekiq_queue, -> { nil}
set  :sidekiq_timeout, -> {  10}
set  :sidekiq_role, -> {  :app}
set  :sidekiq_processes, -> {  1}
set  :sidekiq_concurrency, -> { nil}
# :sidekiq_cmd, -> { "#{fetch(:bundle_cmd, "bundle")} exec sidekiq"  # Only for capistrano2.5
# :sidekiqctl_cmd, -> { "#{fetch(:bundle_cmd, "bundle")} exec sidekiqctl" # Only for capistrano2.5


namespace :deploy do

  # before :starting, :copy_puma

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :add_default_hooks do
    after 'deploy:starting', 'sidekiq:quiet'
    after 'deploy:updated', 'sidekiq:stop'
    after 'deploy:reverted', 'sidekiq:stop'
    after 'deploy:published', 'sidekiq:start'
  end

  after :finishing, 'deploy:cleanup'

end