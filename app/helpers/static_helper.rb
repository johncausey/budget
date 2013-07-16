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
    "You have used <strong>#{number_to_currency(spent)}</strong> out of <strong>#{number_to_currency(earned)}</strong>.".html_safe
  end

  # def expenses_chart_data
  #   user_expenses = current_user
  #   expenses_by_day = user_expenses.expenses.total_grouped_by_day(3.weeks.ago)
  #   (Time.zone.now.beginning_of_month.to_date..Time.zone.now.end_of_month).map do |date|
  #     {
  #       date_added: date,
  #       amount: expenses_by_day[date].first.try(:total_spent) || 0
  #     }
  #   end
  # end


end
