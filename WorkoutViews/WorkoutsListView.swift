//
//  WorkoutsListView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct WorkoutsListView: View {
    @Binding var workouts: [WorkoutTemplate]
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewWorkoutView = false
    @State private var newExercise = WorkoutTemplate.Data()
    
    @EnvironmentObject var workoutStore: WorkoutStore
    
    
    
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($workoutStore.workouts) { $indWorkout in
                NavigationLink(destination: DetailView(workout: $indWorkout)) {
                    CardView(workout: indWorkout)
                }
                .isDetailLink(false) // DID I SPEND 4 DAYS FOR THIS
                .listRowBackground(indWorkout.theme.mainColor)
                .padding(.leading) // optional
            }

        }
        .navigationTitle("Workouts")
        .toolbar {
            // button that will allow to create a new workout.
            Button (action: {
                isPresentingNewWorkoutView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewWorkoutView) {
            NavigationView {
                NewExerciseEdit(data: $newExercise)
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
                                workoutStore.workouts.append(newWorkout)
                                
                                isPresentingNewWorkoutView = false
                                newExercise = WorkoutTemplate.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct WorkoutsListView_Previews: PreviewProvider {
    static let workoutStore = WorkoutStore()
    
    static var previews: some View {
        NavigationView {
            WorkoutsListView(workouts: .constant(WorkoutTemplate.sampleData), saveAction: {})
        }
        .environmentObject(workoutStore)
    }
}
