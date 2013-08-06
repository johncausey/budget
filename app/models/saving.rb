class Saving < ActiveRecord::Base

  belongs_to :user

  # validates_format_of :amount, :with => /\A[$]?[0-9]{0,3}[,]?[0-9]{0,3}[.]?[0-9]{0,2}\z/

  before_create :set_saving_month
  before_save :only_allow_one_per_month

  def amount=(value)
    value = value.to_s.tr('$,', '').to_f
    write_attribute(:amount, value)
  end

  def set_saving_month
    self.saving_month = Time.zone.now
  end

  def only_allow_one_per_month
    this_user_id = self.user_id
    if @this_month_user_savings = Saving.where(:user_id => this_user_id.to_i).where("saving_month BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).first
      @this_month_user_savings.destroy
    end
  end

end
