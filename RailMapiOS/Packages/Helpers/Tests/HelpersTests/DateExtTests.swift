//
//  DateExtTests.swift
//  Helpers
//
//  Created by Jérémie Patot on 15/11/2024.
//


import XCTest
@testable import Helpers

class DateExtTests: XCTestCase {

    func testFormattedTime_withDefaultFormat() {
        // Arrange
        let now = Date()
        let expectedTime = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .short)
        
        // Act
        let formattedTime = now.formattedTime()
        
        // Assert
        XCTAssertEqual(formattedTime, expectedTime, "La méthode formattedTime devrait retourner l'heure au format HH:mm.")
    }
    
    func testFormattedTime_withCustomFormat() {
        // Arrange
        let now = Date()
        let expectedTime = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .short)
        
        // Act
        let formattedTime = now.formattedTime(with: "hh:mm a")
        
        // Assert
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let expectedCustomTime = formatter.string(from: now)
        
        XCTAssertEqual(formattedTime, expectedCustomTime, "La méthode formattedTime devrait retourner l'heure au format personnalisé.")
    }

    func testTimeRemainingDescription_withFutureDate() {
        // Arrange
        let futureDate = Date().addingTimeInterval(3600)  // 1 heure dans le futur
        
        // Act
        let timeRemaining = futureDate.timeRemainingDescription()
        
        // Assert
        XCTAssertTrue(timeRemaining.contains("min"), "La description du temps restant devrait inclure 'min'.")
    }
    
    func testTimeRemainingDescription_withPastDate() {
        // Arrange
        let pastDate = Date().addingTimeInterval(-3600)  // 1 heure dans le passé
        
        // Act
        let timeRemaining = pastDate.timeRemainingDescription()
        
        // Assert
        XCTAssertEqual(timeRemaining, "Déjà parti", "La méthode timeRemainingDescription devrait retourner 'Déjà parti' pour une date passée.")
    }

    func testDuration_toFutureDate() {
        // Arrange
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(3660)  // 1 heure et 1 minute
        
        // Act
        let duration = startDate.duration(to: endDate)
        
        // Assert
        XCTAssertEqual(duration, "01h01", "La durée entre les dates devrait être '01h01'.")
    }
    
    func testDuration_toPastDate() {
        // Arrange
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(-3660)  // 1 heure et 1 minute dans le passé
        
        // Act
        let duration = startDate.duration(to: endDate)
        
        // Assert
        XCTAssertEqual(duration, "00h00", "La durée entre les dates passées devrait être '00h00'.")
    }

    func testFormattedTimeRemaining() {
        // Arrange
        let timeInterval: TimeInterval = 3660 // 1 heure et 1 minute
        
        // Act
        let formattedTimeRemaining = timeInterval.formattedTimeRemaining()
        
        // Assert
        XCTAssertEqual(formattedTimeRemaining, "1 h 1 min", "La méthode formattedTimeRemaining devrait retourner '1 h 1 min'.")
    }
}
