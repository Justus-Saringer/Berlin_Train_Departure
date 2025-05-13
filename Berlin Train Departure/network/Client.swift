import Foundation

struct Client {
    static let shared = Client()
    private let mapper: JsonMapper
    
    init(jsonMapper: JsonMapper = JsonMapper()) {
        self.mapper = jsonMapper
    }
    
    func perform<ReturnType: Decodable>(path: String, method: HTTPMethod) async throws -> ReturnType {
        let (data, response) = try await performRaw(path: path, method: method)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.response
        }
        guard 200..<400 ~= httpResponse.statusCode else {
            throw ApiError.httpError(statusCode: httpResponse.statusCode)
        }
        
        return try self.mapper.decode(ReturnType.self, from: data)
    }
    
    private func performRaw(path: String, method: HTTPMethod) async throws -> (Data, URLResponse) {
        guard let url = URL(string: path) else {
            throw ApiError.couldNotCreate(message: "URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return try await URLSession.shared.data(for: request)
    }
}
