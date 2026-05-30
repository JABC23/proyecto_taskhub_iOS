// TimerView.swift
import SwiftUI
import AVFoundation
import Combine

struct TimerView: View {
    @State private var timeRemaining = 25 * 60 // 25 minutos en segundos
    @State private var isRunning = false
    @State private var timerMode: TimerMode = .focus
    
    enum TimerMode {
        case focus, break_
        
        var title: String {
            switch self {
            case .focus: return "Tiempo de Enfoque"
            case .break_: return "Descanso"
            }
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                
                // Modo
                Text(timerMode.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                
                // Tiempo
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 70, weight: .bold, design: .monospaced))
                    .padding()
                
                // Botón principal
                Button(action: {
                    isRunning.toggle()
                }) {
                    Text(isRunning ? "PAUSAR" : "INICIAR")
                        .frame(width: 200, height: 50)
                        .background(isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .font(.headline)
                }
                
                // Botón reiniciar
                Button(action: {
                    isRunning = false
                    resetTimer()
                }) {
                    Text("REINICIAR")
                        .frame(width: 200, height: 44)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.primary)
                        .cornerRadius(22)
                }
                
                // Botón cambiar modo (solo cuando no está corriendo)
                if !isRunning {
                    HStack(spacing: 30) {
                        Button("Enfoque") {
                            timerMode = .focus
                            resetTimer()
                        }
                        .foregroundColor(timerMode == .focus ? .blue : .gray)
                        
                        Button("Descanso") {
                            timerMode = .break_
                            resetTimer()
                        }
                        .foregroundColor(timerMode == .break_ ? .blue : .gray)
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .navigationTitle("Temporizador")
            .onReceive(timer) { _ in
                if isRunning && timeRemaining > 0 {
                    timeRemaining -= 1
                } else if isRunning && timeRemaining == 0 {
                    isRunning = false
                    // Notificación o sonido aquí
                }
            }
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func resetTimer() {
        if timerMode == .focus {
            timeRemaining = 25 * 60
        } else {
            timeRemaining = 5 * 60
        }
    }
}
