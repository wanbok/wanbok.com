# deploy.rb
#=================================
 
# require "rvm/capistrano"
 
default_run_options[:pty] = true
set :application, "wanbok.com"
set :repository,  "git@github.com:wanbok/wanbok.com.git"
set :user,  Proc.new { Capistrano::CLI.password_prompt('User: ') }
set :scm, :git
set :scm_passphrase,  Proc.new { Capistrano::CLI.password_prompt('Git Password: ') }
set :domain, "wanbok.com"
set :server_hostname, "wanbok.com"
role :web, server_hostname
role :app, server_hostname
ssh_options[:forward_agent] = true
set :branch, "master"
set :git_shallow_clone, 1 #deploy only top commit
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 2
 
# set :rvm_ruby_string, '1.9.3'
# set :rvm_type, :user
 
after "deploy", "db:migrate", "deploy:cleanup"
 
namespace :db do
  task :migrate do
    run " cd #{deploy_to}/current && bundle exec rake db:migrate RAILS_ENV=production"
  end
end
 
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end