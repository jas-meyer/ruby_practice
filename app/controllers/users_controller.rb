class UsersController < ApplicationController
	skip_before_action :require_login, except: [:show,:edit,:update]
	before_action :check_session, except: [:new, :create, :index]
	def index
		user_id = session[:user_id]
		@users = User.where.not('id': user_id)
		@user = User.find(current_user)
		@followers = @user.followers
		@following = @user.following

	end
	def new

	end
	def create
	  @user = User.new(user_params)
	  if @user.valid?
	  	@user.save
	  	session[:user_id] = @user.id
	  	redirect_to "/events/"
	  else
	  	flash[:errors] = @user.errors.full_messages
      	redirect_to ''
      end
	end 
	def show

	end
	def edit
		@user = User.find(session[:user_id])
	end
	def update
		@user = User.find(session[:user_id])
		valid = @user.update(user_params)
		if valid
	  	redirect_to "/events/"
	  else
	  	flash[:errors] = @user.errors.full_messages
      	redirect_to "/users/#{session[:user_id]}/edit"
      end
	end
	private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end
    def check_session
      id = params[:id].to_i 
      if session[:user_id] != id 
        user_id = session[:user_id]
        redirect_to "/users/#{user_id}"
      end  
    end
end
