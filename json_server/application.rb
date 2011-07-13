require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  erb :root
end

get '/heatmap' do
  content_type :json
  month = 201001
  12.times do
    parse_synthese "#{month}"
    month += 1
  end
  $SEATS.to_json
end