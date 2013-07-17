class StaticController < ApplicationController

  def current_month
    @user = current_user
    if @user
      @saved_goal_this_month = @user.savings.where("saving_month BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).first
      @my_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
      @my_incomes = @user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
      @fixed = @my_expenses.where(:fixed => true)
      @fluid = @my_expenses.where(:fixed => false)
      @purchase_count = @my_expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    else
      redirect_to root_url, :flash => { :error => "Please log into your account to access this section." }
    end
  end


end
