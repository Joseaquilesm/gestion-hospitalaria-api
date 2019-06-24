class ApplicationController < ActionController::Base
  ActiveAdmin.setup do |config|
    config.comments = false
  end
end
