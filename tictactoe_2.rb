class Game
  attr_accessor :board_array
  
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @player1_letter = player_1.player_letter
    @player2_letter = player_2.player_letter
    @current_player_letter = @player2_letter
    @win = 'no'
    @space = 'yes'
  end

  def play_game
    create_board_array
    print_board
    until @win == 'yes' || @space == 'no'
      update_player
      update_array(@current_player_letter, get_input(@current_player_letter).to_i)
      print_board
      check_for_winner(@current_player_letter)
      check_for_full_board
    end

    if @win == 'yes'
      puts "Game over, player #{@current_player_letter} wins!"
    else
      puts "We'll call it a draw!"
    end
  end

  def check_for_full_board
    if ([1,2,3,4,5,6,7,8,9] - board_array) == [1,2,3,4,5,6,7,8,9]
      @space = 'no'
    end
  end

  def check_for_winner(player_letter)
    winning_positions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    player_positions = []

    board_array.each_with_index do |value, index| 
      if value == player_letter
        player_positions << index
      end
    end

    winning_positions.each do |winning_array|
      if (winning_array - player_positions).empty?
        @win = 'yes'
      end
    end
  end

  def update_player
    if @current_player_letter == @player1_letter
      @current_player_letter = @player2_letter
    else
      @current_player_letter = @player1_letter
    end
  end

  def print_num(player)
    puts player.player_letter
  end

  def create_board_array
    @board_array = [0,1,2,3,4,5,6,7,8,9]
  end

  def print_board
    puts ''
    puts "  #{@board_array[1]} | #{@board_array[2]} | #{@board_array[3]}"
    puts '  --+---+--'
    puts "  #{@board_array[4]} | #{@board_array[5]} | #{@board_array[6]}"
    puts '  --+---+--'
    puts "  #{@board_array[7]} | #{@board_array[8]} | #{@board_array[9]}"
    puts ''
  end

  def update_array(player, input)
    board_array[input] = player
  end


  def get_input(player)
    pass = 0
    until pass == 1
      puts "Player #{player}, you're up. Enter an open number."
      begin
        input = Kernel.gets.chomp.match(/^[1-9]{1}$/)[0]
      rescue
        puts 'Try again'
      else 
        if check_available(input) == true
          pass = 1
          return input
        end
      end
    end 
  end

  def check_available(input)
    if board_array[input.to_i] == 'X' || board_array[input.to_i] == 'O'
      false
    else
      true
    end
  end
end


class Player

  attr_reader :player_letter

  def initialize(player_type, player_letter)
    @player_type = player_type
    @player_letter = player_letter
  end
end

class HumanPlayer < Player
end

player_1 = Player.new('human', 'X')
player_2 = Player.new('human', 'O')

new_game = Game.new(player_1, player_2)
new_game.play_game


