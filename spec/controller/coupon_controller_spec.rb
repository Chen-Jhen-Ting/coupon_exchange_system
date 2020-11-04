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
  
end
