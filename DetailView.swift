//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var workout: WorkoutTemplate
    
    // create a source of truth for sets and exercises here. Test and see if I should consider moving sources somewhere else.
    
    @State private var data = WorkoutTemplate.Data() // uses data instead of sample data
    @State private var setsData = WorkoutTemplate.Sets() // lets try having state here // works?...
    
    // @Binding var setsData: WorkoutTemplate.Sets // i need this thing here?
    
    
    @State private var isPresentingEditingView = false
    @State private var isPresentingAddNewSetView = false // to present a view that will allow to add a new set to a card
    
    var body: some View {
        List {
            if !(workout.exercise.isEmpty) {
                ForEach($workout.exercise) {$exercise in
                    ExerciseCardView(exercise: $exercise, setsData: $setsData)
                        .listRowBackground(workout.theme.mainColor)
                }
                .onAppear {
                    // setsData.sets = workout.setsData.sets // ???
                }
                .onDisappear {
                    // workout.update(from: data) // Im not sure itd what i need....  // lmao no
                    /*
                    setsData.sets = workout.setsData.sets // ???
                    data = workout.data
                    workout.update(from: data) // ?????????????
                     */
                    
                    // not even sure i need that code above, looks like correct binding worked
                    
                    
                    // it just works.............
                    // print("After leaving workout.exercise looks like this")
                    // print(workout.exercise)
                }
            }
        }
        .navigationTitle(workout.title)
        .toolbar {
            Button("Edit")
            {
                isPresentingEditingView = true
                data = workout.data // signs data to a new value // may be useful
            }
            .sheet(isPresented: $isPresentingEditingView) {
                NavigationView {
                    DetailEditView(data: $data, setsData: $setsData) // change to edit later
                        .navigationTitle(workout.title)
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
            }
        }
        
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // a nifty way to preview park mode
        
        Group {
            NavigationView {
                DetailView(workout: .constant(WorkoutTemplate.sampleData[0]))
            }
            
            NavigationView {
                DetailView(workout: .constant(WorkoutTemplate.sampleData[0]))
            }
            .environment(\.colorScheme, .dark)
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
