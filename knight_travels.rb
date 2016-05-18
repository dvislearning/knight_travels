class Knight
    attr_accessor :start_square, :end_square, :visited, :legacy, :move_list
    def initialize (start_square, end_square)
        @start_square = start_square
        @end_square = end_square
        @visited = []
        visited << start_square
        @legacy = []
        @move_list = [
        [start_square[0]-2, start_square[1]+1],
        [start_square[0]-1, start_square[1]+2],
        [start_square[0]+1, start_square[1]+2],
        [start_square[0]+2, start_square[1]+1],
        [start_square[0]+2, start_square[1]-1],
        [start_square[0]+1, start_square[1]-2],
        [start_square[0]-1, start_square[1]-2],
        [start_square[0]-2, start_square[1]-1]]
    end

    # #breadth first search
    def knight_moves
    		queue = Array.new
        if self.start_square == self.end_square
            self.legacy = [self.start_square]
            display_solution(self.legacy)
            return self.legacy
        end
        current_node = self
        current_node.legacy = [self.start_square]
        loop do
            current_node.move_list.each do | move |
                next if (move[0] < 0) || (move[1] < 0)
                next if current_node.visited.include? move
                new_node = Knight.new(move, current_node.end_square)
                new_node.legacy.push(current_node.legacy)
                new_node.legacy.push(new_node.start_square)
                if move == current_node.end_square
                	display_solution(new_node.legacy.flatten.each_slice(2).to_a)
                	return new_node.legacy.flatten.each_slice(2).to_a
                end
                queue << new_node
            end
            current_node = queue.shift
        end
    end

    def display_solution(moves)
        moves.length == 1 ? s = "" : s = "s"
        puts "You made it in #{moves.length} move#{s}!  Here's your path:"
        moves.each { |move| puts move.inspect}
    end
end


#A new Knight object has to be initialized with a starting square and ending square
#Afterwards, #knight_moves is run to see the path it has to take. 

#Knight.new([3,3], [0,0]).knight_moves
#Knight.new([0,0], [0,0]).knight_moves
#Knight.new([0,0], [5,2]).knight_moves
Knight.new([5,3], [1,3]).knight_moves
#Knight.new([0,0], [1,2]).knight_moves
#Knight.new([0,0], [8,8]).knight_moves