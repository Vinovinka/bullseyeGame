import SwiftUI

struct LeaderboardView: View {
    @Binding var leaderboardIsShowing: Bool

    @Binding var game: Game

    var body: some View {
        ZStack {

            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                HeaderView(leaderboardIsShowing: $leaderboardIsShowing)
                LabelView()
                ScrollView {
                    VStack {
                        ForEach(game.leaderboardEntries.indices, id: \.self) { i in
                            let leaderboardEntry = game.leaderboardEntries[i]
                            RowView(
                                index: i,
                                score: leaderboardEntry.score,
                                date: leaderboardEntry.date)
                        }
                    }
                }
            }
        }
    }
}

struct RowView: View {

    let index: Int
    let score: Int
    let date: Date

    var body: some View {
        HStack {
            RoundedTextView(text: String(index))
            Spacer()
            ScoreText(score: score)
                .frame(width: Constants.Leaderboard.leaderboardScoreColWigth)
            Spacer()
            DateText(date: date)
                .frame(width: Constants.Leaderboard.leaderboardDateColWigth)

        }
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .strokeBorder(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
        )
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: Constants.Leaderboard.leaderboardMaxRowWigth)
    }
}

struct HeaderView: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var leaderboardIsShowing: Bool

    var body: some View {
        ZStack {
            HStack {

                if verticalSizeClass == .regular && horizontalSizeClass == .compact {
                    BigBoldText(text: "Leaderboard")
                        .padding(.leading)
                    Spacer()
                } else {
                    BigBoldText(text: "Leaderboard")
                }
            }
            .padding()
            HStack {
                Spacer()
                Button(action: {
                    leaderboardIsShowing = false
                }) {
                    RoundedImageViewFilled(systemName: "xmark")
                        .padding(.trailing)
                }
            }
            .padding()
        }
    }
}

struct LabelView: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: Constants.General.roundedViewLength)
            Spacer()
            LabelText(text: "Score")
                .frame(width: Constants.Leaderboard.leaderboardScoreColWigth)
            Spacer()
            LabelText(text: "Date")
                .frame(width: Constants.Leaderboard.leaderboardDateColWigth)
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: Constants.Leaderboard.leaderboardMaxRowWigth)
    }
}

struct LeaderboardView_Previews: PreviewProvider {

    static private var leaderboardIsShowing = false
    static private var game = Binding.constant(Game(loadTestData: true))

    static var previews: some View {
        LeaderboardView(leaderboardIsShowing: .constant(leaderboardIsShowing), game: game)
    }
}
