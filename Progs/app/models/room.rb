class Room < ActiveRecord::Base

  belongs_to :first_user, class_name: "User"
  belongs_to :second_user, class_name: "User"
  has_many :steps

  def step_by_position(pos)
    self.steps.find_by_position(pos)
  end


  def link_empty_game
    if self.second_user == nil
      '/game/'+ self.id.to_s
   # else
    #  '/finish'
    end
  end


  def check_winner
    winner = nil
    drow_check = 0


    @pole = [[self.step_by_position(0),self.step_by_position(1),self.step_by_position(2)],
             [self.step_by_position(3),self.step_by_position(4),self.step_by_position(5)],
             [self.step_by_position(6),self.step_by_position(7),self.step_by_position(8)]
             ]

#----------------diagonal--------------------------------------------

    @pole.each do |row|
      last = nil
      k = 0

      row.each do |step|

        if step
          drow_check += 1
        end

        if step && (last == step.is_cross || last.nil?)
          k += 1
        end

        last = step.is_cross if step
      end

      if k == 3
        winner = row[1].user
        break
      end
    end

#------------------------vertical-------------------------------------

    [0,1,2].each do |index|
      last = nil
      k = 0

      @pole.each do |row|
        step = row[index]
        if step && (last == step.is_cross || last.nil?)
          k += 1
        end
        last = step.is_cross if step
      end
      if k == 3
        winner = @pole[1][index].user
        break
      end

    end

#----------------------diagonali---------------------------------------

    def check_diagonal(decrement)
      _winner = nil
      last = nil
      k = 0
      [0,1,2].each do |index|

        step = @pole[index][(decrement - index).abs]
        if step && (last == step.is_cross || last.nil?)
          k += 1
        end
        last = step.is_cross if step
      end

      _winner = @pole[1][1].user if k == 3
      
      _winner
    end

    if winner.nil?
      winner = check_diagonal(0) || check_diagonal(2)
    end

#---------------------------------------------------------------------
    if drow_check == 9 && winner == nil
      winner = 'Friendship'
    end

    winner

  end


  def symbol_by_position(pos)
    step = self.step_by_position(pos)
    symbol = ''
    if step
      symbol = step.is_cross ? 'x' : 'o'
    end
    symbol
  end

end

