class Income < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :amount, :name, :date_added

  def amount=(value)
    value = value.to_s.tr('$,', '').to_f
    write_attribute(:amount, value)
  end
  
end
