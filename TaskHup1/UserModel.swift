// UserModel.swift
import SwiftUI
import Combine  // ← Importante para ObservableObject

// Modelo de usuario
struct User: Codable {
    var fullName: String
    var email: String
    var password: String
    var joinDate: Date = Date()
    var totalTasksCompleted: Int = 12
    var pomodoroCycles: Int = 5
}

// Clase para manejar la sesión del usuario
class UserSession: ObservableObject {  // ← ObservableObject ya funciona con import Combine
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false
    
    static let shared = UserSession()
    
    private let userDefaultsKey = "savedUser"
    
    init() {
        loadSavedUser()
    }
    
    // Registrar nuevo usuario
    func register(fullName: String, email: String, password: String) -> Bool {
        // Verificar si ya existe un usuario con ese email
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedData),
           savedUser.email == email {
            return false
        }
        
        let newUser = User(fullName: fullName, email: email, password: password)
        currentUser = newUser
        saveUser(newUser)
        isLoggedIn = true
        return true
    }
    
    // Iniciar sesión
    func login(email: String, password: String) -> Bool {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedData),
           savedUser.email == email && savedUser.password == password {
            currentUser = savedUser
            isLoggedIn = true
            return true
        }
        return false
    }
    
    // Cerrar sesión
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
    
    // Guardar usuario en UserDefaults
    private func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    // Cargar usuario guardado
    private func loadSavedUser() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedData) {
            self.currentUser = savedUser
            self.isLoggedIn = true
        }
    }
    
    // Actualizar estadísticas
    func updateStats(tasksCompleted: Int? = nil, pomodoroCycles: Int? = nil) {
        guard var user = currentUser else { return }
        
        if let tasks = tasksCompleted {
            user.totalTasksCompleted = tasks
        }
        if let cycles = pomodoroCycles {
            user.pomodoroCycles = cycles
        }
        
        currentUser = user
        saveUser(user)
    }
}
