require_relative 'fabric_reporter'
require 'minitest/autorun'

describe "FabricReporter" do
  describe "initialize" do
    it "builds a 10x10 array for a sheet of size 10" do
      subject = FabricReporter.new(10)
      assert_equal 10, subject.fabric.count     # num rows
      assert_equal 10, subject.fabric[0].count  # num columns
    end

    it "builds a 100x100 array for a sheet of size 100" do
      subject = FabricReporter.new(100)
      assert_equal 100, subject.fabric.count     # num rows
      assert_equal 100, subject.fabric[0].count  # num columns
    end
  end

  describe "update fabric" do
    before do
      @subject = FabricReporter.new(5)
    end

    it "updates only rows" do
      info = FabricInfo.new(1, { x: 0, y: 0 }, 4, 0)
      expected = [
        %w[1 1 1 1 .],
        %w[. . . . .],
        %w[. . . . .],
        %w[. . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info)
      assert_equal expected, @subject.fabric
    end

    it "updates only columns" do
      info = FabricInfo.new(1, { x: 0, y: 0 }, 0, 4)
      expected = [
        %w[1 . . . .],
        %w[1 . . . .],
        %w[1 . . . .],
        %w[1 . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info)
      assert_equal expected, @subject.fabric
    end

    it "updates columns and rows" do
      info = FabricInfo.new(1, { x: 0, y: 0 }, 2, 4)
      expected = [
        %w[1 1 . . .],
        %w[1 1 . . .],
        %w[1 1 . . .],
        %w[1 1 . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info)
      assert_equal expected, @subject.fabric
    end

    it "updates columns and rows from a different start point" do
      info = FabricInfo.new(1, { x: 1, y: 1 }, 2, 2)
      expected = [
        %w[. . . . .],
        %w[. 1 1 . .],
        %w[. 1 1 . .],
        %w[. . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info)
      assert_equal expected, @subject.fabric
    end

    it "marks a spot with an X if a spot overlaps" do
      info1 = FabricInfo.new(1, { x: 1, y: 1 }, 2, 2)
      info2 = FabricInfo.new(2, { x: 1, y: 1 }, 0, 2)
      expected = [
        %w[. . . . .],
        %w[. X 1 . .],
        %w[. X 1 . .],
        %w[. . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info1)
      @subject.update_fabric(info2)
      assert_equal expected, @subject.fabric
    end
  end
  
  describe "count overlaps" do
    before do
      @subject = FabricReporter.new(5)
    end

    it "returns 2 if there are 2 overlaps" do
      info1 = FabricInfo.new(1, { x: 1, y: 1 }, 2, 2)
      info2 = FabricInfo.new(2, { x: 1, y: 1 }, 0, 2)
      expected = [
        %w[. . . . .],
        %w[. X 1 . .],
        %w[. X 1 . .],
        %w[. . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info1)
      @subject.update_fabric(info2)
      assert_equal expected, @subject.fabric
      assert_equal 2, @subject.count_overlaps
    end

    it "returns 0 if there are no overlaps" do
      info1 = FabricInfo.new(1, { x: 1, y: 1 }, 2, 2)
      info2 = FabricInfo.new(2, { x: 4, y: 1 }, 0, 2)
      expected = [
        %w[. . . . .],
        %w[. 1 1 . 2],
        %w[. 1 1 . 2],
        %w[. . . . .],
        %w[. . . . .]
      ]

      @subject.update_fabric(info1)
      @subject.update_fabric(info2)
      assert_equal expected, @subject.fabric
      assert_equal 0, @subject.count_overlaps
    end
  end
end
