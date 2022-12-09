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
    
    @State private var newSetValue = ""
    @State private var newRepValue = ""
    @State private var newWeightValue = ""
    @State private var totalExerciseCount = 0
    
    @State private var isAddingNewSets = false
    @State private var isPresentingAddNewSetView = false
    @State private var isPresentingEditingView = false
 
    @Binding var exercise: WorkoutTemplate.ExerciseData
    @State private var newExercise = ExerciseSet.Sets()
    // var exerciseSetsData = ExerciseSet.Sets()
    
    var body: some View {
        ZStack {
            Color("Background") // a simple way to create a background color for now.
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            VStack(alignment: .center) {
                if(exercise.exerciseSets.isEmpty) {
                    //  Default view that presents in case there are no sets for a workout
                    VStack {
                        HStack {
                            Text(exercise.workoutName)
                                .font(.title2)
                        }
                        HStack {
                            Text("Add Set")
                            TextField("Reps", text: $newRepValue)
                                .keyboardType(.numberPad)
                            TextField("Weight", text: $newWeightValue)
                                .keyboardType(.numberPad)
                            Button (action: { // too simple of an action
                                let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                                         reps: Int(newRepValue) ?? 1,
                                                         weight: Int(newWeightValue) ?? 1)
                                // Adds set to a list
                                //exercise.exerciseSets.append(newSet)
                                // setsData.sets.append(newSet) // do i need this whole thing?
                                // closes the view
                                isPresentingAddNewSetView = false
                                
                                newRepValue = ""
                                newWeightValue = ""
                            }) {
                                Image(systemName: "plus")
                            }
                            .disabled(newWeightValue.isEmpty)
                        }
                    }
                    .padding()
                    .cornerRadius(15)
                } else {
                    VStack {
                        HStack {
                            Text(exercise.workoutName)
                                .font(.title2)
                        }
                        List {
                            ForEach(exercise.exerciseSets) {individualSet in
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
                                .frame(height: 15)
                            }
                            // might leave all editinf for a separate view
                            .onDelete {indices in
                                exercise.exerciseSets.remove(atOffsets: indices)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(15)
                    .backgroundStyle(.opacity(0.2)) // might be unnecessary
                    .toolbar {
                        Button("Edit") {
                            isPresentingEditingView = true
                            // maybe add a func that will create a new instance of an exercise.
                        }
                        .sheet(isPresented: $isPresentingEditingView) {
                            EditExerciseCardView(exercise: $exercise)
                        }
                    }
                }
            }
        }
        .cornerRadius(10)
    }
}



struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
            
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
                .environment(\.colorScheme, .dark)
        }
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
 
 
 */
