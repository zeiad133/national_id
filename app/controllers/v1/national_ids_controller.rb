# frozen_string_literal: true

class V1::NationalIdsController < ApplicationController
  def show
    national_id = NationalId.new(params[:id].to_s)
    if national_id.valid?
      render json: national_id.info
    else
      render json: "Please enter a valid national_id", status: :unprocessable_entity
    end
  end

end
