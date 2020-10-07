class ComputerPlayer
    attr_reader :mark
    
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        rand_pos = rand(0...legal_positions.length)
        chosen_pos = legal_positions[rand_pos]
        puts "#@mark's turn. Chose #{chosen_pos.to_s}"
        chosen_pos
    end

end