default_run_options[:pty] = true

set :keep_releases,   5
set :application,     "cactussports.com"
set :repository,      "git@github.com:jimjeffers/Cactus-Sports.git"
set :scm,             "git"
set :user,            "cactus"
set :password,        "c4ctu5"
set :branch,          "master"
set :deploy_via,      :remote_cache
set :deploy_to,       "/data/apps/#{application}"
role :app,            "67.23.27.88"
role :web,            "67.23.27.88"
role :db,             "67.23.27.88", :primary => true
set :port,            30000

desc "Link shared files"
task :before_symlink do
  run "rm -f #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "rm -rf #{release_path}/log/"
  run "ln -nfs #{shared_path}/log #{release_path}/log"
  run "rm -rf #{release_path}/tmp/"
  run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
end

task :migrate do
  run "export GEM_HOME=/home/cactus/.rvm/gems/ruby/1.8.7"
end

[:start, :restart, :stop].each do |action|
  desc "Restarts passenger."
  deploy.task action do
    sudo "touch #{shared_path}/tmp/restart.txt"
  end
end

after "deploy", "deploy:cleanup"
after "deploy:migrations" , "deploy:cleanup"