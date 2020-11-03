require 'rails_helper'

RSpec.describe 'coupoon', type: :routing do
  it '#new' do
    expect(:get => "/coupon").to route_to("coupon#new")
  end

  it '#create' do
    expect(:post => "/coupon").to route_to("coupon#create")
  end
 
end
