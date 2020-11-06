require 'rails_helper'

RSpec.feature 'test', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'visit home page' do
    context '' do
      before(:each) do
        visit root_path
      end
  
      scenario 'User CRUD' do 
        # content of home page
        expect(page).to have_content '註冊'
        expect(page).to have_content '登入'
        expect(page).to have_content '登出'
        expect(page).to have_content '歡迎使用會員卷兌換系統'
      end
      
    end
  end
end