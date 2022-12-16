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
    @State private var isPresentingEditingView = false
    @State private var newExercise = WorkoutTemplate.Data()
    @State private var editingExercise = WorkoutTemplate.Data()
    @State var bindingList: [String] = []
    
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
                    .swipeActions(edge: .leading){
                        Button("Edit", action: {
                            isPresentingEditingView = true
                            editingExercise = WorkoutTemplate.Data(title: indWorkout.title, exercise:indWorkout.exercise, theme: indWorkout.theme)
                        })
                    }
                }
                // allows to delete individual workouts
                .onDelete { indices in
                    workouts.remove(atOffsets: indices)
                }
                /*
                .onTapGesture(count: 2) {
                    isPresentingEditingView = true
                }
                 */
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
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    WorkoutEditView(workout: $editingExercise)
                }
            }
            .sheet(isPresented: $isPresentingNewWorkoutView) {
                NavigationView {
                    NewExerciseEdit(data: $newExercise, exercisesList: $bindingList, saveAction: {})
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingNewWorkoutView = false
                                    newExercise = WorkoutTemplate.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    // it just works.
                                    var newWorkout = WorkoutTemplate(data: newExercise)
                                    
                                    var index = 0
                                    for exerciseName in bindingList {
                                        if(exerciseName != newWorkout.exercise[index].workoutName) {
                                            let updatedExercise = WorkoutTemplate.ExerciseData(workoutName: bindingList[index], exerciseSets: [])
                                            
                                            newWorkout.exercise.insert(updatedExercise, at: index)
                                            newWorkout.exercise.remove(at: index + 1)
                                        }
                                        
                                        index = index + 1
                                    }
                                    
                                    
                                    // let newWorkout = WorkoutTemplate(data: newExercise)
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
