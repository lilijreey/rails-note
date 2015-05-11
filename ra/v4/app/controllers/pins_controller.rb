class PinsController < ApplicationController
  before_action: auth

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params())

    if @pin.save
      redirect_to @pin, notice: "Successfully created new Pin"
    else
      render 'new'
    end
  end

  def show
    @pin = find_pin()
  end

  def edit
    @pin = find_pin()
  end

  def update
    if @pin.update(pin_params())
      redirect_to @pin, notice: 'Pin was Successfully updated!'
    else
      render 'edit'
    end
  end


  def destroy
    @pin = find_pin()
    @pin.destroy
    redirect_to root_path
  end

  ## vote
  def upvote
    @pin = find_pin()
    @pin.upvote_by(current_user)
    redirect_to :back
  end

  def downvote
  end

  private
  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    current_user.pins.find(params[:id])
  end

end
