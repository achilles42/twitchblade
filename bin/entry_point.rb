#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'pry'
require 'figaro'
require 'pg'

Figaro.application = Figaro::Application.new(environment: "STAGING", path: "config/application.yml")
Figaro.load

require "twich_blade"

TwichBlade::UserInterface.new.run
