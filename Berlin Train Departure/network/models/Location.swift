//
//  Location.swift
//  Berlin Train Departure
//
//  Created by Justus Saringer on 01.02.25.
//


struct Location: Decodable {
    let type, id: String
    let latitude, longitude: Double
}