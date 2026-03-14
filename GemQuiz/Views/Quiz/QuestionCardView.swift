import SwiftUI

struct QuestionCardView: View {
    let question: Question

    private var difficultyStars: String {
        String(repeating: "★", count: question.difficulty) +
        String(repeating: "☆", count: 4 - question.difficulty)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(difficultyStars)
                    .foregroundStyle(.yellow)
                Spacer()
                Text(question.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(Capsule())
            }

            if let imageName = question.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text(question.question)
                .font(.title3.weight(.medium))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
