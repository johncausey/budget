class StaticController < ApplicationController

  def current_month
    @user = current_user
    @my_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @my_incomes = @user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @fixed = @my_expenses.where(:fixed => true)
    @fluid = @my_expenses.where(:fixed => false)
    @purchase_count = @my_expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
  end


end
