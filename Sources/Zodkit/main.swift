import Foundation

/// Design Schema
protocol UserSchema: Zodable {
	var name: String { get set }
	var email: String { get set }
}

extension UserSchema {
	static var schema: ObjectSchema<Self> {
		object {
			Field(\Self.name, string().trimmed().min(3))
			Field(\Self.name, string().lowercased().trimmed().refine { value in
				if value == "example" {
					throw ValidationError(message: "not an good example")
				}
			})
			Field(\Self.email, string().email())
		}
	}
}

/// Create Concrete Model
struct User: UserSchema {
	var name: String = ""
	var email: String = ""
}

var user = User()

do {
	// Case 3: Invalid email
	user.name = "   validName   "
	user.email = "invalid-email"

	try User.schema.validate(user)
	// ❌ throws: "Invalid email"

} catch let error as ValidationError {
	print(error.message)
	// "Invalid email"
}


do {
	// Case 4: Fully valid input
	user.name = "   JohnDoe   "
	user.email = "  JOHN@EXAMPLE.COM  "

	try User.schema.validate(user)

	print(user.name)
	// "johndoe"  (trimmed + lowercased)

	print(user.email)
	// "john@example.com" (normalized email)

} catch {
	print(error)
}
