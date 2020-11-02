class CouponController < ApplicationController
  def new
    @coupon = current_user.build_coupon
  end

  def create
    
  end
end
