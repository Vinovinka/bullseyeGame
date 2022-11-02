import Foundation

struct LeaderboardEntry {
    let score: Int
    let date: Date
}

struct Game {
    var target = Int.random(in: 1...100)
    var score = 0
    var round = 1
    var leaderboardEntries: [LeaderboardEntry] = []

    init(loadTestData: Bool = false) {
        if loadTestData == true {
            leaderboardEntries.append(LeaderboardEntry(score: 100, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(score: 200, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(score: 300, date: Date()))
        }
    }

    func points(sliderValue: Int) -> Int {

        let difference = abs(sliderValue - target)
        let bonus: Int

        if difference == 0 {
            bonus = 100
        } else if difference <= 2 {
            bonus = 50
        } else {
            bonus = 0
        }

        return 100 - difference + bonus
    }

    mutating func addToLeaderboard(points: Int) {
        leaderboardEntries.append(LeaderboardEntry(score: points, date: Date()))
        leaderboardEntries.sort{ $0.score < $1.score }
    }

    mutating func startNewRound(points: Int) {
        score += points
        round += 1
        target = Int.random(in: 1...100)
        addToLeaderboard(points: score)
    }

    mutating func restart() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
    }

    mutating func cleanLeaderboard() {
        leaderboardEntries.removeAll()
    }
}
