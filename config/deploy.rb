# config valid for current version and patch releases of Capistrano
lock "~> 3.6.1"

set :application, 'data'
set :repo_url, 'git@github.com:pradeepvenkatkv/data.git'

set :git_http_username, "pradeepvenkatkv"
set :git_http_password, "prla@1234"
# set :repo_url, 'https://git.bgr.ionidea.com/ion.jbn'
set :stage, :production
set :rvm_bin_path, "$HOME/bin"
# set :default_stage, "production"
# https://git.bgr.ionidea.com/ion.jbn
set :deploy_to, '/home/jobon_new_deploy/data'  

# set :rvm_type, :system
# set :rbenv_ruby, '2.2.2'
#set :rvm_path, '/usr/share/rvm'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
#set :rvm_ruby_version, 'ruby 2.2.2p95'
#set :branch, :master
#SSHKit.config.command_map[:rake]  = "/usr/share/rvm/rubies/ruby-2.2.2/bin/ruby"
#SSHKit.config.command_map[:rake]  = "/.rvm/bin/#{fetch(:application)}_bundle exec rake"
set :scm, :git
set :user, "jobon_new_deploy"
set :domain, "3.19.228.79"
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system }


set :format, :pretty
set :log_level, :debug
set :pty,  false
set :assets_roles, [:web, :app]
#set :rvm_path, '/usr/share/rvm/rubies/ruby-2.2.2/bin/ruby'

set :ssh_options, {
    # keys: %w(/home/sathishkumar/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: ["publickey"],
    keys: ["/home/sathishkumar/bru.pem"]
    #auth_methods: %w(password)
}
role :jobon_new_deploy, "jobon_new_deploy@3.19.228.79"

# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_error.log"
# set :puma_error_log, "#{shared_path}/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 16]
# set :puma_workers, 0
# set :puma_init_active_record, true
# set :puma_preload_app, true
# Default value for :pty is false
set :pty, true


# Default value for keep_releases is 5
set :keep_releases, 5


# namespace :deploy do

#   # before :starting, :copy_puma

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end


#   after :finishing, 'deploy:cleanup'

# end 