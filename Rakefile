require './app'
require 'sinatra/activerecord/rake'

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