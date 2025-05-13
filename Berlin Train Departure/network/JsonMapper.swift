import Foundation

struct JsonMapper {
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try decoder.decode (T.self, from: data)
    }
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        try decoder.decode(type, from: data)
    }
}
