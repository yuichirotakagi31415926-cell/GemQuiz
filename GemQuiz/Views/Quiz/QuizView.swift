import SwiftUI

struct QuizView: View {
    var viewModel: QuizViewModel
    @State private var showExplanation = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Group {
            if viewModel.isFinished {
                ResultView(session: viewModel.session!)
            } else if let question = viewModel.currentQuestion {
                VStack(spacing: 0) {
                    // 進捗バー
                    if let session = viewModel.session {
                        ProgressView(
                            value: Double(session.currentIndex),
                            total: Double(session.questions.count)
                        )
                        .padding(.horizontal)
                        .padding(.top, 8)

                        Text("\(session.currentIndex + 1) / \(session.questions.count)問")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }

                    Spacer()

                    // 問題カード
                    QuestionCardView(question: question)
                        .padding()

                    Spacer()

                    // 選択肢
                    VStack(spacing: 12) {
                        ForEach(question.options.indices, id: \.self) { index in
                            AnswerButtonView(
                                label: question.options[index],
                                state: answerState(for: index, question: question)
                            ) {
                                if !viewModel.isAnswered {
                                    viewModel.answer(index: index)
                                    showExplanation = true
                                }
                            }
                        }
                    }
                    .padding()
                }
                .sheet(isPresented: $showExplanation) {
                    ExplanationView(
                        question: question,
                        selectedIndex: viewModel.selectedAnswerIndex
                    ) {
                        showExplanation = false
                        viewModel.nextQuestion()
                    }
                    .presentationDetents([.medium, .large])
                }
            }
        }
        .navigationTitle("クイズ")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }

    private func answerState(for index: Int, question: Question) -> AnswerButtonView.State {
        guard let selected = viewModel.selectedAnswerIndex else { return .normal }
        if index == question.correctIndex { return .correct }
        if index == selected { return .incorrect }
        return .normal
    }
}
