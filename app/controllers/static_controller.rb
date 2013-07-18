class StaticController < ApplicationController

  def current_month
    @user = current_user
    if @user
      @expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load
      @incomes = @user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load
      @fixed = @expenses.where(:fixed => true)
      @fluid = @expenses.where(:fixed => false)
      @purchase_count = @expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    else
      redirect_to root_url, :flash => { :error => "Please log into your account to access this section." }
    end
  end


end
