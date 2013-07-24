class MessagesController < ApplicationController
  

  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      MessageMailer.send_customer_message(@message).deliver
      redirect_to root_url, notice: "Thank you! We will respond as soon as we can through email."
    else
      render "new"
    end
  end

  private
    def message_params
      params.require(:message).permit(:name, :email, :body)
    end


end
