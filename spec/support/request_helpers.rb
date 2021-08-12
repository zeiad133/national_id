# frozen_string_literal: true

module RequestHelpers
  def parsed_reponse_body
    JSON.parse(response.body).with_indifferent_access
  end
end
