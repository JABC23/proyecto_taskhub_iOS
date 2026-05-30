// HomeView.swift
import SwiftUI

struct HomeView: View {
    @StateObject private var userSession = UserSession.shared
    let date = Date()
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: date).capitalized
    }
    var userName: String {
        if let fullName = userSession.currentUser?.fullName {
            // Extraer solo el primer nombre (opcional)
            let firstName = fullName.components(separatedBy: " ").first ?? fullName
            return firstName
        }
        return "admin"
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("TaskHup")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(formattedDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        // Pequeño avatar del usuario
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    // Saludo personalizado
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("¡Hola, \(userName)!")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(getEmojiForTimeOfDay())
                                .font(.title)
                        }
                        
                        Text(getMotivationalMessage())
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Cita motivacional
                    VStack(alignment: .leading, spacing: 12) {
                        Text("\"Para que usted sea lo mejor, puede ser para otros, primero debe ser el mejor para usted.\"")
                            .font(.body)
                            .italic()
                            .foregroundColor(.primary)
                        Text("— Jeffrey Gitomer")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Progreso del día
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Progreso del día")
                            .font(.headline)
                        
                        ProgressView(value: getTodayProgress())
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(.green)
                        
                        HStack {
                            Label("\(getCompletedTasks()) tareas completadas", systemImage: "checkmark.circle")
                            Spacer()
                            Label("\(userSession.currentUser?.pomodoroCycles ?? 0) pomodoros", systemImage: "timer")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Consejo del día personalizado
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text("Consejo del día")
                                .font(.headline)
                        }
                        
                        Text(getDailyTip())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
            .refreshable {
                // Recargar datos si es necesario
            }
        }
    }
    // Función para obtener emoji según la hora del día
    private func getEmojiForTimeOfDay() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "☀️"
        case 12..<18:
            return "🌤️"
        case 18..<22:
            return "🌙"
        default:
            return "⭐"
        }
    }
    
    // Mensaje motivacional según la hora
    private func getMotivationalMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Comienza el día con energía y propósito. 🌅"
        case 12..<14:
            return "Buen momento para tomar un descanso y recargar. 🍽️"
        case 14..<18:
            return "Sigue con ese impulso, vas por buen camino. 💪"
        case 18..<22:
            return "Excelente trabajo hoy. Prepara el cierre del día. 📝"
        default:
            return "Es un buen momento para florecer. 🌸"
        }
    }
    
    // Progreso del día (ejemplo dinámico)
    private func getTodayProgress() -> Double {
        let completedTasks = getCompletedTasks()
        let totalTasks = 5 // Podrías cambiar esto por el total real de tareas del día
        return Double(completedTasks) / Double(totalTasks)
    }
    
    // Número de tareas completadas (esto deberías conectarlo con tus tareas reales)
    private func getCompletedTasks() -> Int {
        // Aquí podrías obtener las tareas completadas del día
        // Por ahora retorna un número base + algunos ciclos de pomodoro
        let baseTasks = 3
        let extraFromPomodoros = min(userSession.currentUser?.pomodoroCycles ?? 0, 3)
        return baseTasks + extraFromPomodoros
    }
    
    // Consejos personalizados según el rendimiento
    private func getDailyTip() -> String {
        let pomodoros = userSession.currentUser?.pomodoroCycles ?? 0
        let tasksCompleted = userSession.currentUser?.totalTasksCompleted ?? 0
        
        if pomodoros < 3 {
            return "🎯 Intenta completar al menos 3 ciclos Pomodoro hoy para mejorar tu concentración."
        } else if tasksCompleted < 5 {
            return "📋 Divide tus tareas grandes en pequeñas metas para sentir más progreso."
        } else {
            return "🏆 ¡Excelente ritmo! No olvides tomar descansos cortos entre tareas."
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserSession.shared)
}
