module ApplicationHelper

  def this_month
    Time.zone.now.strftime("%B")
  end

  def expenses
    current_user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load.to_a.sum(&:amount)
  end

  def saving
    current_user.savings.where("saving_month BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).first.amount
  end

  def money_used
    saving ? expenses + saving : expenses
  end

  def incomes
    a = current_user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load.to_a.sum(&:amount)
    a == 0 ? 1 : a
  end

  def remainder
    incomes - money_used
  end

  def percent(a,b)
    a/b*100
  end

  def how_much_money_is_left
    if remainder > 0
      "Your remaining balance is #{number_to_currency(remainder)}"
    elsif remainder < 0
      "<span class='fluid-font'>You are over budget by #{number_to_currency(remainder.abs)}</span>".html_safe
    else
      "<span class='saving-font'>You have successfully made budget this month!</span>".html_safe
    end
  end


end
