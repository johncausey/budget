module ApplicationHelper

  def this_month
    Time.zone.now.strftime("%B")
  end

  def expenses
    current_user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load.to_a.sum(&:amount)
  end

  def saving
    cs = current_user.savings.where("saving_month BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    if cs.exists?
      cs.first.amount
    else
      cs.first
    end
  end

  def money_used
    saving ? expenses + saving : expenses
  end

  def incomes
    current_user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load.to_a.sum(&:amount)
  end

  def remainder
    incomes - money_used
  end

  def percent(a,b)
    b == 0 ? b = 1 : b
    a/b*100
  end

  def how_much_money_is_left
    if remainder > 0
      "Your remaining balance is #{number_to_currency(remainder)}"
    elsif remainder < 0
      "<span class='fluid-font'>You are over budget by #{number_to_currency(remainder.abs)}</span>".html_safe
    elsif remainder == 0 && expenses > 0
      "<span class='saving-font'>You have successfully made budget this month!</span>".html_safe
    else
      "<span style='font-size: 14px;'>Add expenses, income, and set a savings goal to get started for #{this_month}.</span>".html_safe
    end
  end


end
