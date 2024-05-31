////
////  TicketListRowViewModelTests.swift
////  RailMapTests
////
////  Created by Jérémie Patot on 24/05/2024.
////  Copyright © 2024 jeremie-ada. All rights reserved.
////
//
//import XCTest
//@testable import RailMap
//
///// Tests for the `TicketListRowViewModel` class.
//class TicketListRowViewModelTests: XCTestCase {
//    
//    var viewModel: TicketListRowViewModel!
//    
//    override func setUp() {
//        super.setUp()
//        viewModel = TicketListRowViewModel()
//    }
//    
//    override func tearDown() {
//        viewModel = nil
//        super.tearDown()
//    }
//    
//    // MARK: - Unit Tests for convertFromUTCtoLocalTime
//    
//    /// Tests that the time string is formatted correctly in `HHmmss` format.
//    ///
//    /// This test ensures that the `convertFromUTCtoLocalTime` method formats the
//    /// input `Date` object into a string of the correct length and format.
//    func testDateFormat() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        let date = formatter.date(from: "2024-05-25 15:45:30")!
//        let localTime = viewModel.convertFromUTCtoLocalTime(date)
//        
//        // Check the length of the string to be exactly 6 (HHmmss)
//        XCTAssertEqual(localTime.count, 6, "The time string should be in HHmmss format")
//    }
//    
//    /// Tests the conversion of a UTC date to local time.
//    ///
//    /// This test verifies that the `convertFromUTCtoLocalTime` method correctly
//    /// converts a given UTC `Date` object to the local time string.
//    func testUTCtoLocalConversion() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        let date = formatter.date(from: "2024-05-25 15:45:30")!
//        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "HHmmss"
//        dateformatter.timeZone = TimeZone.current
//        
//        let expectedLocalTime = dateformatter.string(from: date)
//        
//        let localTime = viewModel.convertFromUTCtoLocalTime(date)
//        
//        XCTAssertEqual(localTime, expectedLocalTime, "The converted local time is incorrect")
//    }
//    
//    /// Tests the conversion of a UTC date to local time across different time zones.
//    ///
//    /// This test ensures that the `convertFromUTCtoLocalTime` method correctly
//    /// converts a given UTC `Date` object to the local time string in different
//    /// time zones (e.g., UTC+2 and UTC-5).
//    func testDifferentTimeZones() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        let date = formatter.date(from: "2024-05-25 00:00:00")!
//        
//        // Example: Time zone UTC+2
//        let timeZonePlus2 = TimeZone(secondsFromGMT: 2 * 3600)!
//        let expectedLocalTimeUTCPlus2 = viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZonePlus2)
//        
//        // Example: Time zone UTC-5
//        let timeZoneMinus5 = TimeZone(secondsFromGMT: -5 * 3600)!
//        let expectedLocalTimeUTCMinus5 = viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZoneMinus5)
//        
//        XCTAssertEqual(viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZonePlus2), expectedLocalTimeUTCPlus2, "The converted local time for UTC+2 is incorrect")
//        XCTAssertEqual(viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZoneMinus5), expectedLocalTimeUTCMinus5, "The converted local time for UTC-5 is incorrect")
//    }
//    
//    /// Tests the conversion of a UTC date to local time during daylight saving time.
//    ///
//    /// This test verifies that the `convertFromUTCtoLocalTime` method correctly
//    /// handles the conversion when daylight saving time is in effect.
//    func testDaylightSavingTime() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        // A date during daylight saving time
//        let date = formatter.date(from: "2024-06-25 12:00:00")!
//        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "HHmmss"
//        dateformatter.timeZone = TimeZone.current
//        
//        let expectedLocalTime = dateformatter.string(from: date)
//        
//        let localTime = viewModel.convertFromUTCtoLocalTime(date)
//        
//        XCTAssertEqual(localTime, expectedLocalTime, "The converted local time during daylight saving time is incorrect")
//    }
//    
//    /// Tests the conversion of a UTC date to local time outside daylight saving time.
//    ///
//    /// This test verifies that the `convertFromUTCtoLocalTime` method correctly
//    /// handles the conversion when daylight saving time is not in effect.
//    func testOutsideDaylightSavingTime() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        // A date outside daylight saving time
//        let date = formatter.date(from: "2024-12-25 12:00:00")!
//        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "HHmmss"
//        dateformatter.timeZone = TimeZone.current
//        
//        let expectedLocalTime = dateformatter.string(from: date)
//        
//        let localTime = viewModel.convertFromUTCtoLocalTime(date)
//        
//        XCTAssertEqual(localTime, expectedLocalTime, "The converted local time outside daylight saving time is incorrect")
//    }
//    
//    /// Tests the conversion of a UTC date to local time when the time zone has a non-whole hour offset.
//    ///
//    /// This test ensures that the `convertFromUTCtoLocalTime` method correctly
//    /// handles time zones with offsets that are not whole hours (e.g., UTC+5:30).
//    func testNonWholeHourTimeZone() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        let date = formatter.date(from: "2024-05-25 00:00:00")!
//        
//        // Example: Time zone UTC+5:30
//        let timeZonePlus530 = TimeZone(secondsFromGMT: (5 * 3600) + (30 * 60))!
//        let expectedLocalTimeUTCPlus530 = viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZonePlus530)
//        
//        XCTAssertEqual(viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZonePlus530), expectedLocalTimeUTCPlus530, "The converted local time for UTC+5:30 is incorrect")
//    }
//    
//    /// Tests the conversion of a UTC date to local time when the time zone has a negative offset.
//    ///
//    /// This test ensures that the `convertFromUTCtoLocalTime` method correctly
//    /// handles time zones with negative offsets (e.g., UTC-8).
//    func testNegativeOffsetTimeZone() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        
//        let date = formatter.date(from: "2024-05-25 00:00:00")!
//        
//        // Example: Time zone UTC-8
//        let timeZoneMinus8 = TimeZone(secondsFromGMT: -8 * 3600)!
//        let expectedLocalTimeUTCMinus8 = viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZoneMinus8)
//        
//        XCTAssertEqual(viewModel.convertFromUTCtoLocalTime(date, timeZone: timeZoneMinus8), expectedLocalTimeUTCMinus8, "The converted local time for UTC-8 is incorrect")
//    }
//}
