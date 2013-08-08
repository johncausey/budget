class ExpensesController < ApplicationController
  before_filter do
    params[:expense] &&= expense_params
  end
  load_and_authorize_resource

  def index
    @user = current_user
    @fluid_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => false).order("date_added DESC").load
  end

  def monthly_expenses
    @user = current_user
    @fixed_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => true).order("date_added DESC").load
  end

  def new
    @expense = Expense.new
  end
  
  def create
    @user = current_user
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      if @expense.fixed?
        redirect_to monthly_expenses_path, notice: "New monthly expense has been added!"
      else
        redirect_to regular_spending_path, notice: "New expense has been added!"
      end
    else
      redirect_to :back, :flash => { :alert => "Please be sure to fill in all fields and make sure the amount is a number." }
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to :back, notice: "This expense has been removed."
  end

  private
    def expense_params
      params.require(:expense).permit(:name, :amount, :date_added, :fixed)
    end

end
