//
//  UnitDTO.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import Foundation

struct UnitDTO : Decodable {
    
    let title: String
    let apl: Int
    let move: Int
    let save: Int
    let wounds: Int
    let imageName: String?
    let weapons: [WeaponDTO]?
    
    enum CodingKeys: String, CodingKey {
        case title, apl, move, save, wounds, weapons
        
        case imageName = "image_name"
    }
    
    func toDomain() -> Unit {
        Unit(
            id: UUID.init(),
            title: title,
            apl: apl,
            move: move,
            save: save,
            wounds: wounds,
            imageName: imageName,
            weapons: weapons?.map { $0.toDomain() }
        )
    }
}
