import Foundation
import Observation

@Observable
class QuizViewModel {
    var session: QuizSession?
    var selectedAnswerIndex: Int? = nil
    var isFinished: Bool = false

    private let progressStore = ProgressStore()

    func startSession(questions: [Question]) {
        session = QuizSession(questions: questions)
        selectedAnswerIndex = nil
        isFinished = false
    }

    func answer(index: Int) {
        guard session?.currentQuestion != nil,
              selectedAnswerIndex == nil else { return }
        selectedAnswerIndex = index

        if let question = session?.currentQuestion {
            let record = AnswerRecord(
                questionId: question.id,
                isCorrect: index == question.correctIndex,
                answeredAt: Date()
            )
            progressStore.save(record: record)
        }
    }

    func nextQuestion() {
        session?.currentIndex += 1
        selectedAnswerIndex = nil

        if session?.isFinished == true {
            isFinished = true
        }
    }

    var currentQuestion: Question? {
        session?.currentQuestion
    }

    var isAnswered: Bool {
        selectedAnswerIndex != nil
    }
}
