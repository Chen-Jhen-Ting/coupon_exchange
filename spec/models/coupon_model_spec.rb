require 'rails_helper'
require 'taiwanese_id_validator/twid_generator'

RSpec.describe Coupon, type: :model do
  describe 'Coupon validation' do
    let(:user) do
      User.create(
        email: Faker::Internet.email,
        password: Faker::String.random
      )
    end
    context 'with name, phone and twid' do
      it 'should be ok' do
        coupon = user.build_coupon(
          name: Faker::Name.name  ,
          phone: Faker::PhoneNumber.cell_phone,
          twid: TwidGenerator.generate
        )
        expect(coupon).to be_valid
      end
    end

    context 'without name' do
      it 'should not be ok' do
        coupon = user.build_coupon(
          name: "",
          phone: Faker::PhoneNumber.cell_phone,
          twid: TwidGenerator.generate
        )
        expect(coupon).not_to be_valid
      end
    end

    context 'without phone' do
      it 'should not be ok' do
        coupon = user.build_coupon(
          name: Faker::Name.name ,
          phone: "",
          twid: TwidGenerator.generate
        )
        expect(coupon).not_to be_valid
      end
    end

    context 'without twid' do
      it 'should not be ok' do
        coupon = user.build_coupon(
          name: Faker::Name.name ,
          phone: Faker::PhoneNumber.cell_phone,
          twid: ""
        )
        expect(coupon).not_to be_valid
      end
    end

    context 'with incorrect twid' do
      it 'should not be ok' do
        coupon = user.build_coupon(
          name: Faker::Name.name ,
          phone: Faker::PhoneNumber.cell_phone,
          twid: "fffffff"
        )
        expect(coupon).not_to be_valid
      end
    end
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
