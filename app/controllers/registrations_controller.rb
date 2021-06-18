class RegistrationsController < Devise::RegistrationsController
  include UsersHelper
  before_action :require_login, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    flash.notice = "User #{@user.name} successfully created! Thank you for signing up!"
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
  end


    private
  
    def sign_up_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end
  
    def account_update_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
    end
  end
  