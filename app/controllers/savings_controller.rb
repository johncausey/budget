class SavingsController < ApplicationController
  before_filter do
    params[:saving] &&= saving_params
  end
  load_and_authorize_resource

  def index
    @user = current_user
    @this_months_savings_goal = @user.savings.where("saving_month BETWEEN ? AND ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).first
    @savings = @user.savings.order("saving_month DESC").load
  end

  def new
    @saving = Saving.new
  end

  def create
    @user = current_user
    @saving = @user.savings.build(saving_params)
    if @saving.save
      redirect_to savings_path, notice: "Updated your saving goal for #{Time.zone.now.strftime("%B")}"
    else
      redirect_to savings_path, notice: "There was an error setting your new goal."
    end
  end

  def destroy
    @saving = Saving.find(params[:id])
    @saving.destroy
    redirect_to savings_path
  end

  private

    def saving_params
      params.require(:saving).permit(:amount, :saving_month)
    end

end
