import SwiftUI
import Foundation
// Hstack wrapping https://stackoverflow.com/questions/62102647/swiftui-hstack-with-wrap-and-dynamic-height/62103264#62103264

struct StationView: View {
    @ObservedObject var viewModel: StationViewViewModel
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                HStack {
                    if viewModel.selected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                    
                    Text(viewModel.stationName)
                        .font(.headline)
                }
                
                HStack {
                    ForEach(viewModel.meansOfTransport) { transport in
                        Text(transport.name)
                            .frame(minWidth: 30)
                            .padding(.horizontal, 2)
                            .padding(2)
                            .foregroundStyle(.white)
                            .background(transport.isActive ? transport.color : Color.gray)
                            .cornerRadius(4)
                            .onTapGesture {
                                viewModel.toggleTransport(transport)
                            }
                    }
                }
            }
            Spacer()
            Image(systemName: "line.3.horizontal")
                .resizable()
                .frame(width: 22, height: 10)
                .foregroundStyle(Color(UIColor.lightGray))
        }
    }
}

#Preview {
    let viewModel = StationViewViewModel(stationName: "Alexanderplatz",
                                         stationId: "12345",
                                         selected: true,
                                         meansOfTransport: [
                                            MeansOfTransport(isActive: true, type: .bus, name: "N56"),
                                            MeansOfTransport(isActive: true, type: .tram, name: "M6"),
                                            MeansOfTransport(isActive: false, type: .tram, name: "16"),
                                         ])
    StationView(viewModel: viewModel)
        .frame(maxWidth: .infinity, alignment: .leading)
}
