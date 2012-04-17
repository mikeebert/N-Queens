#this checks the board if a row is occupied
def row_is_occupied
  row = @board[row_index]
  return true if row.compact.count > 1  
end

#this checks the board if a column is occupied (instead of positions)
def column_is_occupied
  column = @board.map {|row| row[column_index]}
  return true if column.compact.count > 0  
end


#This checks the positions for diagonal is occupied
def diagonal_is_occupied(row_index, column_index)
  #check up and back
  row = row_index - 1
  column = column_index - 1
  while row >=0 && column >= 0
    return true if @positions.include?([row,column])
    row -= 1; column -= 1
  end

  #check down and forward
  row = row_index + 1
  column = column_index + 1
  while row < @size && column < @size
    return true if @positions.include?([row,column])
    row += 1;column += 1
  end

  #check up and forward
  row = row_index - 1
  column = column_index + 1
  while row >= 0 && column < @size
    return true if @positions.include?([row,column])
    row -= 1;column +=1
  end

  #check down and back
  row = row_index + 1
  column = column_index - 1
  while row < @size && column >= 0
    return true if @positions.include?([row,column])
    row += 1;column -= 1
  end
end