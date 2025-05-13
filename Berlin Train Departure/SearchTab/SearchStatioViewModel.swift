import Foundation
import Combine

final class SearchStatioViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var stations: [Station] = []
    
    private var throttler: Throttler
    private let client: BvgApi
    private var loadTask: Task<Void, Error>?
    private var cancellables = Set<AnyCancellable>()
    
    init(throttler: Throttler = Throttler(), client: BvgApi = BvgApi(client: Client.shared), stations: [Station] = []) {
        self.throttler = throttler
        self.client = client
        
        setUpSubcriptions()
    }
    
    private func setUpSubcriptions() {
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] input in
                self?.throttler.onAction {
                    self?.loadTask?.cancel()
                    self?.loadTask = Task {
                        defer {
                            self?.loadTask = nil
                        }
                        
                        let fetchedStations = try? await self?.client.getLocations(for: input)
                        
                        self?.updateStations(fetchedStations ?? [])
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateStations(_ stations: [Station]) {
        DispatchQueue.main.async {
            self.stations = stations
        }
    }
}
