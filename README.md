# Zodkit

Zodkit is a lightweight Swift schema-validation toolkit inspired by the idea of composable, chainable validators. It lets you define validation and transformation rules in a clean DSL, then apply them to Swift models with a result-builder-based object schema.

## What It Does

- Builds typed schemas for Swift values and objects.
- Supports chained validation and normalization.
- Applies transformations such as trimming and lowercasing.
- Collects all validation errors or throws on the first failure.
- Uses `WritableKeyPath` to validate model properties declaratively.

## Current Capabilities

Zodkit currently includes:

- Primitive schema builders like `string()` and `int()`
- String rules such as `min(_:)`, `trimmed()`, `lowercased()`, and `email()`
- Integer rules such as `min(_:)`
- Custom rules through `refine(_:)`
- Object-level schema composition through `object { ... }`

## Example

```swift
import Foundation

protocol UserSchema: Zodable {
    var name: String { get set }
    var email: String { get set }
}

extension UserSchema {
    static var schema: ObjectSchema<Self> {
        object {
            Field(\Self.name, string().trimmed().min(3))
            Field(\Self.email, string().trimmed().lowercased().email())
        }
    }
}

struct User: UserSchema {
    var name: String = ""
    var email: String = ""
}

let raw = User(name: "  JohnDoe  ", email: "  JOHN@EXAMPLE.COM  ")
let normalized = try raw.apply()
try normalized.validate()
```

## Project Structure

`Sources/Zodkit/Schema/`
Core schema types, primitive validators, and rule extensions.

`Sources/Zodkit/Components/`
Field wrappers used to bind schemas to object properties.

`Sources/Zodkit/Builders/`
Result-builder support for constructing object schemas.

`Sources/Zodkit/Protocols/`
The `Zodable` protocol and convenience validation helpers.

## Status

This project is an early foundation for a Swift-first validation library. The API already demonstrates composable validation, field transformation, and object schema definition, and it is well positioned for expansion into more schema types and richer rule sets.
