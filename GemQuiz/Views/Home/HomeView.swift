import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var navigateToQuiz = false

    private let questionCounts = [10, 20, 30]
    private let difficulties: [(label: String, value: Int?)] = [
        ("すべて", nil),
        ("★ 入門", 1),
        ("★★ 初級", 2),
        ("★★★ 中級", 3),
        ("★★★★ 上級", 4)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // 難易度選択
                    VStack(alignment: .leading, spacing: 12) {
                        Text("難易度")
                            .font(.headline)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 8) {
                            ForEach(difficulties, id: \.label) { item in
                                Button(item.label) {
                                    viewModel.selectedDifficulty = item.value
                                }
                                .buttonStyle(SelectableButtonStyle(
                                    isSelected: viewModel.selectedDifficulty == item.value
                                ))
                            }
                        }
                    }

                    // 問題数選択
                    VStack(alignment: .leading, spacing: 12) {
                        Text("問題数")
                            .font(.headline)
                        HStack(spacing: 12) {
                            ForEach(questionCounts, id: \.self) { count in
                                Button("\(count)問") {
                                    viewModel.questionCount = count
                                }
                                .buttonStyle(SelectableButtonStyle(
                                    isSelected: viewModel.questionCount == count
                                ))
                            }
                        }
                    }

                    // タイマー設定
                    VStack(alignment: .leading, spacing: 12) {
                        Text("タイマー")
                            .font(.headline)
                        Toggle("20秒制限", isOn: $viewModel.timerEnabled)
                    }
                }
                .padding()
            }
            .navigationTitle("GemQuiz")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        StatsView()
                    } label: {
                        Image(systemName: "chart.bar")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                NavigationLink {
                    QuizView(viewModel: makeQuizViewModel())
                } label: {
                    Text("クイズを始める")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
                .background(.background)
            }
        }
    }

    private func makeQuizViewModel() -> QuizViewModel {
        let categories = viewModel.selectedCategories.isEmpty
            ? QuestionLoader.allCategories
            : Array(viewModel.selectedCategories)
        var questions = QuestionLoader.load(
            categories: categories,
            difficulty: viewModel.selectedDifficulty
        ).shuffled()
        questions = Array(questions.prefix(viewModel.questionCount))

        let vm = QuizViewModel()
        vm.startSession(questions: questions)
        return vm
    }
}

struct SelectableButtonStyle: ButtonStyle {
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}

#Preview {
    HomeView()
}
