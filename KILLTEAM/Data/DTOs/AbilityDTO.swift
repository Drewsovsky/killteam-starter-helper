//
//  AbilityDTO.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 20.08.2026.
//

import Foundation

struct AbilityDTO : Decodable {
    let name: String
    let description: String
    
    func toDomain() -> Ability {
        Ability(
            name: name,
            description: description)
    }
}
