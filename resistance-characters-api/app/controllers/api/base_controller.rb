class Api::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid,
    with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound,
    with: :render_not_found_response

  private

  def render_unprocessable_entity_response exception
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response exception
    render json: {error: exception.message}, status: :not_found
  end

  def restrict_content_type
    render json: {
      msg:  'Content-Type must be application/json'
    },
    status: 406 unless request.content_type == 'application/json'
  end

end
