
// https://www.geeksforgeeks.org/find-winner-election-votes-represented-candidate-names/

func findWinner(of votes: [String]) -> String {
  var votesMap: [String: Int] = [:]

  for vote in votes {
    votesMap[vote, default: 0] += 1
  }

  var maxVotes = 0
  var winner = ""

  for (candidate, voteCount) in votesMap {
    if voteCount > maxVotes {
      maxVotes = voteCount
      winner = candidate
    } else if voteCount == maxVotes && candidate < winner {
      winner = candidate
    }
    print(winner, maxVotes)
  }

  return winner
}

// Example usage
let votes = ["john", "johnny", "jackie", "johnny", "john", "jackie", "jamie", "jamie", "john", "johnny", "jamie", "johnny", "john"]
let winner = findWinner(of: votes)
print("Winner:", winner)
