require 'rails_helper'

RSpec.feature('User', type: :feature) do
  given(:present_user) { create(:member_user) }

  feature 'Successful Login' do
    scenario 'Signing in with correct credentials' do
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: present_user.email
        fill_in 'Password', with: present_user.password
      end
      click_button 'commit'
      expect(page).to(have_content('Signed in successfully'))
    end
  end

  feature 'Unsuccessful Login' do
    scenario 'Signing in with incorrect email' do
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'first@gmail.com'
        fill_in 'Password', with: present_user.password
      end
      click_button 'commit'
      expect(page).to(have_content('Invalid Email or password'))
    end
    scenario 'Signing in with incorrect password' do
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: present_user.email
        fill_in 'Password', with: '11111111'
      end
      click_button 'commit'
      expect(page).to(have_content('Invalid Email or password'))
    end
  end
end
