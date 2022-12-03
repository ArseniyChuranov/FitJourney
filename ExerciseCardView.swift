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
    
    var exercise: WorkoutTemplate.ExerciseData // let was replaced with var
    
    //var exerciseSet: WorkoutTemplate.ExerciseSet
    
    @State private var setsData = WorkoutTemplate.Sets()
    
    @State private var exerciseData = WorkoutTemplate.Data() // separate entitiy that allows data flow and change
    
    
    var body: some View {
        VStack(alignment: .center) {
            
            if(setsData.sets.isEmpty) {
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
                            let newSet = WorkoutTemplate.ExerciseSet(sets: setsData.sets.count + 1,
                                                                     reps: Int(newRepValue) ?? 1,
                                                                     weight: Int(newWeightValue) ?? 1)
                            // Adds set to a list
                            setsData.sets.append(newSet)
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
                .background(.white) // order matters a lot!
                .cornerRadius(15)
                .backgroundStyle(.opacity(2.0))
            
            } else {
                VStack {
                    HStack {
                        Text(exercise.workoutName)
                            .font(.title2)
                    }
                    ForEach(setsData.sets) {individualSet in
                        HStack {
                            Text("Set:")
                            Text(String("\(individualSet.sets)")) // fix? no
                            Spacer()
                            Text("Reps:")
                            Text(String(individualSet.reps))
                            Spacer()
                            Text("Weight:")
                            Text(String(individualSet.weight))
                        }
                        .frame(height: 15)
                    }
                    // doesnt work, need to see connections
                    .onDelete {indices in
                        setsData.sets.remove(atOffsets: indices)
                    }
                    .onTapGesture(count: 1) {
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
                .background(.white)
                .cornerRadius(15)
                .backgroundStyle(.opacity(2.0)) // might be unnecessary
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
                        let newSet = WorkoutTemplate.ExerciseSet(sets: setsData.sets.count + 1,
                                                                 reps: Int(newRepValue) ?? 1,
                                                                 weight: Int(newWeightValue) ?? 1
                        )
                        
                        setsData.sets.append(newSet)
                        
                        isPresentingAddNewSetView = false
                        
                        newRepValue = ""
                        newWeightValue = ""
                        
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newWeightValue.isEmpty)
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                .backgroundStyle(.opacity(2.0)) // might be unnecessary
                
            }
            
        }
        .padding()
        .cornerRadius(20) // unnecessary?
    }

}



struct ExerciseCardView_Previews: PreviewProvider {
    static var exercise = WorkoutTemplate.ExerciseData.init(workoutName: "Bench Press", exerciseSets: [WorkoutTemplate.ExerciseSet.init(sets: 1, reps: 12, weight: 100),
                                                                                                       WorkoutTemplate.ExerciseSet.init(sets: 1, reps: 10, weight: 120)])
    static var previews: some View {
        ExerciseCardView(exercise: WorkoutTemplate.sampleData[0].exercise[0])
            .background()
            .previewLayout(.fixed(width: 400, height: 60))
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



