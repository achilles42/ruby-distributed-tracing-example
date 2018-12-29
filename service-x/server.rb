require 'sinatra'

require 'opentracing'
require 'jaeger/client'
require 'rack/tracer'

OpenTracing.global_tracer = Jaeger::Client.build(service_name: 'service-x')

use Rack::Tracer

get '/' do
  'Response: Hello from service-x'
end
