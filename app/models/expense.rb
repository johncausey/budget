class Expense < ActiveRecord::Base

  belongs_to :user

  validates_format_of :amount, :with => /\A[$]?[0-9]*,?[0-9]+.?[0-9]{0,2}\z/
  validates_presence_of :amount, :name, :date_added

  def amount=(value)
    value = value.to_s.tr('$,', '').to_f
    write_attribute(:amount, value)
  end

  # def self.total_grouped_by_day(start)
  #   expenses = where(date_added: start.beginning_of_day..Time.zone.now)
  #   expenses = expenses.group("date(date_added)")
  #   expenses = expenses.select("date_added, sum(amount) as total_spent")
  #   expenses.group_by { |e| e.date_added.to_date }
  # end



  # This should be moved into the controller to properly associate the current user with expenses.
  def self.chart_data(start = Time.zone.now.beginning_of_month)
    total_amounts = amounts_by_day(start)
    # month_amounts = where(fixed: true).amounts_by_day(start)
    (start.to_date..Time.zone.now.end_of_month).map do |date|
      {
        date_added: date,
        amount: total_amounts[date] || 0#,
        # montly_amount: month_amounts[date] || 0
      }
    end
  end

  def self.amounts_by_day(start)
    expenses = unscoped.where(date_added: start..Time.zone.now.end_of_month)
    expenses = expenses.group('date(date_added)')
    expenses = expenses.order('date(date_added)')
    expenses = expenses.select('date(date_added) as date_added, sum(amount) as total_amount')
    expenses.each_with_object({}) do |expense, amounts|
      amounts[expense.date_added.to_date] = expense.total_amount
    end
  end

end
