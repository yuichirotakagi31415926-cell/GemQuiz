import Foundation

class ProgressStore {
    private let recordsKey = "answerRecords"

    func save(record: AnswerRecord) {
        var records = loadAll()
        records.append(record)
        if let data = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(data, forKey: recordsKey)
        }
    }

    func loadAll() -> [AnswerRecord] {
        guard let data = UserDefaults.standard.data(forKey: recordsKey),
              let records = try? JSONDecoder().decode([AnswerRecord].self, from: data) else {
            return []
        }
        return records
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: recordsKey)
    }

    func incorrectQuestionIds() -> Set<String> {
        let records = loadAll()
        let incorrect = Set(records.filter { !$0.isCorrect }.map { $0.questionId })
        let correct = Set(records.filter { $0.isCorrect }.map { $0.questionId })
        return incorrect.subtracting(correct)
    }
}
