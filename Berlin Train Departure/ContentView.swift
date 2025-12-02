import SwiftUI

struct ContentView: View {
//    @ObservedObject var savedStationsViewModel = SavedStationsViewModel(savedStations: [])
    @ObservedObject var savedStationsViewModel = SavedStationsViewModel(savedStations: [
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
                                 selected: true,
                                 meansOfTransport: [
                                    MeansOfTransport(isActive: true, type: .bus, name: "166"),
                                    MeansOfTransport(isActive: true, type: .tram, name: "165"),
                                    MeansOfTransport(isActive: false, type: .tram, name: "U2"),
                                 ]),
            StationViewViewModel(stationName: "Jannowitzbrücke",
                                 stationId: "12346",
                                 selected: false,
                                 meansOfTransport: [
                                    MeansOfTransport(isActive: true, type: .train, name: "S7"),
                                    MeansOfTransport(isActive: true, type: .train, name: "S5"),
                                    MeansOfTransport(isActive: false, type: .train, name: "S9"),
                                 ])
        ])
    @ObservedObject var searchViewModel = SearchStatioViewModel()
    
    var body: some View {
        TabView {
            SearchStationsView(viewModel: searchViewModel, onStationClicked: { station in
                
            })
                .tabItem {
                    Label("Search Stations", systemImage: "magnifyingglass")
                }
                .toolbarBackground(.visible, for: .tabBar)
            
            SavedStationsScreen(viewModel: savedStationsViewModel)
                .tabItem {
                    Label("Saved Stations", systemImage: "bookmark")
                }
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
