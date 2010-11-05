class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from InvalidRequestError do |exception|
    redirect_to root_url, :flash => { :error => "No cheating allowed (or double clicks)" }
  end
end
