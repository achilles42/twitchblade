require 'simplecov'

SimpleCov.minimum_coverage(95)
SimpleCov.start

require 'twich_blade'
require 'pg'
require 'figaro'
require 'pry'

Figaro.application = Figaro::Application.new(environment: "TESTING", path: "config/application.yml")
Figaro.load
