//
//  StockServiceError.swift
//  Inverstment
//
//  Created by Тася Галкина on 26.06.2025.
//

import UIKit

enum StockServiceError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case invalidJSONFormat
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "неверный URL для запроса"
        case .networkError(let error):
            return "ошибка сети: \(error.localizedDescription)"
        case .decodingError(let error):
            return "ошибка декодирования: \(error.localizedDescription)"
        case .invalidJSONFormat:
            return "неверный формат JSON"
        }
    }
}
