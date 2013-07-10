class Income < ActiveRecord::Base

  belongs_to :user

  validates_format_of :amount, :with => /\A[$]?[0-9]*,?[0-9]+.?[0-9]{0,2}\z/ # Allows a dollar sign, one comma, or decimal.

  def amount=(value)
    value = value.to_s.tr('$,', '').to_f
    write_attribute(:amount, value)
  end
  
end
