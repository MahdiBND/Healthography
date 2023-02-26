//
//  Covid Model.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import Combine
import Dispatch

class CovidModel: ObservableObject, Waitable {
	@Published var covidData = [CovidDataItem]()
	@Published var waiting = false
	
	let manager = ApiManager()
	
	init() {
		Task { await get() }
	}
	
	@MainActor
	func get() async {
		do {
			self.waiting = true
			let data = try await manager.request(.covid, type: [CovidDataItem].self)
			self.covidData = data
			self.waiting = false
		} catch {
			print(error.localizedDescription)
			self.waiting = false
		}
	}
}

