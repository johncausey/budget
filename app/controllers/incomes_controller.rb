class IncomesController < ApplicationController
  
  def index
    @user = current_user
    @incomes = @user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
  end

  def new
    @income = Income.new
  end
  
  def create
    @user = current_user
    @income = @user.incomes.build(income_params)
    if @income.save
      redirect_to incomes_path, notice: "Added income!"
    else
      render incomes_for_user_path
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    redirect_to incomes_path, notice: "Income deleted successfully."
  end

  private
    def income_params
      params.require(:income).permit(:name, :amount, :date_added, :user_id)
    end

end
