import SwiftUI

struct ReviewView: View {
    let questionIds: Set<String>
    @State private var quizViewModel: QuizViewModel?

    var body: some View {
        Group {
            if let vm = quizViewModel {
                QuizView(viewModel: vm)
            } else {
                ProgressView("読み込み中...")
            }
        }
        .navigationTitle("復習モード")
        .onAppear {
            let questions = QuestionLoader.loadReview(ids: questionIds).shuffled()
            let vm = QuizViewModel()
            vm.startSession(questions: questions)
            quizViewModel = vm
        }
    }
}
