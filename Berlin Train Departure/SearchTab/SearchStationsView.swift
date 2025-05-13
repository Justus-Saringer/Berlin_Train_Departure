import Foundation
import SwiftUI

struct SearchStationsView: View {
    @ObservedObject var viewModel: SearchStatioViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(viewModel.stations) { station in
                    Text(station.name)
                        .listRowBackground(Color.yellow)
                }
                .searchable(text: $viewModel.searchText)
                .navigationBarTitleDisplayMode(.large)
                .navigationBarTitle("Stationensuche")
//                Spacer()
            }
        }
    }
}

#Preview {
    let location = Location(type: "", id: "1234", latitude: 12.0, longitude: 13.0)
    let products = Products(suburban: true, subway: false, tram: false, bus: false, ferry: false, express: false, regional: true)
    
    SearchStationsView(viewModel: SearchStatioViewModel(
        stations: [
            Station(type: "1", id: "1", name: "Alexanderplatz", location: location, products: products),
            Station(type: "2", id: "2", name: "Bahnhof", location: location, products: products),
            Station(type: "3", id: "3", name: "Spittelmarkt", location: location, products: products),
        ]
    ))
}
