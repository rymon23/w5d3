require 'json'
require "byebug"

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @session = {} 
  end

  def [](key)
    # @session[:key] would this work?
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    # debugger
    jsonified_cookies = @session.to_json
    res.set_cookie(_rails_lite_app, jsonified_cookies) 
    # debugger
    #= @session
  end
end
