class ProfilesController < ApplicationController
  before_action :authorize

  def show
    if current_user.profile.nil?
      redirect_to new_user_profile_path(@current_user), notify: 'You have not set profile'
    else
      @profile = current_user.profile
      render 'show'
    end
  end
  
  def new
    @profile = @current_user.build_profile
  end

  def create
    @profile = @current_user.build_profile(params_profile())
    if @profile.save
      redirect_to root_path, notice: 'Create profile successfully'
    else
      redirect_to new_user_profile_path(@current_user), alert: 'Create profile failed'
    end
  end


  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.build_profile(params_profile())

    if @profile.save
      redirect_to root_path, notice: 'Update profile successfully'
    else
      redirect_to edit_user_profile_path(@current_user), alert: 'Update profile failed'
    end

  end

  def destroy
  end

  private
  def params_user
    @user = User.find(params[:user_id])
  end

  def params_profile
    params.require(:profile).permit(:name, :qq, :birthday)
  end

end
