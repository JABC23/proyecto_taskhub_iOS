// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var userSession = UserSession.shared
    
    var body: some View {
        Group {
            if userSession.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
#Preview {
    ContentView()
}
