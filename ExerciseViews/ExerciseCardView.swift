//
//  ExerciseCardView.swift
//  Fit Journey
//
//  Individual Exercise View card, will show an exercise name with sets, reps and weight. Will allow to add new set with reps and weight.
//
//  Created by Arseniy Churanov on 11/28/22.
//

import SwiftUI

struct ExerciseCardView: View {
    
    @EnvironmentObject var exerciseObservable: WorkoutStore
    
    @Binding var exercise: WorkoutTemplate.ExerciseData
    @State private var newExercise = ExerciseSet.Sets()

    @State private var newSetValue = ""
    @State private var newRepValue = ""
    @State private var newWeightValue = ""
    
    @State private var isAddingNewSets = false
    @State private var isPresentingAddNewSetView = false
    
    var body: some View {
        ZStack {
            Color("Background") // a simple way to create a background color for now.
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            VStack {
                
                HStack {
                    Text(exercise.workoutName)
                        .font(.title)
                }
                
                if (exercise.exerciseSets.isEmpty) {
                    VStack {
                        Button("Add New Sets", action: {
                            isPresentingAddNewSetView = true
                        })
                        .font(.title)
                    }
                    .padding()
                }
                List {
                    ForEach( exercise.exerciseSets) {individualSet in
                        HStack {
                            Text("Set:")
                            Text(String("\(individualSet.sets)"))
                            Spacer()
                            Text("Reps:")
                            Text(String(individualSet.reps))
                            Spacer()
                            Text("Weight:")
                            Text(String(individualSet.weight))
                        }
                    }
                    .onDelete {sets in
                        exercise.exerciseSets.remove(atOffsets: sets)
                    }
                    .frame(height: 15)
                    // might leave all editinf for a separate view
                }
                //.cornerRadius(10)
                
            }
            .toolbar {
                Button(action: {
                    isPresentingAddNewSetView = true
                    // maybe add a func that will create a new instance of an exercise.
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isPresentingAddNewSetView) {
                    AddExerciseSetView(exercise: $exercise)
                        .presentationDetents([.medium])
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingAddNewSetView = false
                                    
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingAddNewSetView = false
                                }
                            }
                        }
                }
                .padding()
    
            }
        }
        //.cornerRadius(10)
    }
}



struct ExerciseCardView_Previews: PreviewProvider {
    static let workoutStore = WorkoutStore()
    static let exerciseWithoutSets = WorkoutTemplate.ExerciseData(workoutName: "No Sets", exerciseSets: [])
    
    static var previews: some View {
        Group {
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
                .previewDisplayName("Exercise With Sets Light Theme")
            
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Exercise With Sets Dark Theme")
            
            ExerciseCardView(exercise: .constant(exerciseWithoutSets))
                .previewDisplayName("Exercise Without Sets Light Theme")
    
        }
        .environmentObject(workoutStore)
    }
}



/*
 
 VStack(alignment: .leading) {1
     HStack {
         Text(exercise.workoutName)
             .font(.title2)
         Spacer()
         Text("Weight:")
         Text(String(exercise.weight!))
     }
     Spacer()
         .frame(height: 10) // check for better possible solution
     HStack {
         Text("Sets:")
         Text(String(exercise.sets!))
         Spacer()
         Text("Reps:")
         Text(String(exercise.reps!))
     }
     
     
 }
 .padding()
 
 
 .padding()
 .cornerRadius(15)
 .backgroundStyle(.opacity(0.2)) // might be unnecessary
 
 
 
 HStack {
     Text("Sets:")
     Text(String(exercise.sets))
     Spacer()
     Text("Reps:")
     Text(String(exercise.reps))
     Spacer()
     Text("Weight:")
     Text(String(exercise.weight))
 }
 .frame(height: 15) // necessary?
 
 */



/*
 
 
 .onTapGesture(count: 2) {
     isPresentingEditingView = true
     
     EditExerciseCardView(exercise: $exercise) // change to edit later
         .navigationTitle(exercise.workoutName)
         .toolbar {
             ToolbarItem(placement: .cancellationAction) {
                 Button("Cancel") {
                     isPresentingEditingView = false
                     
                 }
             }
             ToolbarItem(placement: .confirmationAction) {
                 Button("Done") {
                     isPresentingEditingView = false
                     // workout.update(from: data) // simply wrong
                 }
             }
         }
 }
 
 
 
 
 
 .onTapGesture(count: 3) {
     if (isPresentingAddNewSetView == false) {
         isPresentingAddNewSetView = true
     } else {
         isPresentingAddNewSetView = false
         newRepValue = ""
         newWeightValue = ""
     }
 }
 
 
 
 
 if(isPresentingAddNewSetView == true) {
     // presents view with addition
     HStack {
         Text("Add Set")
         TextField("Reps", text: $newRepValue)
             .keyboardType(.numberPad)
         TextField("Weight", text: $newWeightValue)
             .keyboardType(.numberPad)
         Button (action: {
             let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                      reps: Int(newRepValue) ?? 1,
                                      weight: Int(newWeightValue) ?? 1)
             
             exercise.exerciseSets.append(newSet)
             isPresentingAddNewSetView = false
             
             newRepValue = ""
             newWeightValue = ""
             
         }) {
             Image(systemName: "plus")
         }
         .disabled(newWeightValue.isEmpty)
     }
     .padding()
     .cornerRadius(15)
 }
 
 
 VStack {
     HStack {
         Text(exerciseName)
             .font(.title2)
     }
     Button("Add Sets", action: {
         isPresentingEditingView = true
         // let workoutNew = exerciseObservable.workouts[0].exercise // index?
         // let newObj = obj.workouts
     })
 }
 .sheet(isPresented: $isPresentingEditingView) {
     EditExerciseCardView(exercise: $exerciseObservable.workouts[0].exercise[0])
 }
 
 
 */
