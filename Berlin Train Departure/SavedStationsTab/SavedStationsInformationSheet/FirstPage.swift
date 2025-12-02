//
//  FirstPage.swift
//  Berlin Train Departure
//
//  Created by Justus Saringer on 30.11.25.
//

import Foundation
import SwiftUI

struct FirstPage: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("How to use this page:")
                .bold()
                .font(.title2)
            
            Text("The first two items in the list are active and will be displayed in the widget. Therefore they are marked with a green checkmark.")
                .padding(.vertical)
            
            Text("active")
                .padding(.leading)
            StationView(viewModel: StationViewViewModel(stationName: "Alexanderplatz",
                                                        stationId: "12345",
                                                        selected: true,
                                                        meansOfTransport: [
                                                           MeansOfTransport(isActive: true, type: .bus, name: "N56"),
                                                           MeansOfTransport(isActive: true, type: .tram, name: "M6"),
                                                           MeansOfTransport(isActive: false, type: .tram, name: "16"),
                                                        ]))
            .padding()
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                    .stroke(.gray, lineWidth: 1)
            }
            
            Spacer()
            
            Text("inactive")
                .padding(.leading)
            StationView(viewModel: StationViewViewModel(stationName: "Jannowitzbrücke",
                                                        stationId: "123456",
                                                        selected: false,
                                                        meansOfTransport: [
                                                           MeansOfTransport(isActive: true, type: .train, name: "S7"),
                                                           MeansOfTransport(isActive: true, type: .train, name: "S3"),
                                                           MeansOfTransport(isActive: false, type: .train, name: "S9"),
                                                        ]))
            .padding()
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                    .stroke(.gray, lineWidth: 1)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Text("Preview")
        .sheet(isPresented: .constant(true)) {
            FirstPage()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .padding(.horizontal)
                .padding(.top)
        }
        
}
