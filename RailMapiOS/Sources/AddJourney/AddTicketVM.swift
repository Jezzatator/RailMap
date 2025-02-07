//
//  AddTicketVM.swift
//  RailMap
//
//  Created by Jérémie - Ada on 14/09/2023.
//

import Foundation
import SwiftUI

//TODO: créer service layer

/// `AddTicketViewModel` gère la logique métier liée à l'ajout de tickets, notamment la récupération des données des voyages en véhicule et la conversion des dates.
class AddTicketVM: ObservableObject {
    
    /// L'environnement contextuel de gestion des objets.
    @Environment(\.managedObjectContext) var moc
    
    /// Les données de voyage récupérées depuis Core Data.
    @FetchRequest(sortDescriptors: []) var journey: FetchedResults<Journey>
    @FetchRequest(sortDescriptors: []) var stop: FetchedResults<Stop>
    @FetchRequest(sortDescriptors: []) var stopInfo: FetchedResults<StopInfo>

    typealias FoundationCalendar = Foundation.Calendar
    
    /// Les voyages en véhicule actuellement disponibles.
    @Published var vehicleJourneys: [VehicleJourney] = []
    
    /// Les dates formatées associées aux voyages en véhicule.
    @Published var datePickerVehicleJourneys: [Date: String] = [:]
    
    /// Met à jour les données du sélecteur de date en fonction des voyages en véhicule.
//    func updateDatePickerVehicleJourney() {
//        datePickerVehicleJourneys = vehicleJourneys.reduce(into: [:]) { result, vehicleJourney in
//            guard let dateArray = convertCalendarToDDMMYY(calendar: vehicleJourney.calendars.first!) else { return }
//            let vehicleJourneyID = vehicleJourney.id
//            
//            dateArray.forEach { date in
//                result[date] = vehicleJourneyID
//            }
//            
//            print("datePickerVehicleJourneys KEYS: \(datePickerVehicleJourneys.keys)")
//            print("datePickerVehicleJourneys VALUER: \(datePickerVehicleJourneys.values)")
//
//        }
//    }
    
    /// Récupère les voyages en véhicule depuis une API en fonction du `headsign` spécifié.
    /// - Parameter headsign: Le signe de tête du voyage à rechercher.
    /// - Throws: Erreurs liées à la récupération des données ou à la décodage du JSON.
    func fetchHeadsignAddTicket(headsign: String) async {
        //        let urlString = "https://api.navitia.io/v1/coverage/fr-se/physical_modes/physical_mode%3ATrain/vehicle_journeys//?headsign=\(headsign)&"
        let urlString = "http://127.0.0.1:8080/stop/\(headsign)?agency=sncf&serviceType=tgv"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var responseData: Data?
        
        //        let username = "22c8f870-f331-446c-9694-749c67f88fa6"
        //        let loginData = "\(username):".data(using: .utf8)!
        //        let base64LoginData = loginData.base64EncodedString()
        //        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            responseData = data
            // Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response)")
                return
            }
            
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(VehicleJourneys.self, from: data)
            
            DispatchQueue.main.async {
                self.vehicleJourneys = decodedResponse.vehicleJourneys
            }
        } catch {
            print("Error fetching headsign data: \(error)")
            
            if let data = responseData,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print("Received JSON structure: \(json)")
            }
        }
    }
    
    /// Convertit un objet `VehicleCalendar` en un tableau de dates formatées.
    /// - Parameter calendar: Le calendrier du véhicule à convertir.
    /// - Returns: Un tableau de dates formatées en `dd/MM/yy` ou `nil` si aucune période active n'est disponible.
    func getPassageDays(from vehicleJourneys: [VehicleJourney]) -> [String: [Date]] {
        var passageDays: [String: [Date]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for journey in vehicleJourneys {
            passageDays[journey.id] = []
            
            for calendar in journey.calendars {
                // Process each active period
                for period in calendar.activePeriods {
                    guard let startDate = dateFormatter.date(from: period.begin),
                          let endDate = dateFormatter.date(from: period.end) else {
                        continue
                    }
                    
                    var currentDate = startDate
                    while currentDate <= endDate {
                        let weekday = Calendar.current.component(.weekday, from: currentDate) // 1 = Sunday, 2 = Monday, etc.
                        
                        // Check week pattern
                        let isValidDay = (weekday == 1 && calendar.weekPattern.sunday) ||
                        (weekday == 2 && calendar.weekPattern.monday) ||
                        (weekday == 3 && calendar.weekPattern.tuesday) ||
                        (weekday == 4 && calendar.weekPattern.wednesday) ||
                        (weekday == 5 && calendar.weekPattern.thursday) ||
                        (weekday == 6 && calendar.weekPattern.friday) ||
                        (weekday == 7 && calendar.weekPattern.saturday)
                        
                        if isValidDay {
                            passageDays[journey.id]?.append(currentDate)
                        }
                        
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                    }
                }
                
                // Process exceptions
                if let exceptions = calendar.exceptions {
                    for exception in exceptions {
                        if let exceptionDate = dateFormatter.date(from: exception.datetime) {
                            switch exception.type {
                            case .add:
                                if !passageDays[journey.id]!.contains(exceptionDate) {
                                    passageDays[journey.id]?.append(exceptionDate)
                                }
                            case .remove:
                                passageDays[journey.id]?.removeAll { $0 == exceptionDate }
                            }
                        }
                    }
                }
            }
            
            // Sort dates
            passageDays[journey.id]?.sort()
        }
        
        return passageDays
    }

    
    /// Formate une date en chaîne de caractères au format `dd/MM/yy`.
    /// - Parameter date: La date à formater.
    /// - Returns: La date formatée en chaîne de caractères.
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
    
    /// Formate une chaîne de caractères de date en un format lisible.
    /// - Parameter dateString: La chaîne de caractères représentant la date.
    /// - Returns: La date formatée en chaîne de caractères ou "N/A" si la conversion échoue.
    func formatDateLettre(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM"
            return outputFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    
    /// Extrait un nom de la chaîne d'entrée en utilisant une expression régulière.
    /// - Parameter input: La chaîne d'entrée contenant le nom à extraire.
    /// - Returns: Le nom extrait ou une chaîne vide si l'extraction échoue.
    func extractName(from input: String) -> String {
        let pattern = ".*:(OCE[\\w ]+)-\\d+"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let match = regex.firstMatch(in: input, options: [], range: NSRange(input.startIndex..., in: input)) {
                let range = Range(match.range(at: 1), in: input)!
                var extractedString = String(input[range])
                
                if extractedString.hasPrefix("OCE") {
                    extractedString = String(extractedString.dropFirst(3))
                }
                
                return extractedString.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            print("Regex Error: \(error)")
        }
        return ""
    }
    
    /// Formate une chaîne de caractères de date au format `HHmmss` en `HH:mm`.
    /// - Parameter dateString: La chaîne de caractères représentant l'heure.
    /// - Returns: L'heure formatée en chaîne de caractères ou un message d'erreur si la conversion échoue.
    func formattedHour(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = formatter.date(from: dateString) {
            return dateFormatter.string(from: date)
        }
        return "Erreur, mauvais format de date"
    }
}
