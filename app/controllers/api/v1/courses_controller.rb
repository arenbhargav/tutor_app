class Api::V1::CoursesController < ApplicationController
  before_action :authorize_request

  def index
    courses = Course.includes(:tutors)

    render json: courses, each_serializer: ::CourseSerializer
  end

  def create
    course = Course.new(course_params)

    if course.save
      return render json: course, each_serializer: ::CourseSerializer, status: :created
    end

    render json: { errors: course.errors.full_messages }, status: :unprocessable_entity 
  end

  private

  def course_params
    params.require(:course).permit(:name, :code, tutors_attributes: [:name, :email, :password])
  end
end
