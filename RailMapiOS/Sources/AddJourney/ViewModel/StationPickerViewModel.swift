//
//  StationPickerViewModel.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 17/01/2025.
//

import Foundation
import CoreLocation
import MapKit

class StationPickerViewModel: ObservableObject {
    @Published var pickedJourney: DateRow
    @Published var cityNames: [String: String] = [:]
    
    private let geocoder = CLGeocoder()
    
    init(pickedJourney: DateRow) {
        self.pickedJourney = pickedJourney
    }
    
    func fetchCityName(for stopPoint: StopPoint) {
        
        guard let lat = convertToDouble(from: stopPoint.coord.lat) else { return }
        guard let lon = convertToDouble(from: stopPoint.coord.lon) else { return }
        let location = CLLocation(latitude: lat , longitude: lon)
        print("Fetching city for StopPoint \(stopPoint.id) at coordinates: \(lat), \(lon)")

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else {
                print("erreur: guard let self = self else ")
                return
            }
            if let error = error {
                print("Geocoding error: \(error)")
                return
            }
            
            if let placemark = placemarks?.first {
                print("Placemark details: \(placemark)") // Affiche les détails du placemark
                if let city = placemark.locality {
                    print("City found: \(city)")
                    DispatchQueue.main.async {
                        self.cityNames[stopPoint.id] = city
                    }
                } else {
                    print("Locality not found for \(stopPoint.id), full placemark: \(placemark)")
                }
            } else {
                print("placemarks details: \(placemarks)")
            }
        }
    }
    
    private func convertToDouble(from string: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR") // Utilise le format français
        formatter.numberStyle = .decimal
        
        if let number = formatter.number(from: string) {
            return number.doubleValue
        } else {
            print("Conversion failed for string: \(string)")
            return nil
        }
    }
}
