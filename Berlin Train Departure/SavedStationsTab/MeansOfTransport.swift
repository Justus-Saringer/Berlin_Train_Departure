import Foundation
import SwiftUI

enum MeansOfTranportType {
    case bus
    case tram
    case subway
    case train
    case ferry
}

struct MeansOfTransport: Identifiable {
    var id: UUID = UUID()
    var isActive: Bool = false
    var type: MeansOfTranportType
    var color: Color {
        switch type {
        case .bus:
            return .purple
        case .tram:
            return .red
        case .subway:
            return .yellow
        case .train:
            return .green
        case .ferry:
            return .blue
        }
    }
    var name: String
}
