require_relative 'fabric_data'

class FabricReporter
  attr_accessor :fabric

  def initialize(size)
    @fabric = build_fabric(size)
  end

  def print_fabric
    puts ""
    @fabric.each do |row|
      row_str = ""
      row.each do |point|
        row_str << point
      end
      puts row_str
    end
    puts ""
  end

  def build_fabric(size)
    new_fabric = []

    size.times do
      row = []
      size.times do
        row << "."
      end
      new_fabric << row
    end

    new_fabric
  end

  def update_fabric(info)
    width = info.width.zero? ? 1 : info.width
    height = info.height.zero? ? 1 : info.height

    width.times do |column|
      height.times do |row|
        current_column = column + info.start_point[:x]
        current_row = row + info.start_point[:y]
        spot = @fabric[current_row][current_column]
        @fabric[current_row][current_column] = !spot.eql?(".") ? "X" : info.id.to_s
      end
    end
  end

  def count_overlaps
    count = 0
    @fabric.each do |row|
      row.each do |point|
        count += 1 if point == "X"
      end
    end
    count
  end

  def id_is_overlapping(info)
    total_size = info.height * info.width
    count = 0

    puts "Checking overlap for ID: #{info.id}"

    @fabric.each do |row|
      row.each do |point|
        count += 1 if point == info.id.to_s
      end
    end

    puts "ID #{info.id} has NO OVERLAP!!" if count == total_size
    count < total_size
  end
end
