import Foundation
import Observation

@Observable
class HomeViewModel {
    var selectedDifficulty: Int? = nil          // nil = すべての難易度
    var selectedCategories: Set<String> = []    // 空 = すべてのカテゴリ
    var questionCount: Int = 10
    var timerEnabled: Bool = false

    var isReadyToStart: Bool {
        questionCount > 0
    }
}
