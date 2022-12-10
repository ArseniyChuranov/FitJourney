//
//  WorkoutsListView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct WorkoutsListView: View {
    // @Binding var
    var workouts: [WorkoutTemplate]
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewWorkoutView = false
    @State private var newExercise = WorkoutTemplate.Data()
    
    @EnvironmentObject var workoutStore: WorkoutStore
    
    
    
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach(workoutStore.workouts) { indWorkout in
                NavigationLink(destination: DetailView(workout: indWorkout)) {
                    CardView(workout: indWorkout)
                }
                //.navigationViewStyle(StackNavigationViewStyle())
                .isDetailLink(false) // DID I SPEND 4 DAYS FOR THIS
                .listRowBackground(indWorkout.theme.mainColor)
                .padding(.leading) // optional
            }

        }
        .navigationTitle("Workouts")
        .toolbar {
            Button (action: {
                isPresentingNewWorkoutView = true
            }) {
                Image(systemName: "person.circle.fill")
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
            WorkoutsListView(workouts: WorkoutTemplate.sampleData, saveAction: {})
        }
        .environmentObject(workoutStore)
    }
}
