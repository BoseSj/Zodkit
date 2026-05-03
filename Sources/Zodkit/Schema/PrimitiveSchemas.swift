import Foundation

public func string() -> Schema<String> {
    Schema { value in
        value
    }
}

public func int() -> Schema<Int> {
    Schema { value in
        value
    }
}

public extension Schema {
    /// Adds a custom validation rule to an existing schema.
    ///
    /// Example:
    /// ```swift
    /// struct SignupForm: Zodable {
    ///     var username: String
    ///     var age: Int
    ///
    ///     static var schema: ObjectSchema<SignupForm> {
    ///         object {
    ///             Field(\.username, string().trimmed().lowercased().min(5))
    ///             Field(\.age, int().refine { value in
    ///                 guard value != 99 else {
    ///                     throw ValidationError(message: "Age 99 is reserved")
    ///                 }
    ///             })
    ///         }
    ///     }
    /// }
    ///
    /// let raw = SignupForm(username: "  Alice  ", age: 21)
    /// let normalized = try raw.apply()
    /// try normalized.validate()
    /// ```
	func refine(_ rule: @escaping (Value) throws -> Void) -> Schema<Value> {
		then { value in
			_ = try self.validate(value)
			try rule(value)
			return value
		}
	}
}

public extension Schema where Value == String {
	func email() -> Schema<String> {
		refine { value in
			let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
			let range = NSRange(value.startIndex..<value.endIndex, in: value)
			let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
			guard regex.firstMatch(in: value, options: [], range: range) != nil else {
				throw ValidationError(message: "Invalid email address")
			}
		}
	}
}
