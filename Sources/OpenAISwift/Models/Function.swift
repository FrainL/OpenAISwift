public enum JSONType: String, Encodable {
    case array
    case string
    case number
    case boolean
    case object
}

public enum Format: String, Encodable {
    case dateTime = "date-time"
    case time, date
    case partialTime = "partial-time"
}

public struct Function: Encodable {
    public let name: String
    public let description: String
    public let parameters: Property

    public init(name: String, description: String, properties: [String: Property], required: [String]? = nil) {
        self.name = name
        self.description = description
        self.parameters = .init(type: .object, properties: properties, required: required)
    }
}

public enum ReferOrProperty: Encodable {
    case ref
    case property(Property)

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .ref:
            try ["$ref": "#"].encode(to: encoder)
        case .property(let property):
            try property.encode(to: encoder)
        }
    }
}

public class Property: Encodable {
    public let type: JSONType
    public let description: String?
    public let format: Format?
    public let `enum`: [String]?
    public let items: ReferOrProperty?
    public let properties: [String: Property]?
    public let required: [String]?

    public init(type: JSONType, items: ReferOrProperty? = nil, description: String? = nil, format: Format? = nil, `enum`: [String]? = nil, properties: [String : Property]? = nil, required: [String]? = nil) {
        self.type = type
        self.items = items
        self.description = description
        self.format = format
        self.`enum` = `enum`
        self.properties = properties
        self.required = required
    }
}
