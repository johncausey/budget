class IncomesController < ApplicationController
  
  def index
    @user = current_user
    @incomes = @user.incomes.where("date_added BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).load
  end

  def new
    @income = Income.new
  end
  
  def create
    @user = current_user
    @income = @user.incomes.build(income_params)
    if @income.save
      redirect_to incomes_path, notice: "New income added!"
    else
      redirect_to incomes_path, :flash => { :alert => "There was an error adding your new income. Please be sure to fill in all fields and make sure the amount is a number." }
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    redirect_to incomes_path, notice: "This income has been removed."
  end

  private
    def income_params
      params.require(:income).permit(:name, :amount, :date_added)
    end

end
