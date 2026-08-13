//
//  KillTeamViewModel.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//


import Observation

enum ScreenState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(String)
    
    var isLoading: Bool {
        if case .loading = self { true } else { false }
    }
    
    var data: T? {
        if case .loaded(let value) = self { value } else { nil }
    }
    
    var error: String? {
        if case .failed(let message) = self { message } else { nil }
    }
}

@Observable
class KillteamViewModel {
    
    private let killteamRepository: KillteamRepository
    
    var state: ScreenState<Killteam> = .idle
   
    init(killteamRepository: KillteamRepository) {
        self.killteamRepository = killteamRepository
    }
    
    func fetch() async {
        guard !state.isLoading || state.error != nil else { return }
        
        self.state = .loading
        
        do {
            let killteam = try await killteamRepository.fetchKillteam()
            
            self.state = .loaded(killteam)
        }
        catch let error {
            print(error)
            self.state = .failed("unknown error")
        }
    }
}
