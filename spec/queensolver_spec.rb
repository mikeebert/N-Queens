require 'queensolver'

describe "Solving the N Queens Puzzle" do
  
  describe "setting up the board" do
    it "should create a board for 1" do
      @queen_solver = QueenSolver.new(1)
      @queen_solver.board.should == [[nil]]
    end

    it "should create a board for any number greater than 3" do
      @queen_solver2 = QueenSolver.new(4)
      @queen_solver2.board.should == [[nil,nil,nil,nil],
                                     [nil,nil,nil,nil],
                                     [nil,nil,nil,nil],
                                     [nil,nil,nil,nil]]
    end
    
    it "should set Queens from an array of positions" do
      @queen_solver = QueenSolver.new(4)
      @queen_solver.positions = [[0,0],[0,3],[3,0],[3,3]]
      @queen_solver.place_positions
      @queen_solver.board.should == [["Q",nil,nil,"Q"],
                                     [nil,nil,nil,nil],
                                     [nil,nil,nil,nil],
                                     ["Q",nil,nil,"Q"]]
    end
  end
  
  describe "checking for attacks" do
    before(:each) do
      @queen_solver = QueenSolver.new(4)
    end
    
    it "should know if a horizontal attack is possible" do
      @queen_solver.board[0] = ["Q","Q",nil,nil]
      @queen_solver.horizontal_attack.should == true
      @queen_solver.attacks_possible.should == true
    end
    
    it "should know if a vertical attack is possible" do
      @queen_solver.board[0][0] = "Q"
      @queen_solver.board[1][0] = "Q"
      @queen_solver.vertical_attack.should == true
      @queen_solver.attacks_possible.should == true
    end
    
    it "should catch a forward-slash diagonal attack in a top corner" do
      @queen_solver.board = [[nil,nil,"Q",nil],
                             [nil,nil,nil,"Q"],
                             [nil,nil,nil,nil],
                             [nil,nil,nil,nil]]
      @queen_solver.forward_slash_attack.should == true
      @queen_solver.attacks_possible.should == true
    end
    
    it "should catch a forward-slash diagonal attack in a bottom corner" do
      @queen_solver.board = [[nil,nil,nil,nil],
                             ["Q",nil,nil,nil],
                             [nil,nil,nil,nil],
                             [nil,nil,"Q",nil]]
      @queen_solver.forward_slash_attack.should == true
      @queen_solver.attacks_possible.should == true
    end

    it "should catch a backward-slash attack in a top corner" do
      @queen_solver.board = [[nil,"Q",nil,nil],
                             ["Q",nil,nil,nil],
                             [nil,nil,nil,nil],
                             [nil,nil,nil,nil]]
      @queen_solver.backward_slash_attack.should == true
      @queen_solver.diagonal_attack.should == true
      @queen_solver.attacks_possible.should == true
    end
    
    it "should find a backward-slash attack in a bottom corner" do
      @queen_solver.board = [[nil,nil,nil,nil],
                             [nil,nil,nil,"Q"],
                             [nil,nil,nil,nil],
                             [nil,"Q",nil,nil]]
      @queen_solver.backward_slash_attack.should == true
      @queen_solver.diagonal_attack.should == true
      @queen_solver.attacks_possible.should == true     
    end
    
    it "should not return true for an empty board" do
      @queen_solver.horizontal_attack.should_not == true
      @queen_solver.vertical_attack.should_not == true
      @queen_solver.diagonal_attack.should_not == true
      @queen_solver.attacks_possible.should_not == true
    end
  end
  
  describe "checking for a solved baord" do
    before(:each) do
      @queen_solver = QueenSolver.new(4)
      @queen_solver.board = [[nil,"Q",nil,nil],
                             [nil,nil,nil,"Q"],
                             ["Q",nil,nil,nil],
                             [nil,nil,"Q",nil]]      
    end
    
    it "should know that n queens have been placed" do
      @queen_solver.all_queens_placed.should == true
    end
    
    it "should know that a board has been solved" do
      @queen_solver.solved.should == true
    end
  end
  
  describe "placing queens on a baord" do
    
    it "should return the coordinates for the next move"
    
    
    it "should know if a column is occupied" do
      @queen_solver = QueenSolver.new(4)
      @queen_solver.board = [["Q",nil,nil,nil],
                             [nil,nil,nil,nil],
                             [nil,nil,nil,nil],
                             [nil,nil,nil,nil]]
      @queen_solver.column_is_occupied(0).should == true
    end
    
    it "should know when a diagonal is occupied" do
      @queen_solver = QueenSolver.new(4)
      @queen_solver.board = [[nil,nil,nil,nil],
                             [nil,"Q",nil,nil],
                             [nil,nil,nil,nil],
                             [nil,nil,nil,nil]]
      @queen_solver.diagonal_is_occupied(0,0).should == true
      @queen_solver.diagonal_is_occupied(2,0).should == true      
    end
  end
  
  describe "incremental tests" do
  
   it "should place 1 Queen on a 1 x 1 Board" do
     @queen_solver = QueenSolver.new(1)
     @queen_solver.place_queens
     @queen_solver.solved.should == true
     @queen_solver.attacks_possible.should_not == true      
   end

   it "should place 4 Queens on a 4 x 4 Board" do
     @queen_solver = QueenSolver.new(4)
     @queen_solver.place_queens
     @queen_solver.attacks_possible.should_not == true
   end
   
   it "should place 4 Queens on a 5 x 5 Board" do
     @queen_solver = QueenSolver.new(5)
     @queen_solver.place_queens
     @queen_solver.attacks_possible.should_not == true
   end
   
   it "should place 6 Queens on a 6 x 6 Board" do
     @queen_solver = QueenSolver.new(6)
     @queen_solver.place_queens
     # @queen_solver.attacks_possible.should_not == true
   end
   
   it "should place 6 Queens on a 7 x 7 Board" do
     @queen_solver = QueenSolver.new(7)
     @queen_solver.place_queens
     # @queen_solver.attacks_possible.should_not == true
   end
   
   it "should place 8 Queens on a 8 x 8 Board" do
     @queen_solver = QueenSolver.new(8)
     @queen_solver.place_queens
     # @queen_solver.attacks_possible.should_not == true      
   end
  end
  
  describe "Placing N Queens on an N X N Board" do
    [1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].each do |n|
      it "should place #{n} queens on an #{n} x #{n} board" do
        @queen_solver = QueenSolver.new(n)
        @queen_solver.place_queens
        # @queen_solver.attackable
        # @queen_solver.broken.should_not == true
        # @queen_solver.attacks_possible.should_not == true        
      end
    end
  end
  
end