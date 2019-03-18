require 'spec_helper'
require 'bitmap'

RSpec.describe Bitmap do
    context "new" do
        it "should create an empty bitmap of zie 3 * 4" do
            bitmap = Bitmap.new(3, 4)
            expect(bitmap.max_row_length).to equal(3)
            expect(bitmap.max_column_length).to equal(4)
        end
        
        it "should not accept max row length less than or equal to zero" do
            expect { Bitmap.new(0, 3) }.to raise_error(ArgumentError)
        end    

        it "should not accept max column length less than or equal to zero" do
            expect { Bitmap.new(3, -1) }.to raise_error(ArgumentError)
        end    
    end    
end    