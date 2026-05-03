//
//  File.swift
//  Zodable
//
//  Created by Cepheus on 04/05/26.
//

import Foundation


public extension Schema where Value == Int {
    func min(_ value: Int) -> Schema<Int> {
        refine {
            guard $0 >= value else {
                throw ValidationError(message: "Must be >= \(value)")
            }
        }
    }
}
