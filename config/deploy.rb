# config valid for current version and patch releases of Capistrano
lock '~> 3.17.0'

set :application, 'sdvx_est'
set :repo_url, 'git@github.com:saezurucrow/sdvx-est.git'
set :deploy_to, '/var/www/html/sdvx_est'
set :branch, ENV['BRANCH'] || 'master'

set :rbenv_type, :system
set :rbenv_ruby, '2.7.5'.strip # rails6から.ruby-version内の記述が変わっていて File.read('.ruby-version').strip では動かないので注意
set :rbenv_path, '/usr/local/rbenv'

append :linked_dirs, '.bundle' # gemの保存先をシンボリックリンクにして、gemをリリース間で共有

append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, '.bundle', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'

namespace :deploy do
  task :puma_restart_again do
    invoke  'puma:stop'
    invoke! 'puma:start'
  end
  desc 'db_seed'
  task :db_seed do
    on roles(:db) do |_host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, 'db:seed'
        end
      end
    end
  end
end

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, '/etc/nginx/conf.d'

after 'puma:restart', 'deploy:puma_restart_again'

set :puma_daemonize, false

set :puma_service_unit_name, 'puma.service'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
