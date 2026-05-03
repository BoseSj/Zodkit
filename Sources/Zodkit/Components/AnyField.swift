//
//  AnyField.swift
//  Zodable
//
//  Created by Cepheus on 03/05/26.
//

import Foundation


public struct AnyField<Object> {
    let validate: (Object) throws -> Void
	let apply: (Object) throws -> Object
}


public func Field<Object, Value>(
	_ keyPath: WritableKeyPath<Object, Value>,
	_ schema: Schema<Value>
) -> AnyField<Object> {
	AnyField { object in
		let value = object[keyPath: keyPath]
		_ = try schema.validate(value)
	} apply: { object in
		let value = object[keyPath: keyPath]
		var newObject = object
		let newValue = try schema.validate(value)
		newObject[keyPath: keyPath] = newValue
		
		return newObject
	}
}
