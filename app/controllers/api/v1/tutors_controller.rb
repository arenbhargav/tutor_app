class Api::V1::TutorsController < ApplicationController
  def create
    tutor = Tutor.new(tutor_params)
    if tutor.save
      render json: tutor, each_serializer: ::TutorSerializer, status: :created
    end

    render json: { errors: tutor.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def tutor_params
    params.permit(:avatar, :name, :username, :email, :password, :password_confirmation)
  end
end
