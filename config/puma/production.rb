root_dir = '/var/www/html/sdvx_est/current'

max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS', max_threads_count)
threads min_threads_count, max_threads_count

worker_timeout 60

bind "unix://#{root_dir}/tmp/sockets/puma.sock"

environment 'production'

pidfile File.expand_path('tmp/pids/server.pid')

stdout_redirect File.expand_path('log/puma_access.log'), File.expand_path('log/puma_error.log'), true

# workerの数は適宜変更する。指定しない場合はsingle modeとなるが、指定した場合はcluster modeとなる。
workers 2

plugin :tmp_restart
