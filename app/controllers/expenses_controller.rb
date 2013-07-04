class ExpensesController < ApplicationController

  def index
    @user = current_user
    @expenses = @user.expenses.where("date_added BETWEEN ? AND ?", Time.now.beginning_of_month, Time.now.end_of_month)
  end

  def new
    @expense = Expense.new
  end
  
  def create
    @user = current_user
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      redirect_to my_budget_path, notice: "Added expense!"
    else
      render "index"
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path, notice: "Expense Deleted 5ever"
  end

  private
    def expense_params
      params.require(:expense).permit(:amount, :date_added, :user_id)
    end

end
