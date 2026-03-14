import SwiftUI

struct StatsView: View {
    @State private var viewModel = StatsViewModel()

    var body: some View {
        List {
            Section("総合") {
                LabeledContent("総回答数", value: "\(viewModel.totalAnswered)問")
                LabeledContent("正解数", value: "\(viewModel.totalCorrect)問")
                LabeledContent("正解率", value: String(format: "%.0f%%", viewModel.accuracy * 100))
            }

            Section("復習リスト") {
                let count = viewModel.reviewQuestionIds.count
                if count == 0 {
                    Text("復習問題はありません")
                        .foregroundStyle(.secondary)
                } else {
                    NavigationLink("復習する（\(count)問）") {
                        ReviewView(questionIds: viewModel.reviewQuestionIds)
                    }
                }
            }
        }
        .navigationTitle("統計")
        .onAppear { viewModel.load() }
    }
}

#Preview {
    NavigationStack { StatsView() }
}
