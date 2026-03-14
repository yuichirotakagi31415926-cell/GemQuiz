import Foundation

struct AnswerRecord: Codable {
    let questionId: String
    let isCorrect: Bool
    let answeredAt: Date
}
