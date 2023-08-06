public struct Function: Encodable {
    public let name: String
    public let description: String
    public let parameters: Parameters

    public init(name: String, description: String, parameters: Parameters) {
        self.name = name
        self.description = description
        self.parameters = parameters
    }
}

public struct Parameters: Encodable {
    public let type: String
    public let properties: [String: Property]
    public let required: [String]

    public init(type: String = "object", properties: [String: Property], required: [String]) {
        self.type = type
        self.properties = properties
        self.required = required
    }
}

public struct Property: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case description
        case format
        case enumValues = "enum"
    }

    public enum PropertyType: String {
        case string
        case number
        case boolean
    }

    public let type: String
    public let description: String
    public let format: String?
    public let enumValues: [String]?

    public init(type: PropertyType = .string, _ description: String, format: String? = nil, enumValues: [String]? = nil) {
        self.type = type.rawValue
        self.description = description
        self.format = format
        self.enumValues = enumValues
    }
}
