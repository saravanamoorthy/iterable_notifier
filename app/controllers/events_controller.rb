class EventsController < ApplicationController
		before_action :authendicate_user!

		# create event in Iterable
		def create
			begin
				event = Iterable::Event.create(current_user.email,params[:name])
				if event&.code == "Success"
					redirect_to events_path, notice: "Event created successfully"
				else
					redirect_to events_path, alert: "Unable to create event. #{event&.msg}"
				end
			rescue => e
				redirect_to events_path, alert: "Unable to create event. #{e.message}"
			end
		end
end
