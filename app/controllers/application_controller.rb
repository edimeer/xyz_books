class ApplicationController < ActionController::Base
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: :render_not_found
  end

  private

  def render_not_found
    redirect_to '/404'
  end
end
