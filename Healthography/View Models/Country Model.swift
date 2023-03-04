//
//  Country Model.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import Combine

class CountryModel: ObservableObject, Waitable {
	@Published var countries = [Country]()
	@Published var waiting: Bool = false
	
	let manager = ApiManager()
	
	init() { Task { await get() } }
	
	@MainActor
	func get() async {
		do {
			waiting = true
			let data = try await manager.request(.countries, type: [Country].self)
			self.countries = data.sorted { $0.name.common < $1.name.common }
			waiting = false
		} catch {
			print(error)
			waiting = false
		}
	}
	
	func sortedCountries(by sort: Sort) -> [Country] {
		return countries.sorted {
			sort == .name ? ($0.name.common < $1.name.common) :
			($0.area > $1.area)
		}
	}
}
