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

  def valid_placement?(ship, coord)
    length_matches?(ship, coord) && rows_and_columns(coord) && overlap?(coord)
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
    validation = []
    letters.each_cons(columns.count) { |a| validation << (columns == a)}
    validation.any? { |e| e == true}
  end

  def consecutive_rows?(rows)
    differences = []
    rows[0...-1].each_with_index do |r, i|
      differences << (rows[i+1] - r)
    end
    differences.all? { |e| e == 1}
  end

  def place(ship, coordinates)
    coordinates.each { |coord| @cells[coord].place_ship(ship) }
  end

  def overlap?(coordinates)
    ships = coordinates.map { |coord| @cells[coord].empty? }
    ships.none? { |value| value == false }
  end

  def render(option=false)
    table = [" ", 1, 2, 3, 4]
    render_cells(table, option)
    add_new_lines(table)
    table.join(" ")
  end

  def render_cells(table, option=false)
    %w[A B C D].each do |row|
      table << row
      @cells.each do |key, value|
        table << value.render(option) if key.include?(row)
      end
    end
  end

  def add_new_lines(table)
    table.each_with_index do |element, index|
      table[index] = "\n" + element if %w[A B C D].include?(element)
    end
    table << "\n"
  end
end
