//
//  VehiculeJourneysModel-Navitia.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 19/07/2024.
//

import Foundation

// MARK: - VehiculeJourneys
struct VehicleJourneys: Codable {
    let pagination: Pagination?
    let feedPublishers: [FeedPublisher]
    let disruptions: [JSONAnyVJ]
    let context: Context
    let vehicleJourneys: [VehicleJourney]
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case pagination
        case feedPublishers = "feed_publishers"
        case disruptions
        case context
        case vehicleJourneys = "vehicle_journeys"
        case links
    }
}

// MARK: - Context
struct Context: Codable {
    let currentDatetime, timezone: String

    enum CodingKeys: String, CodingKey {
        case currentDatetime = "current_datetime"
        case timezone
    }
}

// MARK: - FeedPublisher
struct FeedPublisher: Codable {
    let id, name: String
    let url: String
    let license: String
}

// MARK: - Link
struct Link: Codable {
    let href: String
    let templated: Bool
    let rel: String?
    let type: String
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalResult, startPage, itemsPerPage, itemsOnPage: Int

    enum CodingKeys: String, CodingKey {
        case totalResult = "total_result"
        case startPage = "start_page"
        case itemsPerPage = "items_per_page"
        case itemsOnPage = "items_on_page"
    }
}

// MARK: - VehicleJourney
struct VehicleJourney: Codable, Identifiable, Hashable {
    let id, name: String
    let journeyPattern: JourneyPattern
    let stopTimes: [StopTime]
    let codes: [Code]
    let validityPattern: ValidityPattern
    let calendars: [VehicleCalendar]
    let trip: JourneyPattern
    let disruptions: [JSONAnyVJ]
    let headsign: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case journeyPattern = "journey_pattern"
        case stopTimes = "stop_times"
        case codes
        case validityPattern = "validity_pattern"
        case calendars, trip, disruptions, headsign
    }
    
    static func == (lhs: VehicleJourney, rhs: VehicleJourney) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.headsign == rhs.headsign
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(headsign)
    }
}

// MARK: - Calendar
struct VehicleCalendar: Codable {
    let weekPattern: WeekPattern
    let exceptions: [Exception]?
    let activePeriods: [ActivePeriod]

    enum CodingKeys: String, CodingKey {
        case weekPattern = "week_pattern"
        case exceptions
        case activePeriods = "active_periods"
    }
}

// MARK: - ActivePeriod
struct ActivePeriod: Codable {
    let begin, end: String
}

// MARK: - Exception
struct Exception: Codable {
    let datetime: String
    let type: ExceptionType
}

enum ExceptionType: String, Codable {
    case remove = "remove"
    case add = "add"
}

// MARK: - WeekPattern
struct WeekPattern: Codable {
    let monday, tuesday, wednesday, thursday: Bool
    let friday, saturday, sunday: Bool
}

// MARK: - Code
struct Code: Codable {
    let type: CodeType
    let value: String
}

enum CodeType: String, Codable {
    case gtfsStopCode = "gtfs_stop_code"
    case source = "source"
}

// MARK: - JourneyPattern
struct JourneyPattern: Codable {
    let id, name: String
}

// MARK: - StopTime
struct StopTime: Codable {
    let arrivalTime, utcArrivalTime, departureTime, utcDepartureTime: String
    let headsign: String
    let stopPoint: StopPoint
    let pickupAllowed, dropOffAllowed, skippedStop: Bool

    enum CodingKeys: String, CodingKey {
        case arrivalTime = "arrival_time"
        case utcArrivalTime = "utc_arrival_time"
        case departureTime = "departure_time"
        case utcDepartureTime = "utc_departure_time"
        case headsign
        case stopPoint = "stop_point"
        case pickupAllowed = "pickup_allowed"
        case dropOffAllowed = "drop_off_allowed"
        case skippedStop = "skipped_stop"
    }
}

// MARK: - StopPoint
struct StopPoint: Codable {
    let id, name: String
    let codes: [Code]
    let label: String
    let coord: Coord
    let links, equipments: [JSONAnyVJ]
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: String
}

// MARK: - ValidityPattern
struct ValidityPattern: Codable {
    let beginningDate, days: String

    enum CodingKeys: String, CodingKey {
        case beginningDate = "beginning_date"
        case days
    }
}

// MARK: - Encode/decode helpers

class JSONNullVJ: Codable, Hashable {

    public static func == (lhs: JSONNullVJ, rhs: JSONNullVJ) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullVJ.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKeyVJ: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAnyVJ: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAnyVJ.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNullVJ()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNullVJ()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNullVJ()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNullVJ {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNullVJ {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNullVJ {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAnyVJ.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAnyVJ.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAnyVJ.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAnyVJ.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAnyVJ.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAnyVJ.encode(to: &container, value: self.value)
        }
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
