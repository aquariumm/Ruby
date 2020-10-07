class Board
    def initialize(size)
        # set size of the grid
        @grid = Array.new(size) {Array.new(size) {"_"}}
    end

    def valid?(pos)
    # check if pos is valid to the grid
        pos[0].between?(0, @grid.length-1) \
            && pos[1].between?(0, @grid[0].length-1)
    end

    def empty?(pos)
    # check if the pos on the grid is empty
        row = pos[0]
        col = pos[1]
        if row >= @grid.length || col >= @grid[0].length
            res = []
            res << "Row #{row} exceed size limit #{@grid.length}" if row >= @grid.length
            res << "Col #{col} exceed size limit #{@grid[0].length}" if col >= @grid[0].length
            raise ArgumentError.new(res)
        end
        @grid[pos[0]][pos[1]] == "_"
    end

    def place_mark(position, mark)
    # place mark on the given position
        if  !valid?(position) || !empty?(position) 
            raise RuntimeError.new("invalid mark")
        else
            @grid[position[0]][position[1]] = mark
        end
    end
    
    def print
    # print the grid
        @grid.each {|row| p row}
    end

    def win_row?(mark)
        @grid.each do |row|
            return true if 0.upto(row.length-1).all? \
                { |i| row[i] == mark } == true
        end
        false
    end

    def win_col?(mark)
        (0...@grid[0].length).each do |col|
            return true if (0...@grid.length).all? \
                {|row| @grid[row][col] == mark}
        end
        false
    end

    def win_diagonal?(mark)
        dia1 = []
        dia2 = []
        (0...@grid.length).each do |row|
            (0...@grid[0].length).each do |col|
                dia1 << @grid[row][col] if row + col == @grid.length - 1
                dia2 << @grid[row][col] if row == col
            end
        end
        dia1.uniq == [mark] || dia2.uniq == [mark]
    end

    def win?(mark)
    # if player with the given mark has won the game
        self.win_col?(mark) || self.win_diagonal?(mark) || self.win_row?(mark)
    end

    def empty_positions?
        @grid.flatten.uniq.include?("_")
    end

    def legal_positions
    # return an array containing all empty positions from the grid 
        res = []
        (0...@grid.length).each do |r_pos|
            (0...@grid[0].length).each do |c_pos|
                res << [r_pos, c_pos] if empty?([r_pos, c_pos])
            end
        end
        res
    end

end