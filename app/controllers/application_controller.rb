class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
   def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to '/login' unless current_user
  end

  def authenticate_admin!
    unless current_user && current_user.admin
      redirect_to "/"
    end
  end

  def send_message(phone_number, alert_message)
    account_sid = "AC4d7b51eb3dcab7c8352169cdb40a2bb3"
    auth_token = "a7b52ca46178ff7834dc8a9ead766116"

        @client = Twilio::REST::Client.new account_sid, auth_token
        @twilio_number = "16504885975" 
        message = @client.messages.create(
          :from => @twilio_number,
          :to => phone_number,
          :body => alert_message
        )
        puts "sent message to #{message.to}"
    end
end
