require 'rails_helper'
require 'taiwanese_id_validator/twid_generator'

RSpec.describe Coupon, type: :model do
  
  it 'cannot have comments' do   
    user1 = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon1 = user1.build_coupon(
      name: Faker::Name.name  ,
      phone: Faker::PhoneNumber.cell_phone,
      twid: TwidGenerator.generate
    )

    user2 = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon2 = user2.build_coupon(
      name: "",
      phone: Faker::PhoneNumber.cell_phone,
      twid: TwidGenerator.generate
    )

    user3 = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon3 = user3.build_coupon(
      name: "",
      phone: "",
      twid: TwidGenerator.generate
    )

    user4 = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon4 = user4.build_coupon(
      name: "",
      phone: "",
      twid: ""
    )

    user5 = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon5 = user5.build_coupon(
      name: Faker::Name.name  ,
      phone: Faker::PhoneNumber.cell_phone,
      twid: 'FFFFFFF'
    )

    expect(coupon1).to be_valid
    expect(coupon2).not_to be_valid
    expect(coupon3).not_to be_valid
    expect(coupon4).not_to be_valid
    expect(coupon5).not_to be_valid
  end

  it 'can be created' do
    user = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon = user.create_coupon(
      name: Faker::Name.name  ,
      phone: Faker::PhoneNumber.cell_phone,
      twid: TwidGenerator.generate
    )
    expect(coupon).to eq(Coupon.last)
  end

  it 'can be created with uuid' do
    user = User.create(
      email: Faker::Internet.email,
      password: Faker::String.random
    )
    coupon = user.create_coupon(
      name: Faker::Name.name  ,
      phone: Faker::PhoneNumber.cell_phone,
      twid: TwidGenerator.generate
    )
    expect(coupon.uuid).not_to eq("")
    expect(coupon.uuid).to be_present
  end

  it 'has id, name, phone, twid, uuid' do
    columns = Coupon.column_names
    expect(columns).to include("id")
    expect(columns).to include("name")
    expect(columns).to include("phone")
    expect(columns).to include("twid")
    expect(columns).to include("uuid")
  end

 

end
