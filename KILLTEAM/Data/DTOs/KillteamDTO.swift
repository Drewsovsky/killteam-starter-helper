//
//  KillteamDTO.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

struct KillteamDTO : Decodable {
    let name: String
    let squad: [UnitDTO]
    
    func toDomain() -> Killteam {
        Killteam(
            name: name,
            squad: squad.map{ $0.toDomain() })
    }
}
