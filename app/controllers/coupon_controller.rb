class CouponController < ApplicationController
  def new
    @coupon = current_user.build_coupon
  end

  def create
    @coupon = current_user.build_coupon(coupon_params)
    
    if @coupon.save
      redirect_to root_path, notice: "已成功兌換，您的兌換卷序號為 #{ @coupon.uuid }"
    else
      render :new
    end

  end

  private
  def coupon_params
    params.require(:coupon)
          .permit(:name, :twid, :phone)
          .merge(user: current_user)
  end
end
