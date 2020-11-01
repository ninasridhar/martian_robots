class Grid

  MIN_BOUND = 0
  MAX_BOUND = 50

  attr_accessor :x_bound, :y_bound, :protected_bounds

  def initialize(bounds)
    bounds = bounds.split(' ')
    @x_bound = get_bound('X', bounds[0].to_i)
    @y_bound = get_bound('Y', bounds[1].to_i)
    @protected_bounds = []
  end

  def protect_bound(coordinates)
    @protected_bounds.push(coordinates)
  end

  def is_protected?(coordinates)
    @protected_bounds.include?(coordinates)
  end

  private

  def get_bound(axis, bound)
    if bound < MIN_BOUND
      raise StandardError.new "#{axis} bound too small"
    elsif bound > MAX_BOUND
      raise StandardError.new "#{axis} bound too large"
    else
      return bound
    end
  end
end