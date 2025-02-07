//
//  TrainIcon.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct TrainIcon: View {
    var body: some View {
        Image(systemName: "train.side.front.car")
            .resizable()
            .scaledToFit()
            .frame(width: 20.0)
            .foregroundColor(.blue)
            .padding(.all, 3)
            .padding(.bottom, 4)
    }
}
