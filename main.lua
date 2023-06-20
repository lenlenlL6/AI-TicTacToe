board = {" ", " ", " ", " ", " ", " ", " ", " ", " "}
humanPlayer = "X"
aiPlayer = "O"

function drawBoard()
  print(" " .. board[1] .. " | " .. board[2] .. " | " .. board[3] .. " ")
  print("---|---|---")
  print(" " .. board[4] .. " | " .. board[5] .. " | " .. board[6] .. " ")
  print("---|---|---")
  print(" " .. board[7] .. " | " .. board[8] .. " | " .. board[9] .. " ")
end

function checkWin(player)
  if (board[1] == player and board[2] == player and board[3] == player) or
     (board[4] == player and board[5] == player and board[6] == player) or
     (board[7] == player and board[8] == player and board[9] == player) or
     (board[1] == player and board[4] == player and board[7] == player) or
     (board[2] == player and board[5] == player and board[8] == player) or
     (board[3] == player and board[6] == player and board[9] == player) or
     (board[1] == player and board[5] == player and board[9] == player) or
     (board[3] == player and board[5] == player and board[7] == player) then
    return true
  else
    return false
  end
end

function checkTie()
  for i = 1, 9 do
    if board[i] == " " then
      return false
    end
  end
  return true
end

function getAvailableMoves()
  local moves = {}
  for i = 1, 9 do
    if board[i] == " " then
      table.insert(moves, i)
    end
  end
  return moves
end

function minimax(player)
  if checkWin(humanPlayer) then
    return -10
  elseif checkWin(aiPlayer) then
    return 10
  elseif checkTie() then
    return 0
  end
  if player == aiPlayer then
    local bestScore = -math.huge
    for _, move in ipairs(getAvailableMoves()) do
      board[move] = aiPlayer
      score = minimax(humanPlayer)
      board[move] = " "
      bestScore = math.max(bestScore, score)
    end
    return bestScore
  else
    local bestScore = math.huge
    for _, move in ipairs(getAvailableMoves()) do
      board[move] = humanPlayer
      score = minimax(aiPlayer)
      board[move] = " "
      bestScore = math.min(bestScore, score)
    end
    return bestScore
  end
end

function getNextMove()
  local bestScore = -math.huge
  local bestMove = nil
  for _, move in ipairs(getAvailableMoves()) do
    board[move] = aiPlayer
    score = minimax(humanPlayer)
    board[move] = " "
    if score > bestScore then
      bestScore = score
      bestMove = move
    end
  end
  return bestMove
end

function play()
  drawBoard()
  while true do
    local humanMove = io.read("*n")
    if board[humanMove] == " " then
      board[humanMove] = humanPlayer
      if checkWin(humanPlayer) then
        drawBoard()
        print("Congratulations! You win!")
        break
      elseif checkTie() then
        drawBoard()
        print("It's a tie!")
        break
      end
    else
      print("That space is already taken. Please choose another one.")
    end
    local aiMove = getNextMove()
    board[aiMove] = aiPlayer
    print("The AI chooses space " .. aiMove)
    if checkWin(aiPlayer) then
      drawBoard()
      print("Sorry, you lose.")
      break
    elseif checkTie() then
      drawBoard()
      print("It's a tie!")
      break
    end
    drawBoard()
  end
end
    
play()