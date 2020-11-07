require 'rails_helper'

RSpec.feature 'Feature test-', type: :feature, driver: :chrome, js: true, slow: true do
  describe 'Coupon exchange' do
    before do
      @user = User.create(
        email: 'te@gmail.com',
        password: '123456123456'
      )
      visit root_path
    end

    context 'user without log in' do
      it 'go back log in page' do
        find('#coupon_apply').click
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end

    context 'get coupon ' do
      before do
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

        # go to coupon exchange page
        find('#coupon_apply').click
        expect(page).to have_content '歡迎申請兌換卷'
      end

      it 'at first time with correct info, it will be ok' do
        # check db data
        expect(Coupon.count).to eq(0)

        # fill in exchange info
        fill_in('姓名',with: '陳ＸＸ') 
        fill_in('身分證字號',with: 'A109199661') 
        fill_in('手機號碼',with: '0912-123-456') 
        
        # get coupon
        find('#coupon-apply-btn').click 

        # check db data
        expect(Coupon.count).to eq(1)

        # redirect to homepage and get message
        expect(page).to have_content '歡迎使用會員卷兌換系統'
        expect(page).to have_content '兌換卷申請區'
        expect(page).to have_content '已成功兌換，您的兌換卷序號為'
        
      end

      it 'without info, it will fail' do
        # check db data
        expect(Coupon.count).to eq(0)

        # fill in exchange info
        fill_in('姓名',with: '') 
        fill_in('身分證字號',with: '') 
        fill_in('手機號碼',with: '') 
        
        # get coupon
        find('#coupon-apply-btn').click 

        # check db data
        expect(Coupon.count).to eq(0)

        expect(page).to have_content '姓名不可為空'
        expect(page).to have_content '手機號碼不可為空'
        expect(page).to have_content '您的身分證字號有誤，請確認後重新輸入'
      end

      it 'with incorrect phone format, it will fail' do
        # check db data
        expect(Coupon.count).to eq(0)

        # fill in exchange info
        fill_in('手機號碼',with: '0912345678') 
        
        # get coupon
        find('#coupon-apply-btn').click 

        # check db data
        expect(Coupon.count).to eq(0)

        expect(page).to have_content '手機號碼格式有誤，請參考 0911-012-456'
      end
      
    end
    
    context 'user has got a coupon'do
      
      let(:params) do
        {
          coupon: {
            name: 'test',
            twid: 'A109199661',
            phone: '0987-654-321'
          }
        }
      end

      before do
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

        # go to coupon exchange page
        find('#coupon_apply').click
        expect(page).to have_content '歡迎申請兌換卷'
        
        @user.create_coupon(params[:coupon])
        visit root_path
      end
      it 'should be fail'do
        # check db data
        expect(Coupon.count).to eq(1)
        
        # link to coupon exchange page and get coupon
        find('#coupon_apply').click 
        find('#coupon-apply-btn').click 
 
        # # check db data
        expect(Coupon.count).to eq(1)
 
        expect(page).to have_content '歡迎申請兌換卷'
        expect(page).to have_content '您已於'
        expect(page).to have_content '兌換過'
      end
    end
      

  end
end