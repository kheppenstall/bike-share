ENV["RACK_ENV"] ||= "test"
require 'rspec'

require File.expand_path("../../config/environment", __FILE__)
require 'capybara/dsl'
require 'database_cleaner'
require 'date'

Capybara.app = BikeShareApp

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end

  c.include Capybara::DSL
end

