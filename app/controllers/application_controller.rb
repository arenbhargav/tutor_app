require 'json_web_token'

class ApplicationController < ActionController::API
  def authorize_request
    decoded = JsonWebToken.decode(header)
    @current_user = ::Tutor.find(decoded[:tutor_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  private

  def header
    header = request.headers['Authorization']
    header.split(' ').last if header
  end
end
