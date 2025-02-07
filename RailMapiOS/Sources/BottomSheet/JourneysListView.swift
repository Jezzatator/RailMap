//
//  JourneysListView.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 12/07/2024.
//

import SwiftUI

struct JourneysListView: View {
    var journeys: [Journey]
    @State var path: NavigationPath
    
    var body: some View {
                if journeys.isEmpty {
                    VStack {
                        Text("Prenons le train vers l'inconnu")
                            .fontWeight(.bold)
                        Text("Utilisez la barre de recherche ou")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Button(action: {
                            print("trajet aléatoire")
                        }, label: {
                            Text("Ajoutez un trajet aléatoire")
                                .font(.subheadline)
                        })
                    }
                } else {
            List(journeys, id: \.self) { journey in
                JourneyRowView(journey: journey)
                    .onTapGesture {
                        path.append(journey)
                    }
            }
            .listStyle(.plain)
         }
    }
}

#Preview {
    JourneysListView(journeys: [Journey()], path: NavigationPath())
}
