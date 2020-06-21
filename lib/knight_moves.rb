module KnightMoves
    class Square
        attr_accessor :coordinate, :moves
        def initialize(coordinate=[0, 0], moves=[])
            @coordinate = coordinate
            @moves = moves
        end
    end

    class Knight
        attr_accessor :position
        def initialize(position, board=Board.new)
            @position = position
            @board = board
        end

        def possible_moves(moves=[])
            permutations = [1, 2, -1, -2].permutation(2).to_a.filter { |p| p[0].abs != p[1].abs }
            permutations.each do |permutation|
                y = @position[0] + permutation[0]
                x = @position[1] + permutation[1]
                moves << @board.find_by_coordinates([y, x])
            end
            
            moves.filter { |square| square }
        end
    end

    class Board
        attr_reader :squares, :knight
        def initialize(knight=Knight.new([0, 0], self), squares=Array.new(8) {Array.new(8) {Square.new}})
            @knight = knight
            @squares = squares
            set_squares_coordinates
            set_squares_moves
        end

        def find_by_coordinates(array)
            return nil if array[0] < 0 || array[0] > 7 || array[1] < 0 || array[1] > 7
            @squares[array[0]][array[1]]
        end

        def find_path(start, finish, queue=[], visited=[], path=[])
            start_square = find_by_coordinates(start)
            finish_square = find_by_coordinates(finish)
            queue << start_square
            
            until queue.empty? || visited.any? { |square| square == finish_square }
                queue.first.moves.each { |move| queue << find_by_coordinates(move) }
                visited << queue.shift
            end

            current_square = finish_square
            
            until current_square == start_square
                path.unshift(current_square)
                current_square = visited.find { |square| square.moves.include?(current_square.coordinate) }
            end

            path.unshift(start_square)

            path_found_message(start_square, finish_square, path)
        end


        private

        def set_squares_coordinates
            @squares.each_with_index do |row, i|
                row.each_with_index do |square, j|
                    square.coordinate = [i, j]
                end
            end
        end

        def set_squares_moves
            def set_moves(square)
                @knight.position = square.coordinate
                @knight.possible_moves.each { |move| square.moves << move.coordinate }
            end

            @squares.each do |row|
                row.each do |square|
                    set_moves(square)
                end
            end
        end

        def path_found_message(start, finish, path)
            puts "The shortest path from #{start.coordinate} to #{finish.coordinate} takes #{path.length - 1} moves:"
            path.each { |square| puts "[#{square.coordinate.join(", ")}]" }
        end
    end


    def knight_moves(start, finish, board=Board.new)
        board.find_path(start, finish)
    end
end