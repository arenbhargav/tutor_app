require 'rails_helper'

RSpec.describe Api::V1::TutorsController, type: :controller do
  describe 'POST #create' do
    subject(:request) { post :create, params: params }

    let(:course) { FactoryBot.create(:course) }

    context 'with valid parameters' do
      let(:params) do
        {
          name: 'John Doe',
          username: 'johndoe',
          email: 'johndoe@example.com',
          password: 'password',
          course_id: course.id
        }
      end

      it 'creates a new tutor' do
        expect { request }.to change(Tutor, :count).by(1)
      end

      it 'returns a successful response' do
        expect(request).to have_http_status(:created)
      end

      it 'returns the serialized created tutor' do
        request
        expect(request.body).to eq(::TutorSerializer.new(Tutor.last).to_json)
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        {
          avatar: 'avatar_url',
          name: 'John Doe',
          username: 'johndoe',
          email: 'johndoe@example.com',
          password: 'password',
        }
      end

      it 'does not create a new tutor' do
        expect { request }.not_to change(Tutor, :count)
      end

      it 'returns an unprocessable entity status' do
        expect(request).to have_http_status(:unprocessable_entity)
      end

      it 'returns the errors as JSON' do
        expect(request.body).to include("Course must exist")
      end
    end
  end
end
