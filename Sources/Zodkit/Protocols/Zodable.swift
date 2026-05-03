import Foundation

public protocol Zodable {
    static var schema: ObjectSchema<Self> { get }
}

public extension Zodable {
    func apply() throws -> Self {
        try Self.schema.apply(self)
    }

    func validateAll() -> [ValidationError] {
        Self.schema.validateAll(self)
    }

    func validate() throws {
        _ = try Self.schema.validate(self)
    }
}
