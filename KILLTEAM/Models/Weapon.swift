//
//  Weapon.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 14.08.2026.
//

struct Weapon : Hashable {
    let name: String
    let isRanged: Bool
    let attacks: Int
    let hit: String
    let damage: String
    let rules: [String]?
}
