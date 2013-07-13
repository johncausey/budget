module StaticHelper

  def main_total_bar
    spent = @my_expenses.to_a.sum(&:amount)
    earned = @my_incomes.to_a.sum(&:amount)
    earned > 0 ? earned : earned = 1
    percent = spent/earned*100
    if percent < 100
      "<div class='progress'><span class='meter' style='width: #{percent}%'></span></div>".html_safe
    elsif percent >= 100
      "<div class='progress alert'><span class='meter' style='width: 100%'></span></div>".html_safe
    end
  end

  def amount_spent
    spent = @my_expenses.to_a.sum(&:amount)
    earned = @my_incomes.to_a.sum(&:amount)
    "You have spent #{number_to_currency(spent)} out of #{number_to_currency(earned)}. "
  end

  def expenses_chart_data
    (Time.zone.now.beginning_of_month.to_date..Date.today).map do |date|
      {
        date_added: date,
        amount: Expense.where("date(date_added) = ?", date).sum(:amount)
      }
    end
  end


end
