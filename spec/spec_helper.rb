require 'twich_blade'

require 'simplecov'
SimpleCov.start
require 'pg'
require 'figaro'
require 'pry'

Figaro.application = Figaro::Application.new(environment: "TESTING", path: "config/application.yml")
Figaro.load
