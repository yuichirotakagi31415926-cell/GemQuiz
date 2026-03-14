import SwiftUI

struct AnswerButtonView: View {
    enum State {
        case normal, correct, incorrect
    }

    let label: String
    let state: State
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .multilineTextAlignment(.leading)
                Spacer()
                stateIcon
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: state == .normal ? 0 : 2)
            )
        }
        .disabled(state != .normal)
    }

    @ViewBuilder
    private var stateIcon: some View {
        switch state {
        case .correct:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .incorrect:
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
        case .normal:
            EmptyView()
        }
    }

    private var backgroundColor: Color {
        switch state {
        case .normal: return Color(.secondarySystemBackground)
        case .correct: return Color.green.opacity(0.15)
        case .incorrect: return Color.red.opacity(0.15)
        }
    }

    private var foregroundColor: Color {
        switch state {
        case .normal: return .primary
        case .correct: return .green
        case .incorrect: return .red
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal: return .clear
        case .correct: return .green
        case .incorrect: return .red
        }
    }
}
