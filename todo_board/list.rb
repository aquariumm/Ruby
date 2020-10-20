require './item.rb'

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description="")
    # add item to instance variable `items`, return false if invalid date. If added successfully, return true
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
    # return the number of items in the list
        @items.length
    end

    def valid_index?(index)
    # if index is valid to the current list
        if index < 0 || index > self.size - 1
            p "#{index} is out of list range #{(0...self.size)}"
            false
        else
            true
        end
    end

    def swap(index_1, index_2)
    # swap two index if valid and return true. else return false
        return false if !self.valid_index?(index_1) || !self.valid_index?(index_2)    
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
    # access the list
        return nil if !self.valid_index?(index)
        @items[index]
    end

    def priority
    # first item in the list
        @items.first
    end

    def print
    # print the list with `label`
        res = []
        index_len = 10
        title_len = (@items.map {|item| item.title.length}).max  + 5 rescue 20
        deadline_len = (@items.map {|item| item.deadline.length}).max + 5 rescue 20
        done_len = 5
        dash = "-" * (index_len + title_len + deadline_len + done_len) rescue 100
        
        total_len = index_len + title_len + deadline_len + done_len rescue 100

        res << dash 
        res << self.label.center(total_len)
        res << dash 
        res << ["Index".ljust(index_len), "Item".ljust(title_len), "Deadline".ljust(deadline_len), \
                    "Done?".ljust(done_len)].join("| ")
        res << dash
        @items.each_with_index do |item, ind|
            res << [ind.to_s.ljust(index_len), item.title.ljust(title_len), \
                item.deadline.ljust(deadline_len), item.done[0]].join("| ")
        end
        res << dash

        puts res
    end

    def print_full_item(index)
    # print item at the given index from the list with full information
        if self.valid_index?(index)
            res = []
            item = self[index]
            total_len = item.title.length + item.description.length + item.deadline.length + \
                        item.done.length + 10
            res << "-" * total_len << [item.title, item.description, item.deadline, item.done].join(" | ")\
                << "-" * total_len
            puts res
        end
    end

    def print_priority
    # print the first item in the list with full information
        self.print_full_item(0)
    end

    def up(index, amount=1) 
        return false if !self.valid_index?(index)
        return true if index == 0

        while amount > 0
            break if index == 0
            swap(index, index - 1)
            index -= 1
            amount -= 1
        end
        true
    end

    def down(index, amount=1)
        return false if !self.valid_index?(index)
        return true if index == self.size - 1

        while amount > 0
            break if index == self.size - 1
            swap(index, index + 1)
            index += 1
            amount -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        return false if !self.valid_index?(index)
        self[index].toggle
    end

    def remove_item(index)
        # remove the item from the list at index
        return false if !self.valid_index?(index)

        @items.delete_at(index)       
        true
    end

    def purge
        # remove all items that are done
        i = 0
        while i < self.size
            if !@items[i].done.empty?
                @items.delete_at(i)
                # p (@items[i])
            else
                i += 1
            end
        end
    end

end