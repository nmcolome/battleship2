class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @hit = false
  end

  def empty?
    ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @hit
  end

  def fire_upon
    ship.hit if ship
    @hit = true
  end

  def render(option=false)
    if option
      "S"
    elsif !@hit && @ship.nil?
      "."
    elsif @hit && @ship.nil?
      "M"
    elsif @hit && @ship.health > 0
      "H"
    elsif @hit && @ship.health == 0
      "X"
    end
  end
end
