class Bitmap
    module COLORS
        WHITE = 'O'
        VALID_RANGE = ('A'..'Z')
    end

    def initialize(max_row, max_column)
        raise ArgumentError.new("wrong row length") if max_row <= 0 || max_row > 250
        raise ArgumentError.new("wrong row length") if max_column <= 0 || max_column > 250
        @bitmap = Array.new(max_row) { Array.new(max_column, COLORS::WHITE) }
    end

    def max_row_length
        @bitmap.length
    end

    def max_column_length
        @bitmap.first.length
    end

    def fetch(row, column)
        @bitmap[row][column]
    end

    def color(row, column, color_alphabet)
        unless COLORS::VALID_RANGE.include?(color_alphabet)
            raise(ArgumentError.new("Wrong color alphabet. should be A...Z"))
        end

        if row < 0 || row > max_row_length
            raise(ArgumentError.new("Wrong row co-ordinate"))
        end

        if column < 0 || column > max_column_length
            raise(ArgumentError.new("Wrong column co-ordinate"))
        end

        @bitmap[row][column] = color_alphabet
    end
end