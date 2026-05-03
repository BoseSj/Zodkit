import Foundation

public struct Schema<Value> {
    let validate: (Value) throws -> Value

    public init(validate: @escaping (Value) throws -> Value) {
        self.validate = validate
    }
}

public extension Schema {
    func then(_ next: @escaping (Value) throws -> Value) -> Schema<Value> {
        Schema { value in
            let buffer = try self.validate(value)
            return try next(buffer)
        }
    }
}

public struct ValidationError: Error {
    public let message: String

    public init(message: String) {
        self.message = message
    }
}
