import Foundation

/// Модель записи эмоционального состояния
struct EmotionEntry: Identifiable, Codable {
    let id: UUID
    let date: Date

    /// Уровень настроения: 0.0 (опустошен) до 1.0 (счастлив)
    let moodLevel: Double

    /// Уровень энергии: 0.0 (спокойный) до 1.0 (энергичный)
    let energyLevel: Double

    /// Опциональная заметка
    var note: String?

    init(id: UUID = UUID(), date: Date = Date(), moodLevel: Double, energyLevel: Double, note: String? = nil) {
        self.id = id
        self.date = date
        self.moodLevel = max(0, min(1, moodLevel))
        self.energyLevel = max(0, min(1, energyLevel))
        self.note = note
    }

    /// Описание настроения на основе позиции
    var moodDescription: String {
        switch moodLevel {
        case 0..<0.2:
            return "Опустошён"
        case 0.2..<0.4:
            return "Подавлен"
        case 0.4..<0.6:
            return "Нейтрально"
        case 0.6..<0.8:
            return "Хорошо"
        default:
            return "Счастлив"
        }
    }

    var energyDescription: String {
        switch energyLevel {
        case 0..<0.3:
            return "Спокойный"
        case 0.3..<0.7:
            return "Умеренный"
        default:
            return "Энергичный"
        }
    }
}
