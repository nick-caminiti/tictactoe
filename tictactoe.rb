# this is board
class Board
  # attr_reader :winner
  @winner = 0

  def self.winner
    @winner
  end

  def self.check_for_space
    @board_positions.key('_')
  end

  def self.create_board
    @board_positions = { a1: '_', b1: '_', c1: '_', a2: '_', b2: '_', c2: '_', a3: '_', b3: '_', c3: '_' }
    @player_positions = {}
  end

  def self.print_board
    puts '  1|2|3'
    puts "a #{@board_positions[:a1]}|#{@board_positions[:a2]}|#{@board_positions[:a3]}"
    puts "b #{@board_positions[:b1]}|#{@board_positions[:b2]}|#{@board_positions[:b3]}"
    puts "c #{@board_positions[:c1]}|#{@board_positions[:c2]}|#{@board_positions[:c3]}"
  end

  def self.create_win_scenario_hash(player)
    @player_positions[player] = @board_positions.select do |_position, value|
      value == player
    end
    @win_scenarios = Hash.new(0)
    @player_positions[player].each do |position, _value|
      @win_scenarios[position] += 1
      @win_scenarios[position[0]] += 1
      @win_scenarios["#{position[1]}row"] += 1
    end
  end

  def self.check_for_winner(player)
    create_win_scenario_hash(player)
    if @win_scenarios.key(3) || @win_scenarios.values_at(:a1, :b2, :c3).sum == 3 || @win_scenarios.values_at(:a3, :b2, :c1).sum == 3
      @winner = 1
    end
  end

  def self.gets_user_input(turn)
    puts "Player #{turn}, you're up!"
    selection = ''
    until check_if_available(selection)
      puts 'Enter selection as numberletter (e.g. a1)'
      selection = gets.chomp
    end
    @board_positions[selection.to_sym] = turn
  end

  def self.check_if_available(selection)
    @board_positions[selection.to_sym] == '_'
  end
end

Board.create_board
Board.print_board

round = 0
turn = 'X'
board_full = 0
until Board.winner >= 1 || board_full >= 1
  turn = if round.even?
           'X'
         else
           'O'
         end
  Board.gets_user_input(turn)
  Board.print_board
  Board.check_for_winner(turn)
  board_full = 1 unless Board.check_for_space
  round += 1
end

if Board.winner >= 1
  puts "Player #{turn} wins!"
else
  puts "We'll call it a draw!"
end
