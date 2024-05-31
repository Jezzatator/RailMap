//
//  StopInfoModel.swift
//  RailMap
//
//  Created by Jérémie - Ada on 27/09/2023.
//

import SwiftUI

struct NewStopInfo {
    let id: String
    let label: String
    let coord: String
    let adress: String
    let pickUpAllowed: Bool
    let dropOffAllowed: Bool
    let skippedStop: Bool
    
    
    init(id: String,
         label: String,
         coord: String,
         adress: String,
         pickUpAllowed: Bool,
         dropOffAllowed: Bool,
         skippedStop: Bool
    ) {
        self.id = id
        self.label = label
        self.coord = coord
        self.adress = adress
        self.pickUpAllowed = pickUpAllowed
        self.dropOffAllowed = dropOffAllowed
        self.skippedStop = skippedStop
    }
    
}
