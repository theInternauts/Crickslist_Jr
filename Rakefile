require './app'
require 'sinatra/activerecord/rake'
require_relative 'db/faker_data_maker'

begin
  require "rspec/core/rake_task"
  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w[--color]
    t.pattern = 'spec/*_spec.rb'
  end

  task :default => :spec
rescue LoadError
end


desc 'Start IRB with application environment loaded'
task 'console' do
  exec 'irb -r ./app.rb'
end


desc "populate the test database with sample data"
task "db:populate" do
  # Generator.fake_posts(25)
  # Generator.fake_users(25)
  Generator.fake_data(25)
end


desc "drop the database"
task "db:drop" do
  rm_f 'db/app.sqlite3'
end


desc "drop, create, migrate, populate, and distribute the test database with sample data"
task "db:reset-reload" do
  %x( rake db:drop )
  %x( rake db:migrate )
  %x( rake db:populate )
end

