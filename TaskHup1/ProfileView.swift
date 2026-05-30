// ProfileView.swift
import SwiftUI

struct ProfileView: View {
    @StateObject private var userSession = UserSession.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                // Avatar
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                // Datos del usuario desde el registro
                VStack(spacing: 8) {
                    Text(userSession.currentUser?.fullName ?? "Usuario")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(userSession.currentUser?.email ?? "correo@ejemplo.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Fecha de registro
                    if let joinDate = userSession.currentUser?.joinDate {
                        Text("Miembro desde: \(formattedDate(joinDate))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // Estadísticas
                VStack(spacing: 24) {
                    Text("Estadísticas de Productividad")
                        .font(.headline)
                    
                    HStack(spacing: 40) {
                        VStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                            Text("Tareas Completadas")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(userSession.currentUser?.totalTasksCompleted ?? 0)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            Image(systemName: "timer")
                                .foregroundColor(.orange)
                                .font(.title2)
                            Text("Ciclos Pomodoro")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(userSession.currentUser?.pomodoroCycles ?? 0)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)
                
                Spacer()
                
                // Botón cerrar sesión
                Button(action: {
                    userSession.logout()
                    // Forzar actualización de la vista
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Cerrar Sesión")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .foregroundColor(.red)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Mi Perfil")
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}
