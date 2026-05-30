// MainTabView.swift
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            
            NewTaskView()
                .tabItem {
                    Label("Nueva Tarea", systemImage: "plus.circle.fill")
                }
            
            TimerView()
                .tabItem {
                    Label("Enfoque", systemImage: "timer")
                }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
    }
}
