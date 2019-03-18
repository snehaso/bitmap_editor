class Bitmap
    def initialize(max_row, max_column)
        raise ArgumentError.new("wrong row length") if max_row <= 0
        raise ArgumentError.new("wrong row length") if max_column <= 0
        @bitmap = Array.new(max_row) { Array.new(max_column) }
    end  
    
    def max_row_length
        @bitmap.length
    end    

    def max_column_length
        @bitmap.first.length
    end
end    