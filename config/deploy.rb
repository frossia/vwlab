# По умолчанию для дистрибуции проектов используется Bundler.
# Эта строка включает автоматическое обновление и установку
# недостающих gems, указанных в вашем Gemfile.
#
## !!! Не забудьте добавить
# gem 'capistrano'
# gem 'unicorn'
#
# в ваш Gemfile.
#
# Если вы используете другую систему управления зависимостями,
# закомментируйте эту строку.
require 'bundler/capistrano'

## Чтобы не хранить database.yml в системе контроля версий, поместите
## dayabase.yml в shared-каталог проекта на сервере и раскомментируйте
## следующие строки.

# after "deploy:update_code", :copy_database_config
# task :copy_database_config, roles => :app do
#   db_config = "#{shared_path}/database.yml"
#   run "cp #{db_config} #{release_path}/config/database.yml"
# end

# В rails 3 по умолчанию включена функция assets pipelining,
# которая позволяет значительно уменьшить размер статических
# файлов css и js.
# Эта строка автоматически запускает процесс подготовки
# сжатых файлов статики при деплое.
# Если вы не используете assets pipelining в своем проекте,
# или у вас старая версия rails, закомментируйте эту строку.
load 'deploy/assets'

# Для удобства работы мы рекомендуем вам настроить авторизацию
# SSH по ключу. При работе capistrano будет использоваться
# ssh-agent, который предоставляет возможность пробрасывать
# авторизацию на другие хосты.
# Если вы не используете авторизацию SSH по ключам И ssh-agent,
# закомментируйте эту опцию.
ssh_options[:forward_agent] = true

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     "vwlab"

# Сервер размещения проекта.
set :deploy_server,   "sulfur.locum.ru"

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            "hosting_avfrancev"
set :login,           "avfrancev"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true

# Следующие строки необходимы, т.к. ваш проект использует rvm.
set :rvm_ruby_string, "2.1.2"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

# Настройка системы контроля версий и репозитария,
# по умолчанию - git, если используется иная система версий,
# нужно изменить значение scm.
set :scm,             :git

# Предполагается, что вы размещаете репозиторий Git в вашем
# домашнем каталоге в подкаталоге git/<имя проекта>.git.
# Подробнее о создании репозитория читайте в нашем блоге
# http://locum.ru/blog/hosting/git-on-locum
set :repository,      "git://github.com/frossia/vwlab.git"

## Если ваш репозиторий в GitHub, используйте такую конфигурацию
# set :repository,    "git@github.com:username/project.git"

## --- Ниже этого места ничего менять скорее всего не нужно ---

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
  set :current_release, latest_release
end

set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"


# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
end


# ======================================================


namespace :db do

  task :backup do
    run "cp #{deploy_to}/current/db/production.sqlite3 #{deploy_to}/backup/db/production.sqlite3"
    run "cp #{deploy_to}/current/db/production.sqlite3 #{deploy_to}/backup/db/backup#{Time.now.strftime("_%Y-%d-%m")}"
    download("#{current_path}/db/production.sqlite3", "/Users/Admin/projects/vwlab/tmp/db_backup/backup#{Time.now.strftime("_%Y-%d-%m")}.sqlite3")
    run_locally("rsync -ar --delete --stats -v hosting_vwlaburovo@phosphorus.locum.ru:~/projects/vwlab/current/public/uploads/ ~/projects/vwlab/public/uploads/")
  end

  task :restore do
    deploy.stop
    run "cp #{deploy_to}/backup/db/production.sqlite3 #{deploy_to}/current/db/production.sqlite3"
    deploy.start
  end

  task :up do
    deploy.stop
    upload("/Users/Admin/projects/vwlab/db/development.sqlite3", "#{current_path}/db/production.sqlite3")
    deploy.start
  end

  task :down do
    download("#{current_path}/db/production.sqlite3", "/Users/Admin/projects/vwlab/db/development.sqlite3")
  end

  task :down_upload do
    run_locally("rsync -ar --delete --stats -v hosting_mossaburovo@phosphorus.locum.ru:~/projects/vwlab/current/public/uploads/ ~/projects/vwlab/public/uploads/")
  end

  task :files_up do
    upload("/Users/Admin/projects/vwlab/public/uploads", "#{shared_path}", :via=> :scp, :recursive => true)
    run "cd #{current_path}/public && ln -s #{shared_path}/uploads uploads"
  end

  task :duble do
    run_locally('cp db/development.sqlite3 db/production.sqlite3')
  end

end

after "deploy:update_code", 'db:up'

# -----------------------------------------------------------------

task :git_up do
  run_locally('rake db:seed:version')
  run_locally('git add --all .')
  run_locally('git commit -m ' + '"' + Time.now.to_s + '"')
  run_locally('git push')
end

task :app_deploy do
  git_up
  run_locally('cap deploy')
  db.up
end
