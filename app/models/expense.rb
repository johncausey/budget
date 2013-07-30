class Expense < ActiveRecord::Base

  belongs_to :user

  validates_format_of :amount, :with => /\A[$]?[0-9]*,?[0-9]+.?[0-9]{0,2}\z/
  validates_presence_of :amount, :name, :date_added

  def amount=(value)
    value = value.to_s.tr('$,', '').to_f
    write_attribute(:amount, value)
  end

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.days_in_month(month, year = Time.zone.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end


  def self.chart_data(current_user_id, start = Time.zone.now.beginning_of_month)
    fluid_amounts = fluid_amounts_by_day(current_user_id, start)
    #fixed_amounts = where(fixed: true).fixed_amounts_by_day(current_user_id, start)
    daily_fixed_amount = fixed_amount_daily(current_user_id, start)
    daily_saving_amount = saved_amount_daily(current_user_id, start)
    (start.to_date..Time.zone.now.end_of_month).map do |date|
      {
        date_added: date,
        fluid_amount: fluid_amounts[date] || 0,
        # fixed_amount: fixed_amounts[date] || 0,
        daily_fixed: daily_fixed_amount || 0,
        daily_saving: daily_saving_amount || 0
      }
    end
  end

  def self.saved_amount_daily(current_user_id, start)
    saving = Saving.where(:user_id => current_user_id).where(saving_month: start..Time.zone.now.end_of_month).first
    if saving == nil
      0
    else
      daily_cost = saving.amount/days_in_month(Date.today.month)
      daily_cost.round(2)
    end
  end

  def self.fixed_amount_daily(current_user_id, start)
    expenses = where(:user_id => current_user_id).where(date_added: start..Time.zone.now.end_of_month).where(:fixed => true).load.to_a.sum(&:amount)
    daily_cost = expenses/days_in_month(Date.today.month)
    daily_cost.round(2)
  end

  def self.fluid_amounts_by_day(current_user_id, start)
    expenses = unscoped.where(:user_id => current_user_id).where(date_added: start..Time.zone.now.end_of_month).where(:fixed => false)
    expenses = expenses.group('date(date_added)')
    expenses = expenses.order('date(date_added)')
    expenses = expenses.select('date(date_added) as date_added, sum(amount) as fluid_amount')
    expenses.each_with_object({}) do |expense, amounts|
      amounts[expense.date_added.to_date] = expense.fluid_amount
    end
  end

  # def self.fixed_amounts_by_day(current_user_id, start)
  #   expenses = unscoped.where(:user_id => current_user_id).where(date_added: start..Time.zone.now.end_of_month).where(:fixed => true)
  #   expenses = expenses.group('date(date_added)')
  #   expenses = expenses.order('date(date_added)')
  #   expenses = expenses.select('date(date_added) as date_added, sum(amount) as fixed_amount')
  #   expenses.each_with_object({}) do |expense, amounts|
  #     amounts[expense.date_added.to_date] = expense.fixed_amount
  #   end
  # end

end
