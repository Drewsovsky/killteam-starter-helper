//
//  WeaponDTO.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 14.08.2026.
//

struct WeaponDTO: Decodable {
    let name: String
    let isRanged: Bool
    let attacks: Int
    let hit: String 
    let damage: String
    let rules: [String]?
    
    enum CodingKeys : String, CodingKey {
        case name, attacks, hit, damage, rules
        
        case isRanged = "is_ranged"
    }
    
    func toDomain() -> Weapon {
        Weapon(
            name: name,
            isRanged: isRanged,
            attacks: attacks,
            hit: hit,
            damage: damage,
            rules: rules)
    }
}

