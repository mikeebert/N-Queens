class QueenSolver
  
  attr_accessor :board
  attr_accessor :size
  attr_accessor :positions
  attr_accessor :row
  attr_accessor :column
  
  def initialize(n)
    if n > 3 or n == 1
      @size = n
      set_board
      set_initial_location
      @positions = Array.new
    else
      display_error(n)
    end
  end
  
  def set_initial_location
    @row = 0; @column = 0
  end

  def place_queens
    place_next_queen
    # display_board
  end
  
  def place_next_queen
    @positions << [@row,@column]
    place_positions unless @positions.empty?
    @row += 1
    @column = 0
    coordinates_for_next_move unless @positions.count == @size
  end
  
  def coordinates_for_next_move
    while attackable(@row,@column)
      @column += 1 if @column < @size
      if @column == @size
        if @positions.map{|coordinates| coordinates[1] == (@size - 1)}.include?(true)
          move_at_end_of_row = @positions.index{|column| column[1] == (@size-1)}
          positions_to_delete = (move_at_end_of_row..(@positions.count-1)).to_a
          positions_to_delete.reverse.each {|index| @positions.delete_at(index)}
          @row = @positions.last[0]
          @column = @positions.last[1] + 1
          @positions.delete_at(@positions.count - 1)
          # place_positions #toggling this comment fixes n=16; BREAKS 17 through 20
        else
          @row = @positions.last[0]
          @column = @positions.last[1] + 1
          @positions.delete_at(@positions.count - 1)
          place_positions #uncommenting this fixes 16,18,19;BREAKS 17,20
        end
      end
    end
    place_next_queen
  end
  
  def attackable(row_index, column_index)
    return true if row_is_occupied(row_index)
    return true if column_is_occupied(column_index)
    return true if diagonal_is_occupied(row_index, column_index)
  end
  
  def row_is_occupied(row_index)
    rows = @positions.map {|position| position[0]}
    return true if rows.include?(row_index)
    # row = @board[row_index]
    # return true if row.compact.count > 1
  end
  
  def column_is_occupied(column_index)
    coordinates = @positions.map{|position| position[1]}
    return true if coordinates.include?(column_index)
    # column = @board.map {|row| row[column_index]}
    # return true if column.compact.count > 0
  end
  
  # def diagonal_is_occupied(row_index, column_index)
  #   #check up and back
  #   row = row_index - 1
  #   column = column_index - 1
  #   while row >=0 && column >= 0
  #     return true if @positions.include?([row,column])
  #     row -= 1; column -= 1
  #   end
  # 
  #   #check down and forward
  #   row = row_index + 1
  #   column = column_index + 1
  #   while row < @size && column < @size
  #     return true if @positions.include?([row,column])
  #     row += 1;column += 1
  #   end
  # 
  #   #check up and forward
  #   row = row_index - 1
  #   column = column_index + 1
  #   while row >= 0 && column < @size
  #     return true if @positions.include?([row,column])
  #     row -= 1;column +=1
  #   end
  # 
  #   #check down and back
  #   row = row_index + 1
  #   column = column_index - 1
  #   while row < @size && column >= 0
  #     return true if @positions.include?([row,column])
  #     row += 1;column -= 1
  #   end
  # end
  
  def diagonal_is_occupied(row_index, column_index)
    #check up and back
    row = row_index - 1
    column = column_index - 1
    while row >=0 && column >= 0
      return true if @board[row][column] == "Q"
      row -= 1; column -= 1
    end
  
    #check down and forward
    row = row_index + 1
    column = column_index + 1
    while row < @size && column < @size
      return true if @board[row][column] == "Q"
      row += 1;column += 1
    end
    
    #check up and forward
    row = row_index - 1
    column = column_index + 1
    while row >= 0 && column < @size
      return true if @board[row][column] == "Q"
      row -= 1;column +=1
    end
    
    #check down and back
    row = row_index + 1
    column = column_index - 1
    while row < @size && column >= 0
      return true if @board[row][column] == "Q"
      row += 1;column -= 1
    end
  end
  
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
      if row.compact.count > 1
        return true 
      end
    end
  end

  def vertical_attack
    column_values = (0..(@size-1)).to_a
    column_values.each do |column_position|
      column = @board.map {|row| row[column_position]}
       if column.compact.count > 1
         return true
       end
     end
  end
  
  def diagonal_attack
    if forward_slash_attack == true
      return true
    elsif backward_slash_attack == true
      return true
    end
  end
  
  def forward_slash_attack
    columns = (0..(@size-2)).to_a    
    columns.each do |column|
      row_index = 0
      column_index = column
      forward_slash = []
      (@size - column_index).times do
        forward_slash << @board[row_index][column_index]
        return true if forward_slash.compact.count > 1
        row_index += 1
        column_index += 1
      end
    end
    
    rows = (0..(@size-2)).to_a
    rows.each do |row|
      row = row; column = 0
      forward_slash = []
      (@size - row).times do
        forward_slash << @board[row][column]
        return true if forward_slash.compact.count > 1
        row += 1
        column += 1
      end
    end
  end
  
  def backward_slash_attack
    columns = (1..(@size-1)).to_a
    columns.reverse.each do |column|
      row = 0; column = column
      backward_slash = []
      (column + 1).times do
        backward_slash << board[row][column]        
        return true if backward_slash.compact.count > 1
        row += 1
        column -= 1
      end
    end
    
    rows = (0..(@size-2)).to_a
    rows.each do |row|
      row = row; column = (@size - 1)
      backward_slash = []
      (@size - row).times do
        backward_slash << @board[row][column]
        return true if backward_slash.compact.count > 1       
        row += 1
        column -= 1
      end
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
    # print "The positions are: #{positions} \n"
    @positions.each do |coordinates|
      @board[coordinates[0]][coordinates[1]] = "Q"
    end
  end
  
  def display_board
    @board.each do |row|
      puts "#{row} \n"
    end
  end
end