require 'spec_helper'
require 'bitmap'

RSpec.describe Bitmap do
    context "new" do
        it "should create an empty bitmap of zie 3 * 4" do
            bitmap = Bitmap.new(3, 4)
            expect(bitmap.max_row_length).to eql(3)
            expect(bitmap.max_column_length).to eql(4)
        end

        it "should not accept max row length less than or equal to zero" do
            expect { Bitmap.new(0, 3) }.to raise_error(ArgumentError)
        end

        it "should not accept max column length less than or equal to zero" do
            expect { Bitmap.new(3, -1) }.to raise_error(ArgumentError)
        end

        it "should not accept max row length greater than 250" do
            expect { Bitmap.new(400, 9) }.to raise_error(ArgumentError)
        end

        it "should not accept max column length greater than 250" do
            expect { Bitmap.new(3, 1000) }.to raise_error(ArgumentError)
        end
    end

    context "clear" do
        it "should set all pixels to white by default" do
            max_row = 3
            max_cloumn = 4
            bitmap = Bitmap.new(max_row, max_cloumn)

            (0..max_row - 1).each do |row|
                (0..max_cloumn - 1).each do |column|
                    expect(bitmap.fetch(row, column)).to eql(Bitmap::COLORS::WHITE)
                end
            end
        end
    end

    context "color" do
        before do
            max_row = 3
            max_cloumn = 4
            @bitmap = Bitmap.new(max_row, max_cloumn)
        end

        it "raise argument error if color alphabet is incorrect" do
            expect { @bitmap.color_pixel(1, 1, "#") }.to raise_error(ArgumentError, "Wrong color alphabet #. should be A...Z")
        end

        it "raise argument error if row co-ordinated are out of range " do
            expect { @bitmap.color_pixel(5, 1, "C") }.to raise_error(ArgumentError, "Wrong row co-ordinate")
        end

        it "raise argument error if column co-ordinated are out of range " do
            expect { @bitmap.color_pixel(3, 5, "C") }.to raise_error(ArgumentError, "Wrong column co-ordinate")
        end

        it "should color pixel" do
            expect(@bitmap.fetch(1, 1)).to eql(Bitmap::COLORS::WHITE)

            @bitmap.color_pixel(1, 1, 'C')

            expect(@bitmap.fetch(1, 1)).to eql('C')
        end

        context "color segment" do
            context "color a verticle segment in a column" do
                context "validations" do
                    it "validates input columns range" do
                        expect {
                            @bitmap.color_verticle_segment(2, 4, 1, 'B')
                        }.to raise_error(ArgumentError, "Wrong column range")

                        expect {
                            @bitmap.color_verticle_segment(2, 1, 1, 'B')
                        }.to raise_error(ArgumentError, "Wrong column range")

                    end

                    it "validates row co-ordinates" do
                        expect {
                            @bitmap.color_verticle_segment(5, 1, 2, 'B')
                        }.to raise_error(ArgumentError, "Wrong row co-ordinate")
                    end
                end

                it "should color a verticle segment in a column" do
                    (1..4).each do |column|
                        expect(@bitmap.fetch(2, column)).to eql(Bitmap::COLORS::WHITE)
                    end

                    @bitmap.color_verticle_segment(2, 1, 4, 'B')

                    (1..4).each do |column|
                        expect(@bitmap.fetch(2, column)).to eql('B')
                    end
                end
            end

            context "color a horizontal segment in a row" do
                context "validations" do
                    it "validates input row range" do
                        expect {
                            @bitmap.color_horizontal_segment(3, 1, 2, 'B')
                        }.to raise_error(ArgumentError, "Wrong row range")

                        expect {
                            @bitmap.color_horizontal_segment(1, 1, 2, 'B')
                        }.to raise_error(ArgumentError, "Wrong row range")
                    end

                    it "validates column co-ordinates" do
                        expect {
                            @bitmap.color_horizontal_segment(1, 3, 5, 'B')
                        }.to raise_error(ArgumentError, "Wrong column co-ordinate")
                    end
                end

                it "should color a horizontal segment in a row" do
                    (1..3).each do |row|
                        expect(@bitmap.fetch(row, 2)).to eql(Bitmap::COLORS::WHITE)
                    end

                    @bitmap.color_horizontal_segment(1, 3, 2, 'B')

                    (1..3).each do |row|
                        expect(@bitmap.fetch(row, 2)).to eql('B')
                    end
                end
            end
        end
    end
end