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
        
        VStack {
            
            if(workouts.isEmpty) {
                VStack {
                    Spacer()
                    Text("Looks like there are no workouts here yet.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 20, idealHeight: 25)
                    Button("Add New Workout", action: {
                        isPresentingNewWorkoutView = true
                    })
                    .font(.title2)
                }
            }
            
            List {
                ForEach($workouts) { $indWorkout in
                    NavigationLink(destination: DetailView(workout: $indWorkout)) {
                        CardView(workout: indWorkout)
                    }
                    .isDetailLink(false) // DID I SPEND 4 DAYS FOR THIS
                    .listRowBackground(indWorkout.theme.mainColor)
                    .padding(.leading) // optional
                }
                // allows to delete individual workouts
                .onDelete { indices in
                    workouts.remove(atOffsets: indices)
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
                                    workouts.append(newWorkout)
                                    
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
}

struct WorkoutsListView_Previews: PreviewProvider {
    static let workoutStore = WorkoutStore()
    
    static var previews: some View {
        Group {
            NavigationView {
                WorkoutsListView(workouts: .constant(WorkoutTemplate.sampleData), saveAction: {})
            }
            
            NavigationView {
                WorkoutsListView(workouts: .constant(WorkoutTemplate.emptyWorkouts), saveAction: {})
            }
        }
        .environmentObject(workoutStore)
    }
}
