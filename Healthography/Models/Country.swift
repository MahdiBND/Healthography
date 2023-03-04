//
//  Country.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import Foundation

struct Country: Codable, Hashable {
//	let id = UUID()
	var name: CountryName
	var capital: [String]?
	var subregion: String?
	var timezones: [String]?
	var flags: CountryFlag
	var area: Double
}

struct CountryName: Codable, Hashable {
	var common: String
}

struct CountryFlag: Codable, Hashable {
	var png: String
}

enum Sort {
	case name, area
}
