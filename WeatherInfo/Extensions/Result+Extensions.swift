//
//  Result+Extensions.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 18/03/23.
//

import Foundation

typealias Result<T> = Swift.Result<T, Error>

extension Swift.Result {

    // MARK: - Public properties

    var isSuccessful: Bool {
        guard case .success = self else { return false }

        return true
    }

    var hasFailure: Bool {
        guard case .failure = self else { return false }

        return true
    }

    var value: Success? {
        guard case let .success(value) = self else { return nil }

        return value
    }

    var error: Error? {
        guard case let .failure(error) = self else { return nil }

        return error
    }
}

extension Result where Success == Void {
    static var success: Result<Success> {
        return .success(())
    }
}
