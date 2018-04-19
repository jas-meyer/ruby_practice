class SessionsController < ApplicationController
skip_before_action :require_login
def create
      email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_email(email)
    if @user != nil  
      if (@user.authenticate(password))
        session[:user_id] = @user.id
      redirect_to "/events/"
      else
        flash[:errors] = ['Invalid Combination']
        redirect_to ''
      end
    else
      flash[:errors] = ['Invalid Combination']
      redirect_to ''
    end
  end
  def destroy
       
          session.delete(:user_id)
          redirect_to ''
        
   end
end
