# frozen_string_literal: true

require 'active_support/concern'
module ExceptionsHandler
  extend ActiveSupport::Concern

  included do
    include ActiveSupport::Rescuable
    rescue_from ActionController::ParameterMissing,
      with: :missing_param_response
  end

  def missing_param_response(message)
    render json: { error: message }, status: :bad_request
  end
end
