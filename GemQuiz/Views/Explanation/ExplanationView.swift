import SwiftUI

struct ExplanationView: View {
    let question: Question
    let selectedIndex: Int?
    let onNext: () -> Void

    private var isCorrect: Bool {
        selectedIndex == question.correctIndex
    }

    var body: some View {
        VStack(spacing: 24) {
            // 正誤表示
            VStack(spacing: 8) {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(isCorrect ? .green : .red)
                Text(isCorrect ? "正解！" : "不正解")
                    .font(.title2.bold())
                    .foregroundStyle(isCorrect ? .green : .red)
            }

            // 正解
            if !isCorrect {
                VStack(spacing: 4) {
                    Text("正解")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(question.options[question.correctIndex])
                        .font(.headline)
                        .foregroundStyle(.green)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            // 解説
            VStack(alignment: .leading, spacing: 8) {
                Text("解説")
                    .font(.headline)
                Text(question.explanation)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button(action: onNext) {
                Text("次の問題へ")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
    }
}
