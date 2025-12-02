//
//  SecondPage.swift
//  Berlin Train Departure
//
//  Created by Justus Saringer on 30.11.25.
//

import Foundation
import SwiftUI

struct SecondPage: View {
    
    @State var gotTapped: Double = 5
    @State private var pulsePhase: Double = 0 // 0 = rest, 1 = peak
    @State private var showCircle: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("To determine which items are active for each station, tap on the bus or train icon to toggle their status.")
                .padding(.bottom)
            
            ZStack(alignment: .bottomLeading) {
                StationView(viewModel: StationViewViewModel(stationName: "Alexanderplatz",
                                                            stationId: "12345",
                                                            selected: true,
                                                            meansOfTransport: [
                                                                MeansOfTransport(isActive: false, type: .subway, name: "U2"),
                                                            ]))
                .padding()
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                        .stroke(.gray, lineWidth: 1)
                }
                
                if showCircle {
                    Circle()
                        .frame(width: 35, height: 35)
                        .offset(x: 20, y: -12)
                        .foregroundStyle(.gray)
                        .opacity((0.5 + 1.0 * pulsePhase))
                        .scaleEffect(1.0 + 0.15 * pulsePhase)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .onAppear {
                Task { @MainActor in
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    showCircle = true
                    try? await Task.sleep(nanoseconds: 50_000_000)
                    await animateSingleTapAndHide()
                }
            }
            
            Text("When toggled, they are highlighted in the specified transportation type color.")
                .padding(.vertical)
            
            HStack {
                Text("bus")
                    .frame(minWidth: 30)
                    .padding(.horizontal, 2)
                    .padding(2)
                    .foregroundStyle(.white)
                    .background(.purple)
                    .cornerRadius(4)
                
                Text("tram")
                    .frame(minWidth: 30)
                    .padding(.horizontal, 2)
                    .padding(2)
                    .foregroundStyle(.white)
                    .background(.red)
                    .cornerRadius(4)
                
                Text("subway")
                    .frame(minWidth: 30)
                    .padding(.horizontal, 2)
                    .padding(2)
                    .foregroundStyle(.white)
                    .background(.yellow)
                    .cornerRadius(4)
                
                Text("train")
                    .frame(minWidth: 30)
                    .padding(.horizontal, 2)
                    .padding(2)
                    .foregroundStyle(.white)
                    .background(.green)
                    .cornerRadius(4)
                
                Text("ferry")
                    .frame(minWidth: 30)
                    .padding(.horizontal, 2)
                    .padding(2)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(4)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                    .stroke(.gray, lineWidth: 1)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func animateSingleTapAndHide() async {
        await MainActor.run {
            withAnimation(.easeOut(duration: 0.5)) {
                pulsePhase = 1
            }
        }
        try? await Task.sleep(nanoseconds: 120_000_000)
        await MainActor.run {
            withAnimation(.easeIn(duration: 0.10)) {
                pulsePhase = 0
            }
        }
        try? await Task.sleep(nanoseconds: 80_000_000)
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.2)) {
                showCircle = false
            }
        }
    }
}

#Preview {
    Text("Preview")
        .sheet(isPresented: .constant(true)) {
            SecondPage()
                .padding()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
}
