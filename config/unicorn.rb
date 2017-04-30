worker_processes 6

listen File.expand_path("/data/eopes/unicorn/unicorn_eopes.sock", ENV['EOPES_ROOT'])
pid File.expand_path("/data/eopes/unicorn/unicorn.pid", ENV['EOPES_ROOT'])

timeout 120

preload_app true

stdout_path File.expand_path("log/unicorn.stdout.log", ENV['EOPES_ROOT'])
stderr_path File.expand_path("log/unicorn.stderr.log", ENV['EOPES_ROOT'])

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
