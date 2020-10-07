require './board.rb'
require './human_player'
require './computer_player'

class Game
    def initialize(size, player_mark)
        @player_list = player_mark.map {|mark, indicator| indicator ? ComputerPlayer.new(mark) : HumanPlayer.new(mark)}
        @current_player = @player_list[0]
        @board = Board.new(size)
    end

    def switch_turn
        @current_player = @player_list.rotate![0]
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_player.get_position(@board.legal_positions)
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                p 'victory: ' + @current_player.mark.to_s
                return 
            else
                self.switch_turn
            end
        end
        p 'Result: draw'
    end

end