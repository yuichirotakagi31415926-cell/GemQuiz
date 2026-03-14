import SwiftUI

struct ResultView: View {
    let session: QuizSession
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // スコア
                VStack(spacing: 8) {
                    Text("\(session.correctCount) / \(session.questions.count)")
                        .font(.system(size: 56, weight: .bold))
                    Text(String(format: "正解率 %.0f%%", session.accuracy * 100))
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 32)

                // 間違えた問題一覧
                if session.correctCount < session.questions.count {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("間違えた問題")
                            .font(.headline)
                        ForEach(incorrectQuestions) { question in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(question.question)
                                    .font(.subheadline)
                                Text("正解: \(question.options[question.correctIndex])")
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }

                // ホームへ戻るボタン
                Button {
                    dismiss()
                } label: {
                    Text("ホームに戻る")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("結果")
        .navigationBarBackButtonHidden(true)
    }

    private var incorrectQuestions: [Question] {
        zip(session.questions, session.answers).compactMap { question, answer in
            answer != question.correctIndex ? question : nil
        }
    }
}
