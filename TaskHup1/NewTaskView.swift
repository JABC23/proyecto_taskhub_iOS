// NewTaskView.swift
import SwiftUI

struct NewTaskView: View {
    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var dueDate = Date()
    @State private var priority = "Media"
    @State private var showAlert = false
    
    let priorities = ["Baja", "Media", "Alta"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("¿Qué vas a hacer?")) {
                    TextField("Ej. Estudiar Android", text: $taskTitle)
                }
                
                Section(header: Text("Añade una descripción (Opcional)")) {
                    TextEditor(text: $taskDescription)
                        .frame(height: 80)
                    Text("Escribe los detalles aquí...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Fecha límite")) {
                    DatePicker("Seleccionar fecha", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                
                Section(header: Text("Prioridad de la tarea")) {
                    Picker("Prioridad", selection: $priority) {
                        ForEach(priorities, id: \.self) { p in
                            Text(p).tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button(action: {
                        if !taskTitle.isEmpty {
                            showAlert = true
                            // Aquí guardarías la tarea
                            taskTitle = ""
                            taskDescription = ""
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("GUARDAR TAREA")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(taskTitle.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(12)
                    }
                    .disabled(taskTitle.isEmpty)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Nueva Tarea")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Tarea guardada"), message: Text("Tu tarea ha sido creada exitosamente"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
