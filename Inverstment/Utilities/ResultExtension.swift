//
//  ResultExtension.swift
//  Inverstment
//
//  Created by Тася Галкина on 15.07.2025.
//

import UIKit

extension Result where Success == Data, Failure == StockServiceError {
    var success: Data? {
        switch self {
        case .success(let data): return data
        case .failure: return nil
        }
    }
}
