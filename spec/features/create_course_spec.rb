require 'rails_helper'

RSpec.feature 'CreateCourses', type: :feature do
  include_context 'db_cleanup'

  given(:present_user) { create(:admin_user) }
  before do
    visit '/auth/login'
    within('#new_user') do
      fill_in 'Email', with: present_user.email
      fill_in 'Password', with: present_user.password
    end
    click_button 'commit'
    expect(page).to have_content 'Signed in successfully'
  end

  feature 'create a course' do
    scenario 'valid course details' do
      visit '/courses/new'
      fill_in 'course_name', with: 'Course R'
      fill_in 'Language', with: 'js'
      click_button 'commit'
      expect(page).to have_content 'Course R'
    end
    scenario 'invalid course details' do
      visit '/courses/new'
      fill_in 'course_name', with: 'Course x'
      fill_in 'Language', with: 'js'
      click_button 'commit'
      expect(page).to have_content 'Name Last letter must be capitaL'
    end
  end
end
