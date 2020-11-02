class CouponController < ApplicationController
  before_action :authenticate_user!
  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    
    if got_coupon
      show_when_you_got
    elsif @coupon.save
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

  def got_coupon
    got_coupon = User.find(@coupon.user_id).coupon
  end

  def show_when_you_got
    create_time = "#{got_coupon.created_at}"
    create_time = create_time.split(" ")[0].split("-")
    flash[:notice] = "您已於 #{create_time[0]} 年 #{create_time[1]} 月 #{create_time[2]} 日兌換過"
    render :new 
  end

end
