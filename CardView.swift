//
//  CardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct CardView: View {
    let workout: WorkoutTemplate
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.title)
                .font(.title2)
            //Spacer()
            HStack {
                Label("\(workout.exercise.count)", systemImage: "dumbbell")
                Spacer()
            }
            //.font(.caption)
        }
        .padding()
        .foregroundColor(workout.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var workout = WorkoutTemplate.sampleData[0]
    static var previews: some View {
        CardView(workout: workout)
            .background(workout.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
