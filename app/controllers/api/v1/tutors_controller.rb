class Api::V1::TutorsController < ApplicationController
  def create
    tutor = Tutor.new(tutor_params)
    if tutor.save
      return render json: tutor, each_serializer: ::TutorSerializer, status: :created
    end

    render json: { errors: tutor.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def tutor_params
    params.permit(:name, :username, :email, :password, :course_id)
  end
end
