class RoomsController < ApplicationController
  include UsersHelper

  def index
    @rooms = Room.all
  end


  def new
    @room = Room.create(first_user: current_user)
    redirect_to '/game/' + @room.id.to_s
  end


  def show
    @room = Room.find_by_id(params[:id])

    if @room.first_user.id != current_user.id
      @room.second_user = current_user
    end
    @room.save
  end


  def number_of_user #---Who first step--------
    @room = Room.find_by_id(params[:room_id])
    result = nil

    if @room.first_user.id == current_user.id #--(first_user = x - first step)
      result = {number: '1', symbol: 'x'}
    end

    if @room.second_user.id == current_user.id
      result = {number: '2', symbol: 'o'}
    end

    respond_to do |format|
      format.json  { render :json => result } # don't do msg.to_json
    end
  end

end

##----------------------------------------------------------------------------------##


