//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    
    let workout: WorkoutTemplate
    
    
    
    @State private var data = WorkoutTemplate.Data() // uses data instead of sample data
    
    
    @State private var newExerciseName = ""
    @State private var newExerciseWeightValue = ""
    @State private var newExerciseRepsValue = ""
    @State private var newExerciseSetsValue: Int = 0
    
    @State private var isPresentingEditingView = false
    @State private var isPresentingAddNewSetView = false // to present a view that will allow to add a new set to a card
    
    var body: some View {
        List {
            
            if !(workout.exercise.isEmpty) {
                
                // possibly create 2 separate views, one with adding a button, another is not
                
                // let workoutSets = workout.setsData.sets
                
                ForEach(workout.exercise) {exercise in
                    ExerciseCardView(exercise: exercise)
                        .listRowBackground(workout.theme.mainColor)
                }
                
                
                
                /*
                 
                 .onTapGesture(count: 2) {
                     withAnimation {
                         if (isPresentingAddNewSetView == false) {
                             isPresentingAddNewSetView = true
                         } else {
                             isPresentingAddNewSetView = false
                         }
                     }
                 }
             
                 if(isPresentingAddNewSetView == true)
                 {
                     Text("test feature") // present in the end not in the view.
                 }
                 
                 */
                
                
                
                //. ondelete is useless now, maybe keep it as a separate thing.
                //.onDelete {indices in
                //    data.exercise.remove(atOffsets: indices)
                //}
            }
            
            /*
            
            // make a createNew a separate view and get rid of section
            Section(header: Text("New exercise")) {
                
                // change it later to a card view that will create a new exercise
                
                VStack {
                    HStack {
                        TextField("New Exercise", text: $newExerciseName)
                        Spacer()
                        TextField("Weight", text: $newExerciseWeightValue)
                            .keyboardType(.numberPad) // use this keyboard for number input
                        
                    }
                    HStack {
                        TextField("Reps", text: $newExerciseRepsValue)
                            .keyboardType(.numberPad)
                    }
                    Spacer()
                    Button (action: { // choose new location
                        withAnimation {
                            newExerciseSetsValue = workout.exercise.count + 1 // simply wrong, work on it later 
                            let exercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName,
                                                                        exerciseSets: [WorkoutTemplate.ExerciseSet(sets: newExerciseSetsValue,
                                                                                                                   reps: Int(newExerciseRepsValue) ?? 1,
                                                                                                                   weight: Int(newExerciseWeightValue) ?? 0)])
                            // print(exercise)
                            data.exercise.append(exercise) // work on this later to make sure it does what it needs do
                            // clean entries after each add
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newExerciseName.isEmpty)
                    //.keyboardType(.numberPad)
                }
            }
            
            */
            
        }
        
        // Edit button still needs to be discussed wether will be used.
        .navigationTitle(workout.title)
        
        
        
        .toolbar {
            Button("Edit")
            {
                isPresentingEditingView = true
                // data = workout.data // signs data to a new value // may be useful
            }
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    DetailEditView(data: $data) // change to edit later
                        .navigationTitle(workout.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditingView = false
                                    
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditingView = false }
                            }
                        }
                }
            }
        }
        
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(workout: WorkoutTemplate.sampleData[0])
        }
    }
}



/*
 
 Section(header: Text("Workout Info")) {
     ForEach(data.exercise) { exercise in
             VStack {
                 HStack {
                     Label(exercise.workoutName, systemImage: "dumbbell")
                     Spacer()
                     Text("Weight")
                     Text(String(Int(exercise.weight))) // THAT WORKED
                 }
                 Spacer()
                 HStack {
                     Text("Reps")
                     Text(String(Int(exercise.sets)))
                     Spacer()
                     Text("Sets")
                     Text(String(Int(exercise.reps)))
                 }
             }
         }
     
     // .onDelete { indices in
     //     data.exercise.remove(atOffsets: indices)
     // }
     
     // create a view input that will take data and insert it to thiw view
     
 }
 
 */



/*
 
 VStack {
     HStack {
         Label(exercise.workoutName, systemImage: "dumbbell")
     }
     HStack {
         
         // i don't like this solution
         // compiler says it takes too much time to process
         
         // also temp solution since i will be using a card view for each exercise
         if !(exercise.exerciseSets.isEmpty) {
             ForEach(exercise.exerciseSets) { individualSet in
                 Text("Sets:")
                 Text(String(individualSet.sets))
                 Spacer()
                 Text("Reps:")
                 Text(String(individualSet.reps))
                 Spacer()
                 Text("Weight:")
                 Text(String(individualSet.weight))
             }
         }
         
     }
 }
 
 */
