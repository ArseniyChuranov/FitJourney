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
    
     // let exercise: WorkoutTemplate.ExerciseData
    // @Binding var exercise: WorkoutTemplate.ExerciseData // might needed to be changed, for now im confused
    // @Binding var setsData: WorkoutTemplate.Sets // that broke my things // prolly dont need it
    @Binding var exercise: WorkoutTemplate.ExerciseData
    // var exerciseSetsData = ExerciseSet.Sets()
    
    var body: some View {
        ZStack {
            Color("Background") // a simple way to create a background color for now.
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            VStack(alignment: .center) {
                if(exercise.exerciseSets.isEmpty) {
                    // create a separate view later to reuse it and make it simpler
                    
                    //  Default view that presents in case there are no sets for a workout
                    
                    // temp View that is similar to an individual cell
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
                    //.background(.white) // order matters a lot!
                    .cornerRadius(15)
                    // .backgroundStyle(.opacity(2.0))
                } else {
                    VStack {
                        HStack {
                            Text(exercise.workoutName)
                                .font(.title2)
                        }
                        ForEach(exercise.exerciseSets) {individualSet in
                            HStack {
                                Text("Set:")
                                Text(String("\(individualSet.sets)")) // fix? no / for now it works due to the system that adds each new set with correct index.
                                // create a system in future that will account for numeration if sets when sets are deleted.
                                Spacer()
                                Text("Reps:")
                                Text(String(individualSet.reps))
                                Spacer()
                                Text("Weight:")
                                Text(String(individualSet.weight))
                            }
                            .frame(height: 15)
                        }
                        // List allows to delete and edit things yet it brakes an app. investigate in future
                        // .onDelete(perform: {indices in exercise.exerciseSets.remove(atOffsets: indices)})
                        /*
                         
                         // doesnt work, need to see connections
                         // looks like it will work after i will have a solid update system of bindings for sets
                         // so leave for now and later fix the binding so it actually does changes. as well as correctly counts sets.
                        
                        .onDelete {indices in
                            setsData.sets.remove(atOffsets: indices)
                         
                            exercise.exerciseSets.remove(atOffsets: indices)
                        }
                        
                        */
                        .onTapGesture(count: 3) {
                            if (isPresentingAddNewSetView == false) {
                                isPresentingAddNewSetView = true
                            } else {
                                isPresentingAddNewSetView = false
                                newRepValue = ""
                                newWeightValue = ""
                            }
                        }
                    }
                    .padding()
                    //.background(.white)
                    .cornerRadius(15)
                    .backgroundStyle(.opacity(0.2)) // might be unnecessary
                    
                    .onDisappear {
                        //print("current exercise.exerciseSets")
                        //print(exercise.exerciseSets)
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
                            
                            // Even that it adds to a new set i will need to make it pass to an actual set later down the line
                            // probably when i would use actual data instead of sample data. Might need to change later.
                            
                            //exercise.exerciseSets.append(newSet)
                            isPresentingAddNewSetView = false
                            
                            
                            
                            //print("This is what is setsData.sets \(setsData.sets)")
                            //print("This is what in exercise.exerciseSets \(exercise.exerciseSets)")
                            
                            newRepValue = ""
                            newWeightValue = ""
                            
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newWeightValue.isEmpty)
                    }
                    .padding()
                    //.background(.white)
                    .cornerRadius(15)
                    // .backgroundStyle(.opacity(2.0)) // might be unnecessary
                }
            }
        }
        .cornerRadius(10)
        // .padding() // it is what it is
    }
}



struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
                .previewLayout(.fixed(width: 400, height: 60))
            
            ExerciseCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
                .previewLayout(.fixed(width: 400, height: 60))
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
 
 */
