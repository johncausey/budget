class User < ActiveRecord::Base
  has_secure_password
  has_many :expenses, :dependent => :destroy
  has_many :incomes, :dependent => :destroy
  has_many :savings, :dependent => :destroy

  before_create { generate_token(:auth_token) }
  before_create :set_original_supporter
  
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def set_original_supporter
    self.original_supporter = true
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def full_name
    first_name.blank? && last_name.blank? ? email : first_name + " " + last_name
  end

end
