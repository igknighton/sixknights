 #representation of the chessboard moves in 
 #matrix form
	
adj_matrix = [
 	[0,0,0,0,0,1,0,1,0,0,0,0],
 	[0,0,0,0,0,0,1,0,1,0,0,0],
 	[0,0,0,1,0,0,0,1,0,0,0,0],
 	[0,0,1,0,0,0,0,0,1,0,1,0],
 	[0,0,0,0,0,0,0,0,0,1,0,1],
 	[1,0,0,0,0,0,1,0,0,0,1,0],
 	[0,1,0,0,0,1,0,0,0,0,0,1],
 	[1,0,1,0,0,0,0,0,0,0,0,0],
 	[0,1,0,1,0,0,0,0,0,1,0,0],
 	[0,0,0,0,1,0,0,0,1,0,0,0],
 	[0,0,0,1,0,1,0,0,0,0,0,0],
 	[0,0,0,0,1,0,1,0,0,0,0,0],
 	]

#sets the arrangements of the knights
def new_knight(knight_index,knight_arr, path)
    knight_arr[knight_index] = path[0]
    return knight_arr
end

def breadth_first_search(adj_matrix,blackKnight,whiteKnight,source_index, end_index)
  node_queue = [source_index]
  #keeps track of nodes that were visited
  visted_nodes = [source_index]
  steps = []
  #keeps track of the node that preceded the current one
  #first index is the node, second index is the previous node 
  #source_index has a prev value of nil since it is the first
  prev_node = [
    [source_index,nil]
  ]
  loop do
    curr_node = node_queue.pop
    #puts "#{curr_node} popped"
    
     if curr_node == nil 
       return steps = []
     end

    if  curr_node == end_index
      steps = short_path(prev_node,source_index,end_index) #return true
      return steps
    end
    children = (0..adj_matrix.length-1).to_a.select do |i| 
      (adj_matrix[curr_node][i] == 1) && 
      (!visted_nodes.include? i) &&
      (!blackKnight.include? i) &&
      (!whiteKnight.include? i)
    end

    j = 0
    while j < children.length do
      prev_node = prev_node + [[children[j],curr_node]]
      j = j + 1
    end

    #puts "children: #{children}"
    visted_nodes = children + visted_nodes
    node_queue = children + node_queue
    #puts "prev_node :#{prev_node}"
    #puts "node_queue: #{node_queue}"
    #puts "visted_nodes: #{visted_nodes}"
  end
end

def short_path(prev_node,source_index,end_index)

    curr_node = end_index
    # an array to hold the path from the source to the target index
    steps = []
    i = 0
    while i < prev_node.length do
        #puts "prev_node: #{prev_node[i][0]}"
        #puts "curr_node: #{curr_node}"
      if prev_node[i][0] == curr_node
        steps = steps + [curr_node]
        curr_node = prev_node[i][1]
        #puts "curr_node is now : #{curr_node}"
        i = 0
    else
        i = i + 1
      end
    end
    
    if curr_node == nil
      return steps
    end
end 


def cb_helper(bk,wk,path)

  temp = bk + wk
  split = []
  #path.reverse!
  t = path.length
 # puts "#{t}"

  while path.length >= 2
  for i in 0..5
    if temp[i] == path[path.length-1]
      path.pop
      #puts " Path length: #{path.length}"
      temp[i] = path[path.length-1]
      #puts "new temp arr: #{temp}"
      split = temp.each_slice(3).to_a
      bk = split[0]
      wk = split[1]
     # puts "#{bk}"
      #puts "#{wk}"
      chessboard(bk,wk)
    end
  end
end

end

#prints a representation of the chessboard
#and the knights' positions
def chessboard(bk, wk)

cnt = 0

 for i in 0..3
    for j in 0..2
      if (bk.include? cnt)
      print "[B]"
    elsif (wk.include? cnt)
      print "[W]"
    else
      print "[ ]"
      end
      cnt = cnt + 1
    end
    puts ""
  end
  puts ""

end


def solve(adj_matrix)

blackKnight = [0,1,2]
whiteKnight = [11,10,9]

puts "Initial Positions"
chessboard(blackKnight,whiteKnight)


#solving the problem
path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,2,8)
cb_helper(blackKnight,whiteKnight,path)
blackKnight = new_knight(2,blackKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,10,2)
cb_helper(blackKnight,whiteKnight,path)
whiteKnight = new_knight(1,whiteKnight,path)

path = breadth_first_search(adj_matrix, blackKnight,whiteKnight,0,10)
cb_helper(blackKnight,whiteKnight,path)
blackKnight = new_knight(0,blackKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,11,0)
cb_helper(blackKnight,whiteKnight,path)
whiteKnight = new_knight(0,whiteKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,1,11)
cb_helper(blackKnight,whiteKnight,path)
blackKnight = new_knight(1,blackKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,8,3)
cb_helper(blackKnight,whiteKnight,path)
blackKnight = new_knight(2,blackKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,9,1)
cb_helper(blackKnight,whiteKnight,path)
whiteKnight = new_knight(2,whiteKnight,path)

path = breadth_first_search(adj_matrix,blackKnight,whiteKnight,3,9)
cb_helper(blackKnight,whiteKnight,path)
blackKnight = new_knight(2,blackKnight,path)
end

solve(adj_matrix)
