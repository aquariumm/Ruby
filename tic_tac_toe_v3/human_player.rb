class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        valid = false 
        while !valid
            puts "#@mark's turn. Enter a position in ROW COL format, seperate ROW and COL by a space"
            pos = gets.chomp
            pos = pos.split
            raise ArgumentError.new("Enter two numbers seperated by space, " +
                "the given input has length of " + pos.length.to_s) if pos.length != 2
            
            pos.map! {|n| Integer(n) rescue n} 
            if pos.any? {|x| x.class != Integer}
                res = ""
                res += " row is #{pos[0]} and type is #{pos[0].class.to_s}." \
                    if pos[0].class != Integer
                res += " col is #{pos[1]} and type is #{pos[1].class.to_s}." \
                    if pos[1].class != Integer
                raise TypeError.new("Position needs to be composed by two whole numbers, but" + res)
            end
            if legal_positions.include?(pos)
                valid = true 
            else
                p "Position needs to be from #{legal_positions}"
            end
        end
        pos
    end


end