require 'sinatra'
require 'json'
require_relative 'lib/logstash_logger'

$ROOT = File.expand_path(File.dirname(__FILE__))

configure do
  enable :logging

  file = File.new(File.join($ROOT, "sinatra.log"), 'a+')
  file.sync = true

  use LogstashLogger, file
end

get '/' do
    'Hello world!'
end
