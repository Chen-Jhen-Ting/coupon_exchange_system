class Coupon < ApplicationRecord
  belongs_to :user

  validates :name , presence: {message: '姓名不可為空' }
  validates :phone, presence: {message: '手機號碼不可為空' }
  validates :twid, taiwanese_id: {case_sensitive: false ,message: "您的身分證字號有誤，請確認後重新輸入"}
  validate :check_whether_got_coupon # if user already got one coupon 
  validate :check_whether_phone_format_is_ok # check phone format = '0912-123-123'

  before_create :create_uuid
 
  private
  def create_uuid
    self.uuid = serial_generator(10)
  end

  def serial_generator(n)
    [*'a'..'z', *'A'..'Z', *0..9].sample(n).join
  end

  def check_whether_got_coupon
    coupon = Coupon.find_by(user_id: user_id)
    if coupon
      errors.add(:uniq_user, "您已於#{coupon.created_at.strftime('%Y年 %m月 %d日')}兌換過")
    end
  end

  def check_whether_phone_format_is_ok
    # if phone is exist
    phone ? "" : return

    if phone.match(/\A\d{4}-\d{3}-\d{3}\z/) == nil
      errors.add(:incorrect_phone, "手機號碼格式有誤，請參考 0911-012-456")
    end
  end
end
