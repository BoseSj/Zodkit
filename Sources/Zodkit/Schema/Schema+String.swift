//
//  File.swift
//  Zodable
//
//  Created by Cepheus on 04/05/26.
//

import Foundation


public extension Schema where Value == String {
    func min(_ length: Int) -> Schema<String> {
        refine {
			guard $0.trimmingCharacters(in: .whitespacesAndNewlines).count >= length else {
                throw ValidationError(message: "String must be at least \(length) characters")
            }
        }
    }

    func trimmed() -> Schema<String> {
        then { value in
            let validated = try self.validate(value)
            return validated.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    func lowercased() -> Schema<String> {
        then { value in
            let validated = try self.validate(value)
            return validated.lowercased()
        }
    }
}
