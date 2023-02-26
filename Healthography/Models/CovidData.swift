//
//  CovidData.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import Foundation

struct CovidDataItem: Identifiable, Codable, Hashable {
	let id = UUID()
	@Unknown private var infected: String?
	@Unknown private var recovered: String?
	@Unknown private var deceased: String?
	var country: String
	
	var cases: String { infected ?? "NA" }
	var cured: String { recovered ?? "NA" }
	var deaths: String { deceased ?? "NA" }
}

// available: infect, recov, dead != null
