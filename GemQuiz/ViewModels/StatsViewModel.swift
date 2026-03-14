import Foundation
import Observation

@Observable
class StatsViewModel {
    private let progressStore = ProgressStore()
    var records: [AnswerRecord] = []

    func load() {
        records = progressStore.loadAll()
    }

    var totalAnswered: Int { records.count }

    var totalCorrect: Int { records.filter { $0.isCorrect }.count }

    var accuracy: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalCorrect) / Double(totalAnswered)
    }

    var reviewQuestionIds: Set<String> {
        progressStore.incorrectQuestionIds()
    }
}
