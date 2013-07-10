class User < ActiveRecord::Base
  has_secure_password
  has_many :expenses
  has_many :incomes
  
  validates_uniqueness_of :email

  def full_name
    if first_name && last_name
      first_name + " " + last_name
    else
      email
    end
  end

end
