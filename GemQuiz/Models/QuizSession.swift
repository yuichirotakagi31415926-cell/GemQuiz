import Foundation

struct QuizSession {
    let questions: [Question]
    var currentIndex: Int = 0
    var answers: [Int?]          // nil = 未回答、Int = 選択した選択肢インデックス
    let startedAt: Date = Date()

    init(questions: [Question]) {
        self.questions = questions
        self.answers = Array(repeating: nil, count: questions.count)
    }

    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var isFinished: Bool {
        currentIndex >= questions.count
    }

    var correctCount: Int {
        zip(questions, answers).filter { question, answer in
            answer == question.correctIndex
        }.count
    }

    var accuracy: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(correctCount) / Double(questions.count)
    }
}
