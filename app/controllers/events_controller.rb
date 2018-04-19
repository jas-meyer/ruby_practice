class EventsController < ApplicationController
	def index
	@user_id = session[:user_id]
	u_state = User.find(session[:user_id]).state
	p u_state
	@events_in = Event.where('state': u_state).includes(:user, :attendees)
	@events_out = Event.where.not('state': u_state).includes(:user, :attendees)
	p @events_out
	@name = User.find(session[:user_id]).first_name

	end
	def create
		 @event = Event.new(event_params)
	  if @event.valid?
	  	@event.save
	  	redirect_to "/events/"
	  else
	  	flash[:errors] = @event.errors.full_messages
	  	p @event.errors.full_messages
      	redirect_to "/events/"
      end
	end

	def show
		event_id = params[:id].to_i
		p event_id
		p event_id.class
		@event = Event.includes(:user).find(event_id)
		@attends = Attendee.includes(:user).where('event_id': event_id)
		@comments = Comment.includes(:user).where('event_id': event_id)
	end
	def edit
		event_id = params[:id].to_i
		@event = Event.find(event_id)
	end

	
	def update
		event_id = params[:id].to_i
		@event = Event.find(event_id)
		valid = @event.update(update_params)
		if valid
	  	redirect_to "/events/"
	  else
	  	flash[:errors] = @event.errors.full_messages
      	redirect_to "/events/#{event_id}/edit"
      end
	end
	def destroy
		event_id = params[:id].to_i
		event = Event.find(event_id)
		event.destroy
		redirect_to "/events"
	end
private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state, :user_id)
    end
    def update_params
    	params.require(:event).permit(:name, :date, :city, :state)
    end	
end
