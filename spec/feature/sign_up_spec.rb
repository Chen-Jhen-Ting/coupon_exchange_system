require 'rails_helper'

RSpec.feature 'test', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'Feature user sign up' do
    context '' do
      before(:each) do
        visit root_path
      end
  
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
  end
end