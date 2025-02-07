//
//  EmptyListJourneyView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/01/2025.
//

import SwiftUI

struct EmptyListJourneyView: View {
    private var title: String?
    private var subtitle: String?
    private var paragraphe: String?
    
    public init(title: String = "Add a ticket ?", subtitle: String = "No journeys found", paragraphe: String = "Try searching for another journey or add a new one.") {
        self.title = title
        self.subtitle = subtitle
        self.paragraphe = paragraphe
    }
    
    var body: some View {
        VStack {
            Image(systemName: "train.side.front.car")
                .resizable()
                .foregroundStyle(.gray)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
                .padding()
            
            if let title = title {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            if let paragraphe = paragraphe {
                Text(paragraphe)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    EmptyListJourneyView()
}
