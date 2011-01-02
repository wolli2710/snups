set :application, "snups"
set :repository,  "ssh://fhs31478@mediacube.at/var/www/virthosts/franzonrails.multimediatechnology.at/gitrepo"

set :deploy_to, "/var/www/virthosts/franzonrails.multimediatechnology.at/"
set :user, "fhs31478"
set :use_sudo, false

set :scm, :git
set :branch, "master"
default_run_options[:pty] = true

role :web, "multimediatechnology.at"
role :app, "multimediatechnology.at"
role :db,  "multimediatechnology.at", :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :copy_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

require "bundler/capistrano"
set :bundle_flags,       "--quiet"


after "deploy:update_code", "deploy:copy_config"