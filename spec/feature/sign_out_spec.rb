require 'rails_helper'

RSpec.feature 'Feature test-', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign out' do
    before(:each) do  
      User.create(
        email: 'te@gmail.com',
        password: '123456123456'
      )
      
      visit root_path
    end

    context 'user has log in' do
      scenario 'User CRUD' do
        # link to sign_up page
        find('#user_log_in').click

        # content of log_in page
        expect(page).to have_content '歡迎登入'
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'

        # fill in log in info
        fill_in('Email',with: 'te@gmail.com',placeholder: '請輸入信箱') 
        fill_in('Password',with: '123456123456',placeholder: '輸入密碼')

        # submit form
        find('#log_in_btn').click 

        # redirect to home page
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content '兌換卷申請區'
        expect(page).to have_content 'Signed in successfully.'

        # sign out
        find('#user_sign_out').click

        #  sign_out message
        expect(page).to have_content 'Signed out successfully.'
      end
    end

    context 'user without log in' do
      scenario 'User CRUD'do
        # sign out
        find('#user_sign_out').click

        #  sign_out message
        expect(page).to have_content 'Signed out successfully.'
      end
    end
  end
end