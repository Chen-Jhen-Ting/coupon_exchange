class Coupon < ApplicationRecord
  belongs_to :user

  validates :name , presence: {message: '姓名不可為空' }
  validates :phone, presence: {message: '手機號碼不可為空' }
  validates :twid, taiwanese_id: {case_sensitive: false ,message: "您的身分證字號有誤，請確認後重新輸入"}
  validate :check_uniq_user
  before_create :create_uuid
 
  private
  def create_uuid
    self.uuid = serial_generator(10)
  end

  def serial_generator(n)
    [*'a'..'z', *'A'..'Z', *0..9].sample(n).join
  end

  def check_uniq_user
    coupon = Coupon.find_by(user_id: user_id)
    if coupon
      errors.add(:uniq_user, "您已於兌換過#{coupon.created_at.strftime('%Y年 %m月 %d日 %T')}")
    end
  end
end
