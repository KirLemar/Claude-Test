import SwiftUI

/// Сетка для выбора эмоционального состояния
struct EmotionGridView: View {
    @Binding var selectedMood: Double
    @Binding var selectedEnergy: Double
    @State private var isDragging = false

    private let gridSize: CGFloat = 300

    var body: some View {
        VStack(spacing: 16) {
            // Заголовок
            Text("Как ты себя чувствуешь?")
                .font(.title2)
                .fontWeight(.semibold)

            // Сетка эмоций
            ZStack {
                // Фоновый градиент
                LinearGradient(
                    colors: [
                        Color.gray.opacity(0.3),
                        Color.blue.opacity(0.2),
                        Color.yellow.opacity(0.3),
                        Color.orange.opacity(0.3)
                    ],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                .cornerRadius(20)

                // Сетка линий
                GridLinesView()
                    .opacity(0.3)

                // Подписи по углам
                VStack {
                    HStack {
                        Text("Спокойный\nи счастливый")
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Энергичный\nи счастливый")
                            .font(.caption)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    HStack {
                        Text("Спокойный\nи опустошён")
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Тревожный\nи опустошён")
                            .font(.caption)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(12)

                // Подписи осей
                VStack {
                    Text("Я счастлив")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                    Spacer()
                    Text("Я опустошён")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)

                // Точка выбора
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [.white, moodColor],
                            center: .center,
                            startRadius: 0,
                            endRadius: 20
                        )
                    )
                    .frame(width: 40, height: 40)
                    .shadow(color: moodColor.opacity(0.5), radius: 10)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .scaleEffect(isDragging ? 1.2 : 1.0)
                    .position(
                        x: selectedEnergy * gridSize,
                        y: (1 - selectedMood) * gridSize
                    )
                    .animation(.spring(response: 0.3), value: isDragging)
            }
            .frame(width: gridSize, height: gridSize)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        isDragging = true
                        let x = max(0, min(gridSize, value.location.x))
                        let y = max(0, min(gridSize, value.location.y))
                        selectedEnergy = x / gridSize
                        selectedMood = 1 - (y / gridSize)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )

            // Текущее состояние
            VStack(spacing: 8) {
                Text(currentMoodText)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(moodColor)

                Text(currentEnergyText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 8)
        }
        .padding()
    }

    private var moodColor: Color {
        switch selectedMood {
        case 0..<0.25:
            return .gray
        case 0.25..<0.5:
            return .blue
        case 0.5..<0.75:
            return .yellow
        default:
            return .green
        }
    }

    private var currentMoodText: String {
        switch selectedMood {
        case 0..<0.2:
            return "Я чувствую себя опустошённым"
        case 0.2..<0.4:
            return "Мне грустно"
        case 0.4..<0.6:
            return "Без особого настроения"
        case 0.6..<0.8:
            return "Мне хорошо"
        default:
            return "Я чувствую себя великолепно!"
        }
    }

    private var currentEnergyText: String {
        switch selectedEnergy {
        case 0..<0.33:
            return "Спокойное состояние"
        case 0.33..<0.66:
            return "Умеренная энергия"
        default:
            return "Много энергии"
        }
    }
}

/// Линии сетки
struct GridLinesView: View {
    var body: some View {
        Canvas { context, size in
            let stepX = size.width / 4
            let stepY = size.height / 4

            // Вертикальные линии
            for i in 1..<4 {
                let x = stepX * CGFloat(i)
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                context.stroke(path, with: .color(.gray), lineWidth: 1)
            }

            // Горизонтальные линии
            for i in 1..<4 {
                let y = stepY * CGFloat(i)
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(.gray), lineWidth: 1)
            }
        }
    }
}

#Preview {
    EmotionGridView(selectedMood: .constant(0.5), selectedEnergy: .constant(0.5))
}
