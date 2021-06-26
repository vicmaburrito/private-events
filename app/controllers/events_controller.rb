class EventsController < ApplicationController
  include EventsHelper
  before_action :set_tweeet, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @events = Event.all
  end

  def show
    @events = Event.find(params[:id])
  end

  def new
    @events = Event.new
  end

  def create
    @events = current_user.events.build(event_params)

    if @events.save
      flash[:success] = "Event '#{@events.name}' created!"
      redirect_to @events
    else
      flash[:alert] = "Some error!"
      render 'new'
    end
  end
end
