class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params())
    if @user.save
      sesion[:user_id] = @user.id
      redirect_to users_path, notice: 'Create User successfuled'
    else
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :admin, :password, :password_confirmation)
  end


end
