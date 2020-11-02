require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a email, password' do
    user1 = User.new(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    user2 = User.new(
      email: "",
      password: Faker::String.random
    )
    expect(user1).to be_valid
    expect(user2).not_to be_valid
  end

  it 'can be created' do
    user = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    expect(user).to eq(User.last)
  end

  it 'has email and password' do
    columns = User.column_names
    expect(columns).to include("id")
    expect(columns).to include("email")
    expect(columns).to include("encrypted_password")
  end

end