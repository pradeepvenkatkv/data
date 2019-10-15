environment 'production'
daemonize false

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'

# quiet
threads 0, 16
bind 'unix://tmp/sockets/puma.sock'

# === Puma control rack application ===
activate_control_app 'unix://tmp/sockets/puma.sock'
