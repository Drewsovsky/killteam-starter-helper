//
//  KillTeamLocalRepository.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//


import Foundation

protocol KillteamRepository {
    
    func fetchKillteam() async throws -> Killteam
}

struct KillteamLocalRepository : KillteamRepository {
    
    func fetchKillteam() async throws -> Killteam {
        guard let url = Bundle.main.url(forResource: "killteam_squad", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        do {
            let data = try Data(contentsOf: url)
            let responseDto = try JSONDecoder().decode(KillteamDTO.self, from: data)
            return responseDto.toDomain()
        }
        catch let error {
            throw error
        }
    }
}
