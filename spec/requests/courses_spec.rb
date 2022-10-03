require 'rails_helper'

RSpec.describe "Courses", type: :request do
  # TODO: Need to work on it
  describe "Get /courses" do
  include_context 'db_cleanup'
    it "will redirect to login" do
      get courses_path
      expect(response).to have_http_status(302)
    end
  end
end
