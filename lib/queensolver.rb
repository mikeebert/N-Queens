class QueenSolver
  
  attr_accessor :board
  attr_accessor :size
  attr_accessor :positions
  
  def initialize(n)
    if n > 3 or n == 1
      @size = n
      set_board
      @positions = Array.new
    else
      display_error(n)
    end
  end

  def place_queens
    set_initial_location
    place_next_queen
    #display_board # uncomment this line to display board after queens are placed.
  end
  
  def set_initial_location
    @row = 0; @column = 0
  end
  
  def place_next_queen
    @positions << [@row,@column]
    place_positions unless @positions.empty?
    @row += 1
    @column = 0
    while @positions.count != @size
      while attackable(@row,@column)
        @column += 1 if @column < @size
        while @column > (@size - 1)
          @row = @positions.last[0]
          @column = @positions.last[1] + 1
          @positions.delete_at(@positions.count - 1)
        end
      end
      place_next_queen
    end
  end
  
  def attackable(row_index, column_index)
    if row_is_occupied(row_index) || column_is_occupied(column_index) || diagonal_is_occupied(row_index, column_index)
      return true
    end
  end
  
  def row_is_occupied(row_index)
    rows = @positions.map {|position| position[0]}
    return true if rows.include?(row_index)
  end
  
  def column_is_occupied(column_index)
    coordinates = @positions.map{|position| position[1]}
    return true if coordinates.include?(column_index)
  end
  
  def diagonal_is_occupied(row_index, column_index)
    #check up and back
    row = row_index - 1
    column = column_index - 1
    while row >=0 && column >= 0
      # return true if @positions.include?([row,column])
      return true if @board[row][column] == "Q"
      row -= 1; column -= 1
    end
      
    #check down and forward
    row = row_index + 1
    column = column_index + 1
    while row < @size && column < @size
      # return true if @positions.include?([row,column])
      return true if @board[row][column] == "Q"
      row += 1;column += 1
    end
    
    #check up and forward
    row = row_index - 1
    column = column_index + 1
    while row >= 0 && column < @size
      # return true if @positions.include?([row,column])      
      return true if @board[row][column] == "Q"
      row -= 1;column +=1
    end
    
    #check down and back
    row = row_index + 1
    column = column_index - 1
    while row < @size && column >= 0
      # return true if @positions.include?([row,column])      
      return true if @board[row][column] == "Q"
      row += 1;column -= 1
    end
  end
  
  def display_error(n)
    puts "The N Queens problem is not possible for a #{n} x #{n} board."
  end
  
  def set_board
    @board = Array.new(@size) 
    @board.map! {|row| row = Array.new(@size)}
  end
  
  def place_positions
    set_board
    @positions.each do |coordinates|
      @board[coordinates[0]][coordinates[1]] = "Q"
    end
  end
  
  def display_board
    @board.each do |row|
      puts "#{row} \n"
    end
  end
  
### Lines 125 through 217 are not necessary except for testing purposes. I left them in to show how I started to work on solving it ###
  def solved
    all_queens_placed && attacks_possible != true
  end
  
  def all_queens_placed
    @board.flatten.compact.count.should == @size
  end
  
  def attacks_possible  
    return true if horizontal_attack == true
    return true if vertical_attack == true
    return true if diagonal_attack == true
  end
  
  def horizontal_attack
    @board.each do |row|
      return true if row.compact.count > 1
    end
  end
  
  def vertical_attack
    column_values = (0..(@size-1)).to_a
    column_values.each do |column_position|
      column = @board.map {|row| row[column_position]}
       return true if column.compact.count > 1
     end
  end
  
  def diagonal_attack
    forward_slash_attack_possible == true || backward_slash_attack_possible == true
  end
  
  def forward_slash_attack_possible
    #check from upper left moving right
    column_index = 0
    while column_index < @size
      row = 0
      column = column_index
      slash = []
      while row < @size && column < @size
        slash << @board[row][column]
        return true if slash.compact.count > 1
        row += 1;column += 1
      end
      column_index += 1
    end
    
    #check from upper left moving down
    row_index = 0
    while row_index < @size
      column = 0
      row = row_index
      slash = []
      while row < @size && column < @size
        slash << @board[row][column]
        return true if slash.compact.count > 1
        row += 1;column += 1
      end
      row_index += 1
    end
  end
  
  def backward_slash_attack_possible
    #check from the end of the first row moving left
    column_index = @size - 1 
    while column_index > 0
      row = 0
      column = column_index
      slash = []
      while column >= 0 && row < @size
        slash << @board[row][column]
        return true if slash.compact.count > 1
        row += 1; column -= 1
      end
      column_index -= 1
    end
    
    #check from the end of the first row moving down
    row_index = 0
    while row_index < @size
      row = row_index
      column = @size - 1
      slash = []
      while row < @size && column >= 0
        slash << @board[row][column]
        return true if slash.compact.count > 1
        row += 1; column -= 1
      end
      row_index += 1
    end
  end
      
end