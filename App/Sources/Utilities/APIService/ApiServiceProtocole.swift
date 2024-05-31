//
//  NavitiaApiProtocol.swift
//  RailMap
//
//  Created by Jérémie - Ada on 08/09/2023.
//

import Foundation

protocol ApiServiceProtocole {
    func fetchVJ(trainNumber: String, completion: @escaping (Result<VehiculeJourneys, Error>) -> Void) async
}
