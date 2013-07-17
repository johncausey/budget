class ExpensesController < ApplicationController

  def index
    @user = current_user
    @fixed_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => true).order("date_added DESC").load
    @fluid_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => false).order("date_added DESC").load
  end

  def new
    @expense = Expense.new
  end
  
  def create
    @user = current_user
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "New expense added!"
    else
      redirect_to expenses_path, :flash => { :alert => "There was an error adding your new expense. Please be sure to fill in all fields and make sure the amount is a number." }
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path, notice: "This expense has been removed."
  end

  private
    def expense_params
      params.require(:expense).permit(:name, :amount, :date_added, :fixed)
    end

end
