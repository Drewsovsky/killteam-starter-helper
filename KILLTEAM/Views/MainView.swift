//
//  MainView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Death Angels (starter set)") {
                    KillteamView(
                        viewModel: KillteamViewModel(
                            killteamRepository: KillteamLocalRepository()))
                }
            }
            .navigationTitle("Killteam")
        }
    }
}

#Preview {
    MainView()
}
