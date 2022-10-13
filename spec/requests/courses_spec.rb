require 'rails_helper'

describe 'Courses', type: :request do
  include_context 'db_cleanup'
  include_context :log_in_admin_user

  let(:valid_attributes) do
    {
      language: 'JJJ',
      name: 'course_111111',
      user_id: 1,
      superuser_id: 1
    }
  end

  let(:invalid_attributes) do
    {
      language: 'Js',
      name: nil,
      user_id: nil,
      superuser_id: nil
    }
  end

  describe 'GET /index' do
    it 'renders the index page' do
      Course.create!(valid_attributes)
      get courses_path
      expect(response).to(be_successful)
    end
  end

  describe 'GET /show' do
    it 'renders the show page' do
      course = Course.create!(valid_attributes)
      get courses_path(course)
      expect(response).to(be_successful)
    end
  end

  describe 'GET /new' do
    it 'renders the new page' do
      get new_course_path
      expect(response).to(be_successful)
    end
  end

  describe 'GET /edit' do
    it 'render a edit page' do
      course = Course.create!(valid_attributes)
      get edit_course_path(course)
      expect(response).to(be_successful)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new course' do
        expect do
          post(courses_path, params: { course: valid_attributes })
        end.to(change(Course, :count).by(1))
      end
      it 'redirects to the created course' do
        post(courses_path, params: { course: valid_attributes })
        expect(response).to(redirect_to(course_path(Course.last)))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new course' do
        expect do
          post(courses_path, params: { course: invalid_attributes })
        end.to(change(Course, :count).by(0))
      end
      it 'redirects to the new template' do
        post(courses_path, params: { course: invalid_attributes })
        expect(response).to(have_http_status(302))

        # get new_course_path
        # expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            language: 'New_Language',
            name: 'new_course',
            user_id: 1,
            superuser_id: 1
          }
        end

        it 'updates the requested course' do
          course = Course.create!(valid_attributes)
          patch course_path(course), params: { course: new_attributes }
          course.reload
          expect(course.updated_at.to_s).to(eq(Time.now.to_s))
        end

        it 'redirects to the course' do
          course = Course.create!(valid_attributes)
          patch course_path(course), params: { course: new_attributes }
          course.reload
          expect(response).to(redirect_to(course_path(course)))
        end
      end

      context 'with invalid parameters' do
        it "renders the 'edit' page again)" do
          course = Course.create!(valid_attributes)
          patch course_path(course), params: { course: invalid_attributes }
          expect(response.body).to(include('Something Went Wrong!'))
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested course' do
        course = Course.create!(valid_attributes)
        expect do
          delete(course_path(course))
        end.to(change(Course, :count).by(-1))
      end
      it 'redirects to the root path' do
        course = Course.create!(valid_attributes)
        delete course_path(course)
        expect(response).to(redirect_to(root_path))
      end
    end
  end
end
