
// TaskFlowApp.swift
import SwiftUI

@main
struct TaskHup: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSession.shared)
        }
    }
}
