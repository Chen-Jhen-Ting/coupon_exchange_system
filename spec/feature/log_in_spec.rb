require 'rails_helper'

RSpec.feature 'Feature test-', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign in' do
    before(:each) do  
      User.create(
        email: 'te@gmail.com',
        password: '123456123456'
      )
      
      visit root_path

      # link to sign_up page
      find('#user_log_in').click

      # content of log_in page
      expect(page).to have_content '歡迎登入'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'Password'
    end

    context 'with correct email and password' do
      scenario 'User CRUD' do
        # fill in log in info
        fill_in('Email',with: 'te@gmail.com',placeholder: '請輸入信箱') 
        fill_in('Password',with: '123456123456',placeholder: '輸入密碼')

        # submit form
        find('#log_in_btn').click 

        # redirect to home page
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content '兌換卷申請區'
        expect(page).to have_content 'Signed in successfully.'
      end
    end
    
    context 'with incorrect email and password' do
      scenario 'User CRUD' do
        # fill in log in info
        fill_in('Email',with: 'ted@gmail.com',placeholder: '請輸入信箱') 
        fill_in('Password',with: '',placeholder: '輸入密碼')

        # submit form
        find('#log_in_btn').click 

        # render log in page and show erroe message
        expect(page).to have_content 'Invalid Email or password.'
      end
    end

    context 'user has log in' do
      scenario 'User CRUD' do
        # fill in log in info
        fill_in('Email',with: 'te@gmail.com',placeholder: '請輸入信箱') 
        fill_in('Password',with: '123456123456',placeholder: '輸入密碼')

        # submit form
        find('#log_in_btn').click 

        # redirect to home page
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content '兌換卷申請區'
        expect(page).to have_content 'Signed in successfully.'

        # link to sign_up page again
        find('#user_log_in').click

        # homepage show alert
        expect(page).to have_content 'You are already signed in.'
      end
    end
  end
end