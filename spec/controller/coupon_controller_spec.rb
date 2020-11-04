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

end
