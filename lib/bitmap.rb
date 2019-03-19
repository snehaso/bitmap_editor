class Bitmap
    module COLORS
        WHITE = 'O'
        VALID_RANGE = ('A'..'Z')
    end

    module COORDINATES
        MAX = 250
        MIN = 1
    end

    def initialize(max_row, max_column)
        raise ArgumentError.new("wrong row length") if max_row <= 0 || max_row > 250
        raise ArgumentError.new("wrong column length") if max_column <= 0 || max_column > 250
        @bitmap = Array.new(max_row) { Array.new(max_column, COLORS::WHITE) }
    end

    def max_row_length
        @bitmap.length
    end

    def max_column_length
        @bitmap.first.length
    end

    def fetch(row, column)
        @bitmap[row -1][column - 1]
    end

    def color_pixel(row, column, color)
        validate_color(color)
        validate_row_coordinate(row)
        validate_column_coordinate(column)

        @bitmap[row -1 ][column - 1] = color
    end

    def color_verticle_segment(row, cloumn_1, column_2, color_alphabet)
        validate_color(color)
        validate_row_coordinate(row)
        validate_column_coordinate(column_1)
        validate_column_coordinate(column_2)

        #color the column
    end

    private
    def validate_color(color)
        unless COLORS::VALID_RANGE.include?(color)
            raise(ArgumentError.new("Wrong color alphabet #{color}. should be A...Z"))
        end
    end

    def validate_row_coordinate(row)
        if row <= 0 || row > max_row_length
            raise(ArgumentError.new("Wrong row co-ordinate"))
        end
    end

    def validate_column_coordinate(column)
        if column <= 0 || column > max_column_length
            raise(ArgumentError.new("Wrong column co-ordinate"))
        end
    end
end