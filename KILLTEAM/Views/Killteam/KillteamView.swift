//
//  ContentView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import SwiftUI

struct KillteamView: View {
    
    let viewModel: KillteamViewModel
    
    private var squadName: String {
        switch viewModel.state {
        case .loaded(let killteam):
            return killteam.name
        default: return "Roster"
        }
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading, .idle:
                ProgressView("Loading roster...")
            case .failed(let error):
                Text("Error: \(error)")
            case .loaded(let killteam):
                SquadContentView(
                    squad: killteam.squad,
                    onWoundsChange: { unitId, delta in
                        viewModel.changeWounds(for: unitId, by: delta)
                })
            }
        }
        .navigationTitle(squadName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: open information block
                } label : {
                    Image(systemName: "info.circle")
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}


#Preview {
    KillteamView(
        viewModel: KillteamViewModel(
            killteamRepository: KillteamLocalRepository()))
}
