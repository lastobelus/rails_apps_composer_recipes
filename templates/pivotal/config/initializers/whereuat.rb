require 'whereuat'

Whereuat.configure do |config|
  config.pivotal_tracker_token   = "<%= @pivotal_tracker_token %>"
  config.pivotal_tracker_project = <%= @pivotal_tracker_project %>
end