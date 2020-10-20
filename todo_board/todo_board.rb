require './list.rb'

class TodoBoard
    # def initialize(label)
    #     @list = List.new(label)
    # end

    def initialize
        @hash = Hash.new()
    end

    def get_command
    # perform action based on cmd from user 
        # mklist <new_list_label> : make a new list with the given label
        # ls : print the labels of all lists
        # showall : print all lists
        # mktodo <list_label> <title> <deadline> <optional description> : 
        #    add a new item to the specified list with the given information
        # up <list_label> <index> <optional amount> : raises the todo up the list for the specified item
        # down <list_label> <index> <optional amount> : lowers the todo down the list for the specified item
        # swap <list_label> <index_1> <index_2> : swaps the position of todos
        # sort <list_label> : sorts the todos by date
        # priority <list_label> : prints the todo at the top of the list
        # print <list_label> <optional index> : prints all todos if no index is provided \
        #                         prints full information of the specified todo if an index is provided
        # toggle <list_label> <item_index> : toggle the item state of `done` for the specified item
        # rm <list_label> <item_index> : remove item at index from the list 
        # purge <list_label> : call purge on the list
        # quit

        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when "mklist"
            @hash[args[0]] = List.new(args[0])
        when "ls"
            puts @hash.keys
        when "showall"
            @hash.values.each {|list| list.print}
        when "mktodo"
            @hash[*args[0]].add_item(*args[1..-1])
            # @list.add_item(*args)
        when "up"
            @hash[*args[0]].up(*args[1..-1].map! {|x| x.to_i} )
            # @list.up(*args.map! {|x| x.to_i} )
        when "down"
            @hash[*args[0]].down(*args[1..-1].map! {|x| x.to_i} )
            # @list.down(*args.map! {|x| x.to_i})
        when "swap"
            @hash[*args[0]].swap(*args[1..-1].map! {|x| x.to_i})
            # @list.swap(*args.map! {|x| x.to_i})
        when "sort"
            @hash[*args[0]].sort_by_date!
            # @list.sort_by_date!
        when "priority"
            @hash[*args[0]].print_priority
            # @list.print_priority
        when "print"
            args.length == 1 ? @hash[*args[0]].print : @hash[*args[0]].print_full_item(*args[1].to_i)
            # args.empty? ? @list.print : @list.print_full_item(*args[0].to_i)
        when "toggle"
            @hash[*args[0]].toggle_item(*args[1].to_i)
            # @list.toggle_item(*args[0].to_i)
        when "rm"
            @hash[*args[0]].remove_item(*args[1].to_i)
            # @list.remove_item(*args[0].to_i)
        when "purge"
            @hash[*args[0]].purge
            # @list.purge
        when "quit"
            return false
        else
            print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        res = true
        while res
            res =self.get_command
        end
    end

end