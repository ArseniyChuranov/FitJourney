//
//  WorkoutsListView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct WorkoutsListView: View {
    @Binding var workouts: [WorkoutTemplate]
    
    @State private var isPresentingNewWorkoutView = false
    @State private var newExercise = WorkoutTemplate.Data()
    
    var body: some View {
        List {
            ForEach($workouts) { $workout in
                NavigationLink(destination: DetailView(workout: $workout)) {
                    CardView(workout: workout)
                }
                .listRowBackground(workout.theme.mainColor)
                .padding(.leading) // optional
            }
        }
        .navigationTitle("Workouts")
        .toolbar {
            Button (action: {
                isPresentingNewWorkoutView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewWorkoutView) {
            NavigationView {
                NewExerciseEdit(data: $newExercise) // for now its a terrible solution I have to figure that one out, i shouldn't pass a separate exercise value, it should be included
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewWorkoutView = false
                                newExercise = WorkoutTemplate.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newWorkout = WorkoutTemplate(data: newExercise)
                                workouts.append(newWorkout)
                                
                                isPresentingNewWorkoutView = false
                                newExercise = WorkoutTemplate.Data()
                            }
                        }
                    }
            }
        }
    }
}

struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsListView(workouts: .constant(WorkoutTemplate.sampleData))
        }
    }
}
