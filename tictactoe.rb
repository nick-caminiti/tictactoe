# this is board
class Board
  def self.create_board
    @board_positions = { a1: 'X', b1: 'X', c1: 'X', a2: '_', b2: 'X', c2: 'O', a3: '_', b3: ' ', c3: 'X' }
    @player_positions = {}
  end

  def self.print_board
    puts '  a|b|c'
    puts "1 #{@board_positions[:a1]}|#{@board_positions[:b1]}|#{@board_positions[:c1]}"
    puts "2 #{@board_positions[:a2]}|#{@board_positions[:b2]}|#{@board_positions[:c2]}"
    puts "3 #{@board_positions[:a3]}|#{@board_positions[:b3]}|#{@board_positions[:c3]}"
  end

  def self.update_board
    # update board
  end

  def self.check_for_winner(player)
    @player_positions[player] = @board_positions.select do |position, value|
      value == player
    end
    @win_scenarios = Hash.new(0)
    @player_positions[player].each do |position, _value|
      @win_scenarios[position] += 1
      @win_scenarios[position[0]] += 1
      @win_scenarios["#{position[1]}row"] += 1
    end
    puts @win_scenarios.key(3)
    puts @win_scenarios.values_at(:a1, :b2, :c3).sum == 3
    puts @win_scenarios.values_at(:a3, :b2, :c1).sum == 3
  end

  def self.gets_user_input(turn)
    puts "Player #{turn}, you're up!"
    selection = gets.chomp
    @board_positions[selection.to_sym] = turn
  end
end

Board.create_board
Board.print_board
Board.check_for_winner('X')
# Board.check_for_winner('O')
# Board.gets_user_input('X')
# Board.print_board
# Board.check_for_winner

# places a player move on the board
class Position < Board
  def initialize(player, xcoordinate, ycoordinate)
    @player = player
    @xcoordinate = xcoordinate
    @ycoordinate = ycoordinate
  end

  def self.gets_user_input(turn)
    puts "Player #{turn}, you're up!"
    selection = gets.chomp
    @board_positions[selection.to_sym] = turn
  end
end



# creates the playes 
class Player
  def initialize(char)
    @char = char
  end
end


# can't overwrite
# regex for input