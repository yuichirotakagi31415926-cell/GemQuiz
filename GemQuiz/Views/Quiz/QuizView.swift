import SwiftUI

struct QuizView: View {
    var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Group {
            if viewModel.isFinished {
                ResultView(session: viewModel.session!)
            } else if let question = viewModel.currentQuestion {
                ScrollView {
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

                        // 問題カード
                        QuestionCardView(question: question)
                            .padding()

                        // 選択肢
                        VStack(spacing: 12) {
                            ForEach(question.options.indices, id: \.self) { index in
                                AnswerButtonView(
                                    label: question.options[index],
                                    state: answerState(for: index, question: question)
                                ) {
                                    if !viewModel.isAnswered {
                                        viewModel.answer(index: index)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        // インライン解説（回答後に展開）
                        if viewModel.isAnswered {
                            InlineExplanationView(
                                question: question,
                                selectedIndex: viewModel.selectedAnswerIndex
                            ) {
                                viewModel.nextQuestion()
                            }
                            .padding()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.isAnswered)
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
