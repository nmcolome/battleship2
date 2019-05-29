require './lib/cell'

class Board
  attr_reader :cells

  def initialize(row_number, column_number)
    cell_names = generator(row_number, column_number)
    @cells = {}
    cell_names.each do |cell|
      @cells[cell] = Cell.new(cell)
    end
  end

  def generator(row, column)
    @rows = [*'A'..'Z'][0...row]
    @cols = [*1..column]
    cells = @rows.map do |letter|
      letters = Array.new(@rows.length, letter)
      letters.zip(@cols)
    end
    cells.flatten(1).map { |cell| cell.join('') }
  end

  def valid_coordinate?(coordinate)
    @cells[coordinate] ? true : false
  end

  def valid_placement?(ship, coord)
    if length_matches?(ship, coord) && within_board?(coord)
      rows_and_columns(coord) && overlap?(coord)
    else
      false
    end
  end

  def length_matches?(ship, coordinates)
    ship.length == coordinates.count
  end

  def rows_and_columns(coordinates)
    ranges = coordinates.map { |e| e.split('') }.transpose
    columns = ranges[0]
    rows = ranges[1].map(&:to_i)
    consecutive_coordinates?(rows, columns)
  end

  def consecutive_coordinates?(rows, columns)
    if columns.uniq.count == 1 && consecutive?(@cols, rows)
      true
    elsif rows.uniq.count == 1 && consecutive?(@rows, columns)
      true
    else
      false
    end
  end

  def consecutive?(reference, comparison)
    validation = []
    reference.each_cons(comparison.count) { |a| validation << (comparison == a) }
    validation.any? { |e| e == true }
  end

  def place(ship, coordinates)
    coordinates.each { |coord| @cells[coord].place_ship(ship) }
  end

  def overlap?(coordinates)
    ships = coordinates.map { |coord| @cells[coord].empty? }
    ships.none? { |value| value == false }
  end

  def within_board?(coordinates)
    matches = @cells.keys & coordinates
    matches == coordinates
  end

  def render(option = false)
    table = [' ', 1, 2, 3, 4]
    render_cells(table, option)
    add_new_lines(table)
    table.join(' ')
  end

  def render_cells(table, option = false)
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
