import Foundation

enum StationViewModelFactory {
    static func make(with station: Station) -> StationViewViewModel? {
        let viewModel = StationViewViewModel(
            stationName: station.name,
            stationId: station.id,
            selected: false,
            meansOfTransport: []
        )
        return viewModel
    }
}
