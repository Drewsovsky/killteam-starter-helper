//
//  KillTeamLocalRepository.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//


import Foundation

protocol KillteamRepository {
    
    func fetchKillteam() async throws -> Killteam
    
    func fetchWeapons() async throws -> [Weapon]
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
    
    // MARK: Mock data for testing
    func fetchWeapons() async throws -> [Weapon] {
        do {
            let killteam = try await fetchKillteam()
            return killteam.squad.first!.weapons
        }
        catch let error {
            throw error
        }
    }
}

//
//import Playgrounds
//
//#Playground {
//    let repo = KillteamLocalRepository()
//    do {
//        let data = try await repo.fetchWeapons()
//        print(data)
//    }
//    catch let error {
//        print(error)
//    }
//}
