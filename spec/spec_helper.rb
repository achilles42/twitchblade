require 'twich_blade'

require 'pg'
require 'figaro'

Figaro.application = Figaro::Application.new(environment: "testing", path: "../..config/application.yml")
Figaro.load
