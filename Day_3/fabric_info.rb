class FabricInfo
  attr_accessor :id, :start_point, :width, :height

  def initialize(id, start_point, width, height)
    @id = id
    @start_point = start_point
    @width = width
    @height = height
  end
end
