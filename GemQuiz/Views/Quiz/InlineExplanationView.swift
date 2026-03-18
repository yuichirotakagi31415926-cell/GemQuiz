import SwiftUI

struct InlineExplanationView: View {
    let question: Question
    let selectedIndex: Int?
    let onNext: () -> Void

    private var isCorrect: Bool {
        selectedIndex == question.correctIndex
    }

    var body: some View {
        VStack(spacing: 16) {
            // 区切り線
            Divider()

            // 正誤バナー
            HStack(spacing: 10) {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.title2)
                Text(isCorrect ? "正解！" : "不正解")
                    .font(.title3.bold())
                Spacer()
            }
            .foregroundStyle(isCorrect ? .green : .red)

            // 不正解時の正解表示
            if !isCorrect {
                HStack {
                    Text("正解：")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(question.options[question.correctIndex])
                        .font(.subheadline.bold())
                        .foregroundStyle(.green)
                    Spacer()
                }
                .padding(12)
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            // 解説
            VStack(alignment: .leading, spacing: 6) {
                Text("解説")
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                Text(question.explanation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // 次へボタン
            Button(action: onNext) {
                Text("次の問題へ")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
