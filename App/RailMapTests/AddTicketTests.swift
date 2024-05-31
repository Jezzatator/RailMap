//
//  AddticketTests.swift
//  RailMapTests
//
//  Created by Jérémie - Ada on 19/09/2023.
//

import XCTest
@testable import RailMap

final class AddTicketTests: XCTestCase {
    
    private var viewModel: AddTicketViewModel!

    @MainActor override func setUpWithError() throws {
        viewModel = AddTicketViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
        
    func testConvertCalendarToDDMMYY_LeapDay() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20240225", end: "20240301")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["25/02/24", "26/02/24", "27/02/24", "28/02/24", "29/02/24", "01/03/24"])
    }
    
    func testConvertCalendarToDDMMYY_AllWeek() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230101", end: "20230110")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["01/01/23", "02/01/23", "03/01/23", "04/01/23", "05/01/23", "06/01/23", "07/01/23", "08/01/23", "09/01/23", "10/01/23"])
    }
    
    func testConvertCalendarToDDMMYY_Monday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: false, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "19/09/23", "20/09/23", "21/09/23", "22/09/23", "23/09/23", "24/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Tuesday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: false, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "18/09/23", "20/09/23", "21/09/23", "22/09/23", "23/09/23", "24/09/23", "25/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Wednesday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: false, thursday: true, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "18/09/23", "19/09/23", "21/09/23", "22/09/23", "23/09/23", "24/09/23", "25/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Thursday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: false, friday: true, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "18/09/23", "19/09/23", "20/09/23", "22/09/23", "23/09/23", "24/09/23", "25/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Friday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: true, friday: false, saturday: true, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "18/09/23", "19/09/23", "20/09/23", "21/09/23", "23/09/23", "24/09/23", "25/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Saturday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: true)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["17/09/23", "18/09/23", "19/09/23", "20/09/23", "21/09/23", "22/09/23", "24/09/23", "25/09/23"])
    }
    
    func testConvertCalendarToDDMMYY_Sunday() {
        // Créez un objet Calendar avec des données de test
        let weekPattern = WeekPattern(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: false)
        let activePeriod = ActivePeriod(begin: "20230917", end: "20230925")
        let calendar = Calendar(weekPattern: weekPattern, exceptions: nil, activePeriods: [activePeriod])

        // Appelez votre fonction de conversion
        let result = viewModel.convertCalendarToDDMMYY(calendar: calendar)

        // Vérifiez le résultat par rapport à ce que vous attendez
        XCTAssertEqual(result, ["18/09/23", "19/09/23", "20/09/23", "21/09/23", "22/09/23", "23/09/23", "25/09/23"])
    }
    
    func testFormatDateLettre_18Sep() {
        let dateToFormat = "18/09/23"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "18 September")
    }
    
    func testFormatDateLettre_29Fev() {
        let dateToFormat = "29/02/24"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "29 February")
    }
    
    func testFormatDateLettre_28May() {
        let dateToFormat = "28/05/1996"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "28 May")
    }
    
    func testFormatDateLettre_22Fev() {
        let dateToFormat = "02/02/1002"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "02 February")
    }
    
    func testFormatDateLettre_NA() {
        let dateToFormat = "02/"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "N/A")
    }
    
    func testFormatDateLettre_020202() {
        let dateToFormat = "02/02/02"
        
        let result = viewModel.formatDateLettre(dateToFormat)
        
        XCTAssertEqual(result, "02 February")
    }
    
    func testextractName_TGVINOUI() {
        let id = "StopPoint:OCETGV INOUI-87686006"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "TGV INOUI")
    }
    
    func testextractName_Lyria() {
        let id = "StopPoint:OCELyria-87686006"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "Lyria")
    }
    
    func testextractName_TER() {
        let id = "StopPoint:OCETrain TER-87682005"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "Train TER")
    }
    
    func testextractName_Intercites() {
        let id = "stop_point:SIN:OCEINTERCITES-87547000"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "INTERCITES")
    }
    
    func testextractName_Ouigo() {
        let id = "StopPoint:OCEOUIGO-87543017"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "OUIGO")
    }

    func testextractName_Car_TER() {
        let id = "StopPoint:OCECar TER-87741009"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "Car TER")
    }
    
    func testextractName_ICE() {
        let id = "StopPoint:OCEICE-87113001"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "ICE")
    }
    
    func testextractName_Numbers() {
        let id = "87113001"
        
        let result = viewModel.extractName(from: id)
        
        XCTAssertEqual(result, "")
    }
    
    func testformattedHour_000000() {
        let time = "000000"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "00:00")
    }
    
    func testformattedHour_165600() {
        let time = "165600"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "16:56")
    }
    
    func testformattedHour_185900() {
        let time = "185900"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "18:59")
    }
    
    func testformattedHour_065600() {
        let time = "065600"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "06:56")
    }
    
    func testformattedHour_11220() {
        let time = "112200"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "11:22")
    }
    
    func testformattedHour_Empty() {
        let time = ""
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "00:00")
    }
    
    func testformattedHour_Letters() {
        let time = "prout"
        
        let result = viewModel.formattedHour(from: time)
        
        XCTAssertEqual(result, "Erreur, mauvais format de date")
    }

    
}
