class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :code

  has_many :tutors, serializer: TutorSerializer
end
