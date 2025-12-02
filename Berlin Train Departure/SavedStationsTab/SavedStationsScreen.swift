import Foundation
import SwiftUI

final class SavedStationsViewModel: ObservableObject {
    @Published var savedStations: [StationViewViewModel]
    @Published var isInfoSheetVisible: Bool = false
    
    init(savedStations: [StationViewViewModel]) {
        self.savedStations = savedStations
    }
    
    func move(from: IndexSet, to: Int) {
        savedStations.move(fromOffsets: from, toOffset: to)
        selectFirstTwoStations()
    }
    
    func delete(at offsets: IndexSet) {
        savedStations.remove(atOffsets: offsets)
        selectFirstTwoStations()
    }
    
    func selectFirstTwoStations() {
        for index in savedStations.indices {
            savedStations[index].selected = index == 0 || index == 1
        }
    }
    
    func saveStation(_ station: Station) {
        var transport: [MeansOfTransport] = []
        
        if station.products.bus == true {
            transport.append(MeansOfTransport(isActive: true, type: .bus, name: "Bus"))
        }
        if station.products.tram == true {
            transport.append(MeansOfTransport(isActive: true, type: .tram, name: "Tram"))
        }
        if station.products.subway == true {
            transport.append(MeansOfTransport(isActive: true, type: .subway, name: "Subway"))
        }
        if station.products.regional == true {
            transport.append(MeansOfTransport(isActive: true, type: .train, name: "Train"))
        }
        if station.products.ferry == true {
            transport.append(MeansOfTransport(isActive: true, type: .ferry, name: "Ferry"))
        }
        
        let newStation = StationViewViewModel(
            stationName: station.name,
            stationId: station.id,
            selected: false,
            meansOfTransport: transport
        )
        
        savedStations.append(newStation)
    }
}

struct SavedStationsScreen: View {
    @ObservedObject var viewModel: SavedStationsViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedStations, id: \.stationId) { station in
                    StationView(viewModel: station)
                }
                .onDelete(perform: { index in
                    viewModel.delete(at: index)
                })
                .onMove(perform: { from, to in
                    viewModel.move(from: from, to: to)
                })
            }
            .toolbar {
                Button(action: {
                    viewModel.isInfoSheetVisible = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $viewModel.isInfoSheetVisible) {
                
                TabView {
                    FirstPage()
                        .padding()
                    
                    SecondPage()
                        .padding()
                    
                    VStack {
                        Text("You can drag them to reorder them. Swipe left on an item to delete it.")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.top)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    let viewModel = SavedStationsViewModel(savedStations: [
        StationViewViewModel(stationName: "Alexanderplatz",
                             stationId: "12345",
                             selected: true,
                             meansOfTransport: [
                                MeansOfTransport(isActive: true, type: .bus, name: "N56"),
                                MeansOfTransport(isActive: true, type: .tram, name: "M6"),
                                MeansOfTransport(isActive: false, type: .tram, name: "16"),
                             ]),
        StationViewViewModel(stationName: "Spittelmarkt",
                             stationId: "12344",
                             selected: false,
                             meansOfTransport: [
                                MeansOfTransport(isActive: true, type: .bus, name: "166"),
                                MeansOfTransport(isActive: true, type: .tram, name: "165"),
                                MeansOfTransport(isActive: false, type: .subway, name: "U2"),
                             ])
    ])
    SavedStationsScreen(viewModel: viewModel)
}
