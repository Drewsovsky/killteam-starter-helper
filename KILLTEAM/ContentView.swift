//
//  ContentView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel: KillteamViewModel
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading, .idle:
                ProgressView("Loading roster...")
            case .failed(let error):
                Text("Error: \(error)")
            case .loaded(let killteam):
                SquadContentView(squad: killteam.squad)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
    
    struct SquadContentView : View {
        
        var squad: [Unit]
        
        @State private var selectedUnit: Unit?
        
        var body: some View {
            VStack(spacing: 0) {
                pagingControl
                dataCardsPager
            }
            .onAppear {
                if selectedUnit == nil {
                    selectedUnit = squad.first
                }
            }
        }
        
        private var pagingControl: some View {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(squad) { unit in
                            Button {
                                withAnimation {
                                    selectedUnit = unit
                                }
                            } label : {
                                Text(unit.title.prefix(1))
                                    .frame(width: 50, height: 50)
                                    .background(selectedUnit == unit ? .green : .black)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(height: 60)
            .background(.orange)
        }
        
        private var dataCardsPager: some View {
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(squad) { unit in
                            cardView(for: unit)
                                .id(unit)
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .scrollTargetLayout()
                }
                .frame(maxHeight: .infinity)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $selectedUnit)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        
        private func cardView(for unit: Unit) -> some View {
            VStack {
                Text(unit.title)
                    .font(.title)
                HStack {
                    Spacer()
                    VStack {
                        Grid {
                            GridRow {
                                statCell(title: "APL", value: String(unit.APL))
                                statCell(title: "Move", value: String(unit.move))
                            }
                            GridRow {
                                statCell(title: "Save", value: String(unit.save))
                                statCell(title: "Wounds", value: String(unit.wounds))
                            }
                        }
                    }
                }
            }
        }
        
        @ViewBuilder
        private func statCell(title: String, value: String) -> some View {
            Text(title)
            Text(value)
        }
    }
}


#Preview {
    ContentView(
        viewModel: KillteamViewModel(
            killteamRepository: KillteamLocalRepository()))
}
