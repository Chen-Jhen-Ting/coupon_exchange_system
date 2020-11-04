require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let(:user) do
    User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
  end

  # before_action 
  before do
    sign_in user
  end

  describe '#new' do
    context 'use get to #new'do
      subject { get :new }
      it 'should be ok' do
        expect(subject.status).to be 200
      end
    end
  end

  describe '#create' do
    subject { post :create, params: params }

    let(:params) do
      {
        coupon: {
          name: 'test',
          twid: TwidGenerator.generate,
          phone: '0987-654-321'
        }
      }
    end
    let(:coupon) { Coupon.last }

    context 'when first create' do
      it 'should create coupon' do
        expect(subject.status).to be 302
        expect(coupon.attributes.symbolize_keys.slice(:name, :twid, :phone)).to eq(params[:coupon])
      end

      it 'should add one' do
        expect{
          post :create, params: { :coupon => { :name => "test", :twid => TwidGenerator.generate, :phone => '0987-654-321' } }
        }.to change(Coupon,:count).by(1)
      end
    end

    context 'when has already coupon' do
      render_views

      before do
        user.create_coupon(params[:coupon])
      end

      it 'should render new' do
        expect(subject.status).to be 200
        expect(subject.status).to render_template(:new)
        expect(subject.body).to match("您已於#{user.coupon.created_at.strftime('%Y年 %m月 %d日')}兌換過")
      end

      it 'should not add one' do
        expect{
          post :create, params: { :coupon => { :name => "test", :twid => TwidGenerator.generate, :phone => '0911-059-123' } }
        }.to change(Coupon, :count).by(0)
      end
    end
  end

end
