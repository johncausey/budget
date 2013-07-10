class ExpensesController < ApplicationController

  def index
    @user = current_user
    @fixed_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => true).to_a
    @fluid_expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).where(:fixed => false).to_a
  end

  def new
    @expense = Expense.new
  end
  
  def create
    @user = current_user
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Added expense!"
    else
      render expenses_path
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path, notice: "Expense Deleted 5ever"
  end

  private
    def expense_params
      params.require(:expense).permit(:name, :amount, :date_added, :user_id, :fixed)
    end

end
