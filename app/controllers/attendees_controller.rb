class AttendeesController < ApplicationController
	def create
  atten = Attendee.new
  atten.user_id = session[:user_id]
  p session[:user_id].class
  atten.event_id = params[:id]
  p params[:id].class
  p params
  atten.save
  redirect_to "/events/"
  end

  def destroy
  event = params[:id].to_i
  atten = Attendee.where('event_id': event, 'user_id': session[:user_id]).first
  atten.destroy
  redirect_to "/events/"
  end
end
