import Foundation

struct QuestionLoader {
    static let allCategories = [
        "diamond", "corundum", "beryl", "quartz",
        "precious", "gemology", "origin", "treatment"
    ]

    static func load(from fileName: String) -> [Question] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([Question].self, from: data) else {
            return []
        }
        return questions
    }

    static func loadAll() -> [Question] {
        allCategories.flatMap { load(from: $0) }
    }

    static func load(categories: [String] = allCategories, difficulty: Int? = nil) -> [Question] {
        let questions = categories.flatMap { load(from: $0) }
        if let difficulty {
            return questions.filter { $0.difficulty == difficulty }
        }
        return questions
    }

    static func loadReview(ids: Set<String>) -> [Question] {
        loadAll().filter { ids.contains($0.id) }
    }
}
