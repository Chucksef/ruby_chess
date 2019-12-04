require "./lib/game"

RSpec.describe Game do
    describe "#validate_coords" do
      it "returns valid coords if upper or lower case used" do
        game = Game.new
        expect(game.validate_coords("a7")).to eql([0,6])
        expect(game.validate_coords("B2")).to eql([1,1])
      end
      it "returns false if an invalid letter is used" do
        game = Game.new
        expect(game.validate_coords("j1")).to eql(false)
      end
      it "returns false if an invalid number is used" do
        game = Game.new
        expect(game.validate_coords("c9")).to eql(false)
        expect(game.validate_coords("g0")).to eql(false)
      end
      it "returns false if more than three characters are used" do
        game = Game.new
        expect(game.validate_coords("ba2")).to eql(false)
      end
      it "returns false if user enters values in wrong order" do
        game = Game.new
        expect(game.validate_coords("2b")).to eql(false)
      end
      it "returns false if user enters two numbers" do
        game = Game.new
        expect(game.validate_coords("26")).to eql(false)
      end
      it "returns false if user enters two letters" do
        game = Game.new
        expect(game.validate_coords("AG")).to eql(false)
      end
      it "returns false if too few values are entered" do
        game = Game.new
        expect(game.validate_coords("a")).to eql(false)
      end
    end
  end