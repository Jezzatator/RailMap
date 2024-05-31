//
//  Section2SubtitleView.swift
//  RailMap
//
//  Created by Jérémie - Ada on 15/09/2023.
//

import SwiftUI

struct Section2SubtitleView: View {
    
    @State var subTitle: String
    
    var body: some View {
        
        Text(subTitle)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .padding(.leading)
    }
}

#Preview {
    Section2SubtitleView(subTitle: "Choississez votre gare d'arrivée")
}
