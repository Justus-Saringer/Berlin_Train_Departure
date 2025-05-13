//
//  Station.swift
//  Berlin Train Departure
//
//  Created by Justus Saringer on 01.02.25.
//


struct Station: Decodable, Identifiable {
    let type, id, name: String
    let location: Location
    let products: Products
}
