class Item
    def self.valid_date?(date_string)
        yyyy, mm, dd = date_string.split("-")
        if mm.to_i.between?(1, 12) && dd.to_i.between?(1, 31)
            return true
        else
            p "Date should be in format of YYYY-MM-DD"
            return false
        end
    end
    
    attr_reader :done
    attr_accessor :title, :description
    
    def initialize(title, deadline, description)
        raise ArgumentError.new("Invalid deadline") if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = []
    end
    
    def deadline
        @deadline
    end
    
    def deadline=(date)
        raise ArgumentError.new("Invalid deadline") if !Item.valid_date?(date)
        @deadline = date
    end

    def toggle
        # toggle between check mark and empty to indicate done or not done
        @done = @done.empty? ? ["\u2713"] : []
    end
end