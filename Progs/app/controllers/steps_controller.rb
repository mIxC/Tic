class StepsController < ApplicationController
  include ActionController::Live
  ##require "thread"

  def create
    step = Step.create(room_id: params[:room_id], user: current_user, is_cross: params[:symbol] == 'x', position: params[:position])

    respond_to do |format|
      result = {ok: true, winner: step.room.check_winner}
      if result[:winner]
        result[:winner].wins += 1
        result[:winner].save
        #step.room.ending = true
        #step.room.save
      end
      format.json  { render :json => result } # don't do msg.to_json
    end
  end


  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    #Thread.new {
      begin
        Step.on_change do |data|
          Rails.logger.debug "Step change in steps#index"
          sse.write(data)
        end
      rescue IOError
        # Client Disconnected
      ensure
        sse.close
      end
    #}
    render nothing: true
  end
end
