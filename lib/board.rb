require './lib/cell'
require './lib/ship'
require 'pry'

class Board
  attr_reader :cells

  def initialize
    @cells = {
                "A1" => Cell.new("A1"),
                "A2" => Cell.new("A2"),
                "A3" => Cell.new("A3"),
                "A4" => Cell.new("A4"),
                "B1" => Cell.new("B1"),
                "B2" => Cell.new("B2"),
                "B3" => Cell.new("B3"),
                "B4" => Cell.new("B4"),
                "C1" => Cell.new("C1"),
                "C2" => Cell.new("C2"),
                "C3" => Cell.new("C3"),
                "C4" => Cell.new("C4"),
                "D1" => Cell.new("D1"),
                "D2" => Cell.new("D2"),
                "D3" => Cell.new("D3"),
                "D4" => Cell.new("D4")
              }
  end

  def valid_coordinate?(coordinate)
    @cells[coordinate] ? true : false
  end

  def valid_placement?(ship, coordinates)
    length_matches?(ship, coordinates) && rows_and_columns(coordinates)
  end

  def length_matches?(ship, coordinates)
    ship.length == coordinates.count
  end

  def rows_and_columns(coordinates)
    ranges = coordinates.map {|e| e.split("")}.transpose
    columns = ranges[0]
    rows = ranges[1].map { |row| row.to_i }
    consecutive_coordinates?(rows, columns)
  end

  def consecutive_coordinates?(rows, columns)
    if columns.uniq.count == 1 && consecutive_rows?(rows)
      true
    elsif rows.uniq.count == 1 && consecutive_columns?(columns)
      true
    else
      false
    end
  end

  def consecutive_columns?(columns)
    letters = @cells.keys.map { |e| e.split("") }.transpose[0].uniq
    starting_letter_index = letters.index(columns[0])
    model = letters.slice(starting_letter_index, columns.length)
    columns == model
  end

  def consecutive_rows?(rows)
    differences = rows[0...rows.length-1].each_with_index { |r, i| rows[i+1] - r }
    differences.all? { |e| e == 1}
  end
end