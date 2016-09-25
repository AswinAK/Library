class RoomController < ApplicationController


  def index
    @rooms = Room.all
  end

  def new
    @member = Room.new
  end

  def create
    @room = Room.new(room_params)
    # Save the object
    if @room.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Room created successfully."
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def delete
    Room.find_by(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  private
  def room_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:room).permit(:room_number,:building,:size)
  end

end