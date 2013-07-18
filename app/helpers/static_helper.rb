module StaticHelper

  # Generates a link or the amount saved on the current_month page.
  def saved_goal_this_month
    if saving
      p = percent(saving, incomes)
      if p < 100
        "Savings goal of #{number_to_currency(saving)} (#{number_to_percentage(p, :precision => 2)} of income).".html_safe
      else p >= 100
        "You're saving more than you're making this month!"
      end
    else
      link_to('Set a savings goal!', savings_path)
    end
  end

  # Generates the main bar for "how much you've spent" on the current_month page.
  def main_total_bar
    p = percent(money_used, incomes)
    if p < 100
      "<div class='progress'><span class='meter' style='width: #{p}%'></span></div>".html_safe
    elsif p > 100
      "<div class='progress alert'><span class='meter' style='width: 100%'></span></div>".html_safe
    else
      "<div class='progress success'><span class='meter' style='width: 100%'></span></div>".html_safe
    end
  end

  # Generates the text showing the numbers on how much you spent on the current_month page.
  def amount_spent
    "You have used <strong>#{number_to_currency(money_used)}</strong> out of <strong>#{number_to_currency(incomes)}</strong>.".html_safe
  end

end
