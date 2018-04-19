class CommentsController < ApplicationController
def create
event_id = params[:id].to_i
user_id = session[:user_id]
	comment = Comment.new
	comment.event_id = event_id
	comment.user_id = session[:user_id]
	comment.content	= params[:event][:comment]
	if comment.valid?
		comment.save
		redirect_to "/events/#{event_id}/"
	else 
		flash[:errors] = comment.errors.full_messages
		redirect_to "/events/#{event_id}/"
	end
end

end
