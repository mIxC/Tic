class Step < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  after_create :notify_step_added

  class << self
    def on_change

      Rails.logger.debug "call on_change in model"
      Step.connection.execute "LISTEN steps"
      loop do

        Rails.logger.debug "loop on_change"
        Step.connection.raw_connection.wait_for_notify do |event, pid, step|
          yield step
        end
      end
    ensure
      Step.connection.execute "UNLISTEN steps"
    end
  end


  def basic_info_json
    {user_name: self.user.user_name,winner: self.room.check_winner, position: self.position, symbol: self.is_cross ? 'x' : 'o'}.to_json
  end

  private

  def notify_step_added
    Step.connection.execute "NOTIFY steps, '#{self.basic_info_json}'"
  end

end
