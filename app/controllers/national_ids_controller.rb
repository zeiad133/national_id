# frozen_string_literal: true

class NationalIdsController < ApplicationController
  def show
    national_id = NationalId.new(params[:id].to_s)
    if national_id.valid?
      render json: national_id.info
    else
      render json: {errors: "Please enter a valid national_id"}, status: :unprocessable_entity
    end
  end

end
