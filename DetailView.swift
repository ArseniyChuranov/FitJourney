//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var workout: WorkoutTemplate
    
    
    @State private var newSetValue = ""
    @State private var newRepValue = ""
    @State private var newWeightValue = ""
    
    
    // create a source of truth for sets and exercises here. Test and see if I should consider moving sources somewhere else.
    
    @State private var data = WorkoutTemplate.Data() // uses data instead of sample data
    @State private var setsData = ExerciseSet.Sets() // lets try having state here // works?...
    
    // @Binding var setsData: WorkoutTemplate.Sets // i need this thing here?
    
    
    @State private var isPresentingEditingView = false
    @State private var isPresentingAddNewSetView = false // to present a view that will allow to add a new set to a card
    @State private var isPresentingEditingExerciseView = false
    
    @State private var isPresentingEgg = false
    
    var body: some View {
        List {
            if !(workout.exercise.isEmpty) {
                ForEach($workout.exercise) {$exercise in
                    NavigationLink(destination: EditExerciseCardView(exercise: $exercise)) {
                        ExerciseCardView(exercise: $exercise)
                            .listRowBackground(workout.theme.mainColor)
                    }
                }
                .onDelete {indices in
                    workout.exercise.remove(atOffsets: indices)
                }
                .onDisappear {
                    
                    // add some functionality here maybe to allow it update info?
                    // read about dispatchQueue
                    
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
            Button(action: {
                isPresentingEgg = true
            }) {
                Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
            }
        }
        .toolbar {
            Button("Edit") // maybe change it to a "+" with a feature of adding a new exercise
            {
                isPresentingEditingView = true
                // looks like its a case when it creates a new instance and depending on changes eigher opdates ot or discards. i need same structure with editing my views.
                // however if im making any changes, would it make sense to keep them?
                data = workout.data // signs data to a new value // may be useful
            }
            .sheet(isPresented: $isPresentingEditingView) {
                
                // examine this, this section suppose to update information passed from one view to another.
                
                NavigationView {
                    DetailEditView(data: $data) // change to edit later // it takes data.
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
                                    workout.update(from: data) // simply wrong // but might be necessary
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
 
 
 
 .sheet(isPresented: $isPresentingEgg) {
     withAnimation {
         Image("sunmoon")
             //.ignoresSafeArea(edges: .all)
             //.imageScale(.small)
             // .resizable()
     }
 }
 
 */
