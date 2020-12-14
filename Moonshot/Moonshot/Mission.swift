//
//  CrewRole.swift
//  Moonshot
//
//  Created by Dave Spina on 12/13/20.
//

import Foundation


struct Mission: Codable, Identifiable{
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var launcDateDisplay: String {
        if let ld = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter.string(from: ld)
        }
        
        return "N/A"
    }
    
    var image: String {
        "apollo\(id)"
    }
}
