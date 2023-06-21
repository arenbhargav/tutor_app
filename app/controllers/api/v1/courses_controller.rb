class Api::V1::CoursesController < ApplicationController
  def create
    course = Course.new(course_params)

    if course.save
      return render json: course, status: :created
    end

    render json: { errors: course.errors.full_messages },
            status: :unprocessable_entity 
  end

  private

  def course_params
    params.require(:course).permit(:name, :code, tutors_attributes: [:name, :email, :password])
  end
end
