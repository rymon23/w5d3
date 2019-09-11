require 'rack'
require_relative '../lib/controller_base'
require "byebug"

class MyController < ControllerBase
  def go
    # debugger
    render :show
    # debugger
  end
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  # debugger
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  # debugger
  app: app,
  Port: 3000
)
