//
//  Products.swift
//  Berlin Train Departure
//
//  Created by Justus Saringer on 01.02.25.
//


struct Products: Decodable {
    let suburban, subway, tram, bus: Bool
    let ferry, express, regional: Bool
}
