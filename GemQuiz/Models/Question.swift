import Foundation

struct Question: Codable, Identifiable {
    let id: String
    let category: String
    let difficulty: Int       // 1〜4
    let type: String          // "multiple_choice"
    let question: String
    let options: [String]     // 4択
    let correctIndex: Int     // 正解のインデックス (0〜3)
    let explanation: String
    let imageName: String?
    let tags: [String]
}
