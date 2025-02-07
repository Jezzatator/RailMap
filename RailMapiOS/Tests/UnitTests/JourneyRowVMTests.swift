//
//  JourneyRowVMTests.swift
//  RailMapiOSTests
//
//  Created by Jérémie Patot on 26/07/2024.
//

import CoreData
import XCTest
@testable import RailMapiOS

class JourneyRowViewModelTests: XCTestCase {

    var journey: Journey!
    var viewModel: JourneyRowViewModel!
    
    override func setUp() {
        super.setUp()
        
        let context = NSPersistentContainer.preview.viewContext
        journey = Journey(context: context)
        journey.headsign = "Test Train"
        
        let departureStop = Stop(context: context)
        departureStop.status = "departure"
        let departureStopInfo = StopInfo(context: context)
        departureStopInfo.label = "Gare de TestVille"
        departureStop.stopinfo = departureStopInfo
        departureStop.departureTimeUTC = Date(timeIntervalSince1970: 16200) // 04:30 UTC
        journey.addToStops(departureStop)
        
        let arrivalStop = Stop(context: context)
        arrivalStop.status = "arrival"
        let arrivalStopInfo = StopInfo(context: context)
        arrivalStopInfo.label = "Gare de DestinationVille"
        arrivalStop.stopinfo = arrivalStopInfo
        arrivalStop.arrivalTimeUTC = Date(timeIntervalSince1970: 32400) // 09:00 UTC
        journey.addToStops(arrivalStop)
        
        journey.startDate = departureStop.departureTimeUTC
        journey.endDate = arrivalStop.arrivalTimeUTC
        
        viewModel = JourneyRowViewModel(journey: journey)
    }
    
    override func tearDown() {
        journey = nil
        viewModel = nil
        super.tearDown()
    }

    func testHeadsign() {
        XCTAssertEqual(viewModel.headsign, "Test Train")
    }
    
    func testDepartureTime() {
        XCTAssertEqual(viewModel.departureTime, "04:30")
    }
    
    func testDepartureDate() {
        XCTAssertEqual(viewModel.departureDate, "01 January") // Adjust date based on your time zone
    }
    
    func testDepartureLabel() {
        XCTAssertEqual(viewModel.departureLabel, "Gare de TestVille")
    }
    
    func testArrivalTime() {
        XCTAssertEqual(viewModel.arrivalTime, "09:00")
    }
    
    func testArrivalDate() {
        XCTAssertEqual(viewModel.arrivalDate, "01 January") // Adjust date based on your time zone
    }
    
    func testArrivalLabel() {
        XCTAssertEqual(viewModel.arrivalLabel, "Gare de DestinationVille")
    }
    
    func testDuration() {
        XCTAssertEqual(viewModel.duration, "04h30")
    }
}
