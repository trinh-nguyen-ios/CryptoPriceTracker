//
//  NetworkServices.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

final class LocalJSONLoader {
    func load<T: Decodable>(_ filename: String) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "File not found", code: 404)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
