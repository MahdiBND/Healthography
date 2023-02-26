//
//  Country.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import Foundation

struct Country: Identifiable, Codable, Hashable {
	let id = UUID()
	var name: CountryName
	var capital: [String]?
	var subregion: String?
	var timezones: [String]?
	var flags: CountryFlag
}

struct CountryName: Codable, Hashable {
	var common: String
}

struct CountryFlag: Codable, Hashable {
	var png: String
}
