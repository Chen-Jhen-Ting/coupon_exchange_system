require 'rails_helper'

RSpec.feature 'Feature test-', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'user sign up' do
    before(:each) do
      visit root_path
    end
    context 'with email and password' do
      scenario 'User CRUD' do
        # check DB data
        expect(User.count).to eq(0)
        
        # link to sign_up page
        find('#user_sign_up').click

        # content of sign_up page
        expect(page).to have_content '歡迎註冊'
        expect(page).to have_content '信箱'
        expect(page).to have_content '密碼'

        # fill in sign up info
        fill_in('信箱',with: 'te@gmail.com',placeholder: '請輸入信箱', id: 'user_email') # locator will find element by name, id, or label text
        fill_in('密碼',with: '123456123456',placeholder: '輸入密碼', id: 'user_password' )
        fill_in('再次確認密碼',with: '123456123456',placeholder: '驗證密碼', id: 'user_password_confirmation' )

        # submit form
        find('#sign_up_btn').click 

        # DB data +1
        expect(User.count).to eq(1)

        # redirect to home page
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
      end
    end
    
    context 'without email and password' do
      scenario 'User CRUD' do
        # check DB data
        expect(User.count).to eq(0)
        
        # link to sign_up page
        find('#user_sign_up').click

        # content of sign_up page
        expect(page).to have_content '歡迎註冊'
        expect(page).to have_content '信箱'
        expect(page).to have_content '密碼'

        # fill in sign up info
        fill_in('信箱',with: '',placeholder: '請輸入信箱', id: 'user_email') # locator will find element by name, id, or label text
        fill_in('密碼',with: '',placeholder: '輸入密碼', id: 'user_password' )
        fill_in('再次確認密碼',with: '',placeholder: '驗證密碼', id: 'user_password_confirmation' )

        # submit form
        find('#sign_up_btn').click 

        # DB data +1
        expect(User.count).to eq(0)

        # redirect to home page
        expect(page).to have_content "Email can't be blank"
        expect(page).to have_content "Password can't be blank"
      end
    end

    context 'user has log in' do
      scenario 'User CRUD' do
        # check DB data
        expect(User.count).to eq(0)
        
        # link to sign_up page
        find('#user_sign_up').click

        # content of sign_up page
        expect(page).to have_content '歡迎註冊'
        expect(page).to have_content '信箱'
        expect(page).to have_content '密碼'

        # fill in sign up info
        fill_in('信箱',with: 'te@gmail.com',placeholder: '請輸入信箱', id: 'user_email') # locator will find element by name, id, or label text
        fill_in('密碼',with: '123456123456',placeholder: '輸入密碼', id: 'user_password' )
        fill_in('再次確認密碼',with: '123456123456',placeholder: '驗證密碼', id: 'user_password_confirmation' )

        # submit form
        find('#sign_up_btn').click 

        # DB data +1
        expect(User.count).to eq(1)

        # redirect to home page
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content 'Welcome! You have signed up successfully.'

        # link to sign_up page again
        find('#user_sign_up').click

        # redirect to homepage show message
        expect(page).to have_content 'You are already signed in.'

      end
    end
  end
end