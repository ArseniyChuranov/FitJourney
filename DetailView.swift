//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    
    let workout: WorkoutTemplate
    
    @State private var data = WorkoutTemplate.Data() // uses data instead of sample data
    
    @State private var newExerciseName = ""
    @State private var newExerciseWeightValue = ""
    @State private var newExerciseSetsValue = ""
    @State private var newExerciseRepsValue = ""
    
    @State private var isPresentingEditingView = false
    
    
    var body: some View {
        List {
            //change statement later when will have data saving option
            if !(data.exercise.isEmpty) {
                Section(header: Text("Workout Info")) {
                        ForEach(data.exercise) { exercise in
                            VStack {
                                HStack {
                                    Label(exercise.workoutName, systemImage: "dumbbell")
                                    Spacer()
                                    Text("Weight")
                                    Text(String(Int(exercise.weight != nil ? exercise.weight! : 0))) // THAT WORKED
                                }
                                Spacer()
                                HStack {
                                    Text("Reps")
                                    Text(String(Int(exercise.sets != nil ? exercise.sets! : 0)))
                                    Spacer()
                                    Text("Sets")
                                    Text(String(Int(exercise.reps != nil ? exercise.reps! : 0)))
                                }
                            }
                        }
                    
                    // .onDelete { indices in
                    //     data.exercise.remove(atOffsets: indices)
                    // }
                    
                    // create a view input that will take data and insert it to thiw view
                    
                }
                
            }
            Section(header: Text("New workout")) {
                VStack {
                    HStack {
                        TextField("New Exercise", text: $newExerciseName)
                        Spacer()
                        TextField("Weight", text: $newExerciseWeightValue)
                            .keyboardType(.numberPad) // use this keyboard for number input
                        
                    }
                    HStack {
                        TextField("Sets", text: $newExerciseSetsValue)
                            .keyboardType(.numberPad)
                        Spacer()
                        TextField("Reps", text: $newExerciseRepsValue)
                            .keyboardType(.numberPad)
                    }
                    Spacer()
                    Button (action: { // choose new location
                        withAnimation {
                            let exercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName,
                                                                               sets: Int(newExerciseSetsValue) != nil ? Int(newExerciseSetsValue)! : 0,
                                                                               reps: Int(newExerciseRepsValue) != nil ? Int(newExerciseRepsValue)! : 0,
                                                                               weight: Int(newExerciseWeightValue) != nil ? Int(newExerciseWeightValue)! : 0)
                            // print(exercise)
                            data.exercise.append(exercise)
                            // clean entries after each add
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newExerciseName.isEmpty)
                    //.keyboardType(.numberPad)
                }
            }
        }
        .navigationTitle(workout.title)
        .toolbar {
            Button("Edit")
            {
                isPresentingEditingView = true
                // data = workout.data // signs data to a new value // may be useful
            }
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    DetailEditView(data: $data) // change to edit later
                        .navigationTitle(workout.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditingView = false
                                    
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditingView = false }
                            }
                        }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(workout: WorkoutTemplate.sampleData[0])
        }
    }
}
