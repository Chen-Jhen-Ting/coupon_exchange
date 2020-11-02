require 'rails_helper'
require 'taiwanese_id_validator/twid_generator'

RSpec.describe CouponController, type: :controller do
  let(:user) do
    pwd = Faker::String.random
    User.create(
      email: Faker::Internet.email,
      password: pwd
      # password_confirmation: pwd
    )
  end

  before do
    sign_in user
  end

  describe '#new' do
    subject { get :new }

    it { expect(subject.status).to be 200 }
  end

  describe '#create' do
    subject { post :create, params: params }

    let(:params) do
      {
        coupon: {
          name: 'test',
          twid: TwidGenerator.generate,
          phone: '0987654321'
        }
      }
    end
    let(:coupon) { Coupon.last }

    context 'when first create' do
      it 'should create coupon' do
        # post :create, params: params
        # expect(response.status).to be 302
        expect(subject.status).to be 302
        expect(coupon.attributes.symbolize_keys.slice(:name, :twid, :phone)).to eq(params[:coupon])
      end
    end

    context 'when has already coupon' do
      render_views

      before do
        user.create_coupon(params[:coupon])
      end

      it 'should render new' do
        expect(subject.status).to be 200
        expect(subject.body).to match("您已於兌換過#{user.coupon.created_at.strftime('%Y年 %m月 %d日 %T')}")
      end
    end
  end
end
