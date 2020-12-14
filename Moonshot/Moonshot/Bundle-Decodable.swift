//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Dave Spina on 12/13/20.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find the resource file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load JSON into the data element.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode data.")
        }
        
        return loaded
    }
}
