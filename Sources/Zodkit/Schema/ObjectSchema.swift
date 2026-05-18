//
//  ObjectSchema.swift
//  Zodable
//
//  Created by Cepheus on 03/05/26.
//

import Foundation


public struct ObjectSchema<Object> {
    let fields: [AnyField<Object>]

    init(fields: [AnyField<Object>]) {
        self.fields = fields
    }

    public func apply(_ object: Object) throws -> Object {
        return try fields.reduce(object) { partialResult, element in
            try element.apply(partialResult)
        }
    }
		
    public func validate(_ object: Object) throws {
        for field in fields {
            try field.validate(object)
        }
    }

    public func validateAll(_ object: Object) -> [ValidationError] {
        var errors: [ValidationError] = []
        for field in fields {
            do {
                try field.validate(object)
            } catch {
                if let error = error as? ValidationError {
                    errors.append(error)
                }
            }
        }

        return errors
    }
}
