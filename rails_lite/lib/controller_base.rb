require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require "byebug"
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    check_update_built_response
    @res.set_header("Location", url)
    @res.status = 302
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    check_update_built_response
    @res.write(content)
    @res["Content-Type"] = content_type
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    # debugger
    file_name = template_name.to_s + ".html.erb"
    class_name = self.class.name.underscore
    path = "views/#{class_name}/#{file_name}"
    # debugger
    # We need to get folder name from class_name
    # We need to split when camel case occurs
    # Only take the first part
    # concat firs part and "_controller.rb"
    # file_path = "../views" + file_name

    file = File.open(
      File.expand_path(file_name, "views/#{class_name}")
    )
    file_content = file.read
    template = ERB.new(file_content)
    render_content(template.result(binding), "text/html")
  end

  def check_update_built_response
    raise "double render" if already_built_response?
    @already_built_response = true
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)

  end
end

