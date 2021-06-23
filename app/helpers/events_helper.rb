module EventsHelper
  def event_params
    params.require(:event).permit(:name, :start_date, :location, :description, :user_id)
  end
end
