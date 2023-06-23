require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:tutor) { FactoryBot.create(:tutor) }
  let(:params) { {} }
  let!(:courses) { FactoryBot.create_list(:course, 2) }

  describe 'GET #index' do
    subject(:get_request) do
      get :index, params: params
    end

    before do
      tutor_login(tutor)
      get_request
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns a list of courses with tutors' do
      response_json = JSON.parse(response.body)

      expect(response_json.size).to eq(3)
    end
  end

  describe 'POST #create' do
    subject(:post_request) { post :create, params: params }

    before do
      tutor_login(tutor)
      post_request
    end

    context 'with valid parameters' do
      let(:params) do
        {
          course: {
            name: 'Math',
            code: 'MATH101',
            tutors_attributes: [
              {
                name: 'John Doe',
                email: 'john@example.com',
                password: 'password'
              }
            ]
          }
        }
      end

      it 'creates a new course with tutors' do
        expect(post_request).to have_http_status(:created)

        response_json = JSON.parse(response.body)
        expect(response_json['name']).to eq('Math')

        expect(response_json['tutors'].size).to eq(1)
        expect(response_json['tutors'].first['name']).to eq('John Doe')
      end

      it 'returns the serialized created tutor' do
        expect(response.body).to eq(::CourseSerializer.new(Course.last).to_json)
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        {
          course: {
            name: 'Math',
            tutors_attributes: [
              {
                name: 'John Doe',
                email: 'john@example.com',
                password: 'password'
              }
            ]
          }
        }
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:unprocessable_entity)

        response_json = JSON.parse(response.body)

        expect(response_json['errors']).to include("Code can't be blank")
      end
    end
  end
end
