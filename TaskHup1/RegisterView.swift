// RegisterView.swift
import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var userSession = UserSession.shared
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Crear Cuenta")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Únete a TaskHup")
                .foregroundColor(.gray)
            
            Spacer()
            
            VStack(spacing: 20) {
                TextField("Nombre completo", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 30)
            
            Button(action: {
                if fullName.isEmpty {
                    errorMessage = "Por favor ingresa tu nombre"
                    showError = true
                } else if email.isEmpty {
                    errorMessage = "Por favor ingresa tu correo"
                    showError = true
                } else if password.isEmpty {
                    errorMessage = "Por favor ingresa una contraseña"
                    showError = true
                } else if password != confirmPassword {
                    errorMessage = "Las contraseñas no coinciden"
                    showError = true
                } else {
                    if userSession.register(fullName: fullName, email: email, password: password) {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        errorMessage = "Ya existe una cuenta con este correo"
                        showError = true
                    }
                }
            }) {
                Text("Registrarse")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 30)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("¿Ya tienes cuenta? Inicia sesión")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 50)
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
