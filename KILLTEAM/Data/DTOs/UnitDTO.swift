//
//  UnitDTO.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

struct UnitDTO : Decodable {
    
    let title: String
    let APL: Int
    let move: Int
    let save: Int
    let wounds: Int
    
    func toDomain() -> Unit {
        Unit(
            title: title,
            APL: APL,
            move: move,
            save: save,
            wounds: wounds)
    }
}
