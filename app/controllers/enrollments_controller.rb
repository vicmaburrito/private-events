class EnrollmentsController < ApplicationController
  before_action :require_login

  def create
    event = Event.find(params[:event_id])
    enrollment = Enrollment.new(event_id: event.id, user_id: params[:user_id])

    if enrollment.save
      enrollment.invited!
      flash[:notice] = "Invitation sent!"
      redirect_to users_path(event_id: event.id)
    else
      flash[:alert] = 'Ooops! Something went wrong...'
      redirect_to event_path(event)
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    enrollment = Enrollment.find(params[:id])
    if current_user == event.creator
      enrollment.destroy
      flash[:notice] = "The invitation is cancelled!"
    else
      enrollment.invited!
      # enrollment.save
      flash[:notice] = "You have dropped the enrollment for the #{event.name}!"
    end

    redirect_to users_path(event_id: event.id, id: enrollment.id)
  end

  def update
    @event = Event.find(params[:event_id])
    @enrollment = Enrollment.find_by(event_id: params[:event_id], user_id: current_user.id)
    if @enrollment && @enrollment.invited?
      @enrollment.accepted!
      flash[:notice] = "Thank you for signing up for the '#{@event.name}'!"
    else
      flash[:alert] = 'Your name is not on the invitation list'
    end

    redirect_to event_path(@event)
  end
  
  
  # # scaffold controller
  # before_action :set_enrollment, only: %i[ show edit update destroy ]

  # # GET /enrollments or /enrollments.json
  # def index
  #   @enrollments = Enrollment.all
  # end

  # # GET /enrollments/1 or /enrollments/1.json
  # def show
  # end

  # # GET /enrollments/new
  # def new
  #   @enrollment = Enrollment.new
  # end

  # # GET /enrollments/1/edit
  # def edit
  # end

  # # POST /enrollments or /enrollments.json
  # def create
  #   event = Event.find(params[:event_id])
  #   @enrollment = Enrollment.new(enrollment_params)

  #   respond_to do |format|
  #     if @enrollment.save
  #       format.html { redirect_to @enrollment, notice: "Enrollment was successfully created." }
  #       format.json { render :show, status: :created, location: @enrollment }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @enrollment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /enrollments/1 or /enrollments/1.json
  # def update
  #   respond_to do |format|
  #     if @enrollment.update(enrollment_params)
  #       format.html { redirect_to @enrollment, notice: "Enrollment was successfully updated." }
  #       format.json { render :show, status: :ok, location: @enrollment }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @enrollment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /enrollments/1 or /enrollments/1.json
  # def destroy
  #   @enrollment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_enrollment
  #     @enrollment = Enrollment.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def enrollment_params
  #     params.require(:enrollment).permit(:user_id, :event_id)
  #   end
end
