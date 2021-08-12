# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionsHandler
  # include ActionView::Rendering
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected




  # def render_to_body(options)
  #   _render_to_body_with_renderer(options) || super
  # end
end
