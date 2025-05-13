import SwiftUI

final class StationViewViewModel: ObservableObject {
    let stationName: String
    let stationId: String
    @Published var selected: Bool
    @Published var meansOfTransport: [MeansOfTransport]
    
    init(stationName: String, stationId: String, selected: Bool, meansOfTransport: [MeansOfTransport]) {
        self.stationName = stationName
        self.stationId = stationId
        self.selected = selected
        self.meansOfTransport = meansOfTransport
    }
    
    func toggleTransport(_ transport: MeansOfTransport) {
        if let index = meansOfTransport.firstIndex(where: { $0.id == transport.id }) {
            meansOfTransport[index].isActive.toggle()
        }
    }
}
