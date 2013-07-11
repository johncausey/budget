class User < ActiveRecord::Base
  has_secure_password
  has_many :expenses
  has_many :incomes

  before_create { generate_token(:auth_token) }
  
  validates_uniqueness_of :email

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def full_name
    if first_name && last_name
      first_name + " " + last_name
    else
      email
    end
  end

end
