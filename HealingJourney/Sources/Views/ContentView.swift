import SwiftUI

struct ContentView: View {
    @State private var selectedMood: Double = 0.5
    @State private var selectedEnergy: Double = 0.5
    @State private var note: String = ""
    @State private var showingSaveConfirmation = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Приветствие
                    VStack(spacing: 8) {
                        Text("Healing Journey")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Твой путь к исцелению")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)

                    // Сетка эмоций
                    EmotionGridView(
                        selectedMood: $selectedMood,
                        selectedEnergy: $selectedEnergy
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    )
                    .padding(.horizontal)

                    // Поле для заметки
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Заметка (необязательно)")
                            .font(.headline)

                        TextEditor(text: $note)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)

                    // Кнопка сохранения
                    Button(action: saveEntry) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Сохранить запись")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .alert("Сохранено!", isPresented: $showingSaveConfirmation) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Твоё эмоциональное состояние записано. Продолжай отслеживать свои чувства.")
            }
        }
    }

    private func saveEntry() {
        let entry = EmotionEntry(
            moodLevel: selectedMood,
            energyLevel: selectedEnergy,
            note: note.isEmpty ? nil : note
        )

        // TODO: Сохранить в хранилище
        print("Saved entry: \(entry)")

        showingSaveConfirmation = true
        note = ""
    }
}

#Preview {
    ContentView()
}
