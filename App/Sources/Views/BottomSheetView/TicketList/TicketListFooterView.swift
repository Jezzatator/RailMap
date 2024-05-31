//
//  TicketListFooterView.swift
//  FlightTicketBrowser
//
//  Created by Takuya Aso on 2021/12/29.
//

import SwiftUI

struct TicketListFooterView: View {
    var body: some View {
        VStack(alignment: .leading) {
            //ForEach(TrainType.allCases, id: \.self) { type in
                HStack {
                    Image(systemName: "train.side.front.car")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12.0)
                        .foregroundColor(.blue)
                    Text("Test")
                }
        //    }
        }
    }
}

struct TicketListFooterView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListFooterView()
            .padding()
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
