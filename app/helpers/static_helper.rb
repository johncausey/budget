module StaticHelper

  def main_total_bar
    amounts = @my_expenses.to_a.sum(&:amount)
    percent = amounts/4000*100
    percent
  end

  def amount_spent
    spent = @my_expenses.to_a.sum(&:amount)
    spent
  end

  def fixed_percent
    fixed = @fixed.to_a.sum(&:amount)
    percent = fixed/4000*100
    percent
  end


end
