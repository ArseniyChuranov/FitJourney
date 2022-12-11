//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var workout: WorkoutTemplate
    // var exercise: WorkoutTemplate.ExerciseData
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var data = WorkoutTemplate.Data()
    @State private var isPresentingEditingView = false
    
    var body: some View {
        
        VStack {
            
            if(workout.exercise.isEmpty) {
                
                VStack {
                    Text("Looks like there are no exercises")
                        .font(.title2)
                        .frame(height: 20)
                    Button("Add New Exercise", action: {
                        isPresentingEditingView = true
                        data = workout.data
                    })
                    .font(.title)
                }
                .padding()
            }
            
            // see why view spawns in the center instead of up top
            
            List {
                ForEach($workout.exercise) {$exercise in
                    NavigationLink(destination: ExerciseCardView(exercise: $exercise)) {
                        // not the best idea.
                        ListExerciseCardView(exercise: exercise)
                    }
                    .isDetailLink(false) // not sure if needed here
                    .listRowBackground(workout.theme.mainColor)
                }
                .onDelete {indices in
                    workout.exercise.remove(atOffsets: indices)
                }
            }
            
        }
        .navigationTitle(workout.title)
        .toolbar {
            Button(action: {
                isPresentingEditingView = true
                // however if im making any changes, would it make sense to keep them?
                data = workout.data // signs data to a new value // may be useful
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    DetailEditView(data: $data) // change to edit later // it takes data.
                        .navigationTitle(workout.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditingView = false
                                    
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditingView = false
                                    workout.update(from: data)
                                }
                            }
                        }
                }
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var workoutStore = WorkoutStore()
    
    static var noExercisesWorkout = WorkoutTemplate.init(title: "Empty Workout", exercise: [], theme: .lavender)
    
    
    static var previews: some View {
        Group {
            NavigationView {
                DetailView(workout: .constant(WorkoutTemplate.sampleData[0]))
            }
            .previewDisplayName("Light Theme Appearance")
            
            
            NavigationView {
                DetailView(workout: .constant(WorkoutTemplate.sampleData[0]))
            }
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark Theme Appearance")
            
            NavigationView {
                DetailView(workout: .constant(noExercisesWorkout))
            }
            .previewDisplayName("No Exercise Appearance")
        }
        .environmentObject(workoutStore)
    }
}




/*
 onDisappear {
     
     // add some functionality here maybe to allow it update info?
     // read about dispatchQueue
     
     // workout.update(from: data) // Im not sure itd what i need....  // lmao no
     /*
     setsData.sets = workout.setsData.sets // ???
     data = workout.data
     workout.update(from: data) // ?????????????
      */
     
     // not even sure i need that code above, looks like correct binding worked
     
     
     // it just works.............
     // print("After leaving workout.exercise looks like this")
     // print(workout.exercise)
 }
 
 */
