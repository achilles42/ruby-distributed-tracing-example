require 'sinatra'

require 'opentracing'
require 'jaeger/client'
require 'rack/tracer'

OpenTracing.global_tracer = Jaeger::Client.build(service_name: 'service-y')

use Rack::Tracer

get '/' do
  'Response: Hello from service-y'
  return "#{servicex}" # Calling service-x
end

def servicex
  client = Net::HTTP.new("localhost",4567)
  req = Net::HTTP::Get.new("/")
  OpenTracing.inject(env['rack.span'].context, OpenTracing::FORMAT_RACK, req)
  client.request(req).body
end
