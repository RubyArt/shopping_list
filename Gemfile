source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'devise', '>= 4.3.0'
gem 'haml', '>= 5.0.1'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '>= 4.3.1'
gem 'less-rails', '>= 2.8.0'
gem 'pg', '>= 0.18.4'
gem 'pry', '>= 0.10.4'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '>= 3.5.0'
gem 'sprockets', '3.6.3'
gem 'therubyracer', '>= 0.12.3', platforms: :ruby
gem 'turbolinks', '~> 5'
gem 'twitter-bootstrap-rails', '>= 4.0.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', '>=9.0.6', platform: :mri
  gem 'factory_girl_rails', '>= 4.6.0'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'letter_opener', '~> 1.4.1'
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', '~> 0.49.1'
  gem 'spring', '>= 2.0.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 2.10.1'
  gem 'capybara-email', '~> 2.5.0'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'email_spec', '~> 2.1.0'
  gem 'poltergeist', '~> 1.11.0'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
