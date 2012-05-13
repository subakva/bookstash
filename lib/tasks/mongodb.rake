namespace :mongodb do

  def dev_db_name
    'bookstash_development'
  end

  def mongod_pid
    pid_path = File.join(mongo_dir, 'pids', 'mongod')
    return nil unless File.exists?(pid_path)
    pid = File.read(pid_path).strip
    return pid.blank? ? nil : pid
  end

  def mongo_dir
    File.join(Rails.root, 'mongodb')
  end

  def run_command(command)
    puts " -- Executing: #{command}"
    result = system(command)
    raise RuntimeError.new("command failed: #{command}") unless $?.success?
    result
  end

  desc 'Installs mongodb into a sub-directory'
  task :install do
    puts " => Downloading mongodb..."
    run_command('wget http://fastdl.mongodb.org/osx/mongodb-osx-x86_64-2.0.5.tgz -O tmp/mongodb.tgz')

    puts " => Extracting mongodb files..."
    run_command('tar xzf tmp/mongodb.tgz')

    puts " => Creating mongodb directory..."
    FileUtils.mkdir_p(mongo_dir)

    puts " => Moving mongodb files into place..."
    Dir['mongodb-*/*'].each do |path|
      FileUtils.mv(path, File.join(mongo_dir, File.basename(path)))
    end
    FileUtils.rm_rf(Dir['mongodb-*'].last)

    puts " => Creating data directories..."
    FileUtils.mkdir_p(File.join(mongo_dir, 'data'))
    FileUtils.mkdir_p(File.join(mongo_dir, 'logs'))
    FileUtils.mkdir_p(File.join(mongo_dir, 'pids'))
  end

  desc 'Starts the mongodb server'
  task :start do
    if mongod_pid.present?
      puts "=> MongoDB is already running: #{mongod_pid}."
    else
      pid = Process.spawn("mongodb/bin/mongod -f #{mongo_dir}/mongod.conf")
      Process.detach pid
    end
  end

  desc 'Stops the mongodb server'
  task :stop do
    if mongod_pid.present?
      run_command("kill #{mongod_pid}")
    else
      puts "=> MongoDB is not running. Either pid file is empty or does not exist."
    end
  end

  desc 'Starts a mongodb shell'
  task :shell do
    Process.exec("#{mongo_dir}/bin/mongo --port 27049 #{dev_db_name}")
  end

  desc 'Dumps the development database'
  task :dump do
    pid = Process.spawn("#{mongo_dir}/bin/mongodump --host localhost --port 27049 --db #{dev_db_name} -o #{mongo_dir}/dumps")
    Process.wait(pid)
  end

  desc 'Restores the development database'
  task :restore do
    pid = Process.spawn("#{mongo_dir}/bin/mongorestore --host localhost --port 27049 --db #{dev_db_name} --drop #{mongo_dir}/dumps/#{dev_db_name}")
    Process.wait(pid)
  end

end
