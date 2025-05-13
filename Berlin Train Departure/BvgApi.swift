import Foundation

struct BvgApi {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getLocations(for location: String) async throws -> [Station] {
        try await client.perform(path: "https://v6.bvg.transport.rest/locations?query=\(location)&results=3", method: .get)
    }
}

enum ApiError: Error {
    case couldNotCreate(message: String)
    case response
    case httpError(statusCode: Int)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
