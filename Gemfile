source 'https://rubygems.org'

def darwin?
  RbConfig::CONFIG['host_os'] =~ /darwin/
end

def windows_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i ? require_as : false
end

def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ ? require_as : false
end
# Mac OS X
def darwin_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /darwin/ ? require_as : false
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'kaminari'
gem 'bootstrap-kaminari-views', git: 'https://github.com/klacointe/bootstrap-kaminari-views', branch: 'bootstrap4'
gem 'sequel'
gem 'sequel-rails'
gem 'pg'
gem 'money'
gem 'money-rails'
gem 'openbill-ruby', github: 'openbill-service/openbill-ruby'
# gem 'openbill-ruby', path: '../openbill-ruby'
gem 'slim-rails'
gem 'nprogress-rails'
gem 'semver2'
gem 'bootstrap', '~> 4.0.0.alpha3'

gem 'rack_password'

gem 'bugsnag'
gem 'virtus'
gem 'hashie'

gem 'simple-navigation', git: 'git://github.com/andi/simple-navigation.git'
gem 'simple-navigation-bootstrap'

gem 'font-awesome-rails'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'

gem 'active_link_to'

gem 'philtre'
gem 'philtre-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'pry-rails'
  gem 'pry-theme'

  gem 'pry-pretty-numeric'
  # gem 'pry-highlight'
  # step, next, finish, continue, break
  gem 'pry-nav'

  gem 'pry-doc'
  gem 'pry-docmore'

  # Добавляет show-stack
  gem 'pry-stack_explorer'

  gem 'listen', '~> 3.0'
  gem 'guard', '> 2.12'
  gem 'terminal-notifier-guard', '~> 1.6.1', require: darwin_only('terminal-notifier-guard')

  # gem 'guard-rspec'
  gem 'guard-rails'
  # gem 'guard-shell'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
  # gem 'guard-rubocop'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :deploy do
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano-rails', '~> 1.1.3', require: false
  gem 'capistrano-bundler', require: false

  # Используем planetio/capistrano-db-tasks
  # потому что у него есть dump_cmd_flags через который передается список таблиц для игнора
  #
  gem 'capistrano-db-tasks', require: false, github: 'planetio/capistrano-db-tasks'
end
