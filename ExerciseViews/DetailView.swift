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
    @State var newExerciseBindingList: [String] = []
    
    var body: some View {
        
        VStack {
            // If there are no exercises, a custom view will appear with a button to create new exercises
            
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
            
            List {
                ForEach($workout.exercise) {$exercise in
                    NavigationLink(destination: ExerciseCardView(exercise: $exercise)) {
                        // Separate view, needs further attention to details.
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
                // This button is only for adding exercises, since its possible to edit and delete them here.
                // This will clear in case empty BindingList
                newExerciseBindingList = []
                
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    // This view only take an empty binding list, that will or will not be filled with new exercises.
                    DetailEditView(newExerciseList: $newExerciseBindingList)
                        .navigationTitle(workout.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    
                                    // When "Cancel" pressed, sheet view will retract and all items in list will be cleared.
                                    
                                    isPresentingEditingView = false
                                    
                                    // Empty all
                                    newExerciseBindingList = []
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    // After pressing "Done" this will check for any changes in newExerciseBindingList and add any new exercises.
                                    
                                    // instance of an Old exercise to append new items
                                    var oldExercice = WorkoutTemplate(title: workout.title, exercise: workout.exercise, theme: workout.theme)
                                    
                                    // For loop that fills workout with new information from sheet.
                                    
                                    for exercise in newExerciseBindingList {
                                        let exercise = WorkoutTemplate.ExerciseData(workoutName: exercise, exerciseSets: [])
                                        oldExercice.exercise.append(exercise)
                                    }
                                    
                                    // Updates current view with a new Workout
                                    
                                    workout.update(from: oldExercice.data)
                                    
                                    // Hides current sheet view.
                                    
                                    isPresentingEditingView = false
                          
                                    // Empty all
                                    newExerciseBindingList = []
                                    
                                    
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

