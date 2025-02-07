//
//  ClockIcon.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct ClockIcon: View {
    var body: some View {
        Image(systemName: "clock.fill")
            .foregroundStyle(.gray)
            .aspectRatio(CGSize(width: 10, height: 10), contentMode: .fit)
            .opacity(0.5)
    }
}
