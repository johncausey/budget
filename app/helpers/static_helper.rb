module StaticHelper

  # All of this code is bananas and should be fixed when I'm less lazy.

  # Generates a link or the amount saved on the current_month page.
  def saved_goal_this_month
    saved_goal = @saved_goal_this_month
    if saved_goal
      earned = @my_incomes.to_a.sum(&:amount)
      earned > 0 ? earned : earned = 1
      percent = saved_goal.amount/earned*100
      if percent < 100
        "Savings goal of #{number_to_currency(saved_goal.amount)} (#{number_to_percentage(percent, :precision => 2)} of income).".html_safe
      else percent >= 100
        "You're saving more than you're making this month!"
      end
    else
      link_to('Set a savings goal!', savings_path)
    end
  end

  # Generates the main bar for "how much you've spent" on the current_month page.
  def main_total_bar
    spent = @my_expenses.to_a.sum(&:amount)
    earned = @my_incomes.to_a.sum(&:amount)
    earned > 0 ? earned : earned = 1
    if @saved_goal_this_month
      total_money_used = spent + @saved_goal_this_month.amount
    else
      total_money_used = spent
    end
    percent = total_money_used/earned*100
    if percent < 100
      "<div class='progress'><span class='meter' style='width: #{percent}%'></span></div>".html_safe
    elsif percent >= 100
      "<div class='progress alert'><span class='meter' style='width: 100%'></span></div>".html_safe
    end
  end

  # Generates the text showing the numbers on how much you spent on the current_month page.
  def amount_spent
    spent = @my_expenses.to_a.sum(&:amount)
    if @saved_goal_this_month
      total_money_used = spent + @saved_goal_this_month.amount
    else
      total_money_used = spent
    end
    earned = @my_incomes.to_a.sum(&:amount)
    "You have used <strong>#{number_to_currency(total_money_used)}</strong> out of <strong>#{number_to_currency(earned)}</strong>.".html_safe
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
