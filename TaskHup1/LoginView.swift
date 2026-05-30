// LoginView.swift
import SwiftUI

struct LoginView: View {
    @StateObject private var userSession = UserSession.shared
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Spacer()
                
                // Logo / Título
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.blue)
                    
                    Text("TaskHup")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Organiza tu productividad")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Campos de texto
                VStack(spacing: 20) {
                    TextField("Correo electrónico", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 30)
                
                // Botón Iniciar Sesión
                Button(action: {
                    if userSession.login(email: email, password: password) {
                        // Login exitoso
                    } else {
                        errorMessage = "Correo o contraseña incorrectos"
                        showError = true
                    }
                }) {
                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 30)
                
                // Link a registro
                NavigationLink(destination: RegisterView()) {
                    Text("¿No tienes cuenta? Regístrate")
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true)
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}
