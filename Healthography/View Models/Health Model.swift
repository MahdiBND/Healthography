//
//  Health Model.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import HealthKit

/// Manager for `HealthKit`
class HealthManager {
		/// Check if `Health` is available, if the user allows, get the specified data.
	func setUpHealthRequest(healthStore: HKHealthStore, readSteps: @escaping () -> Void) {
			
			// The data we need is stepCount which is numerical, so we use `quantityType`
		if HKHealthStore.isHealthDataAvailable(), let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) {
				
				// Ask for permission
			healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount]) { success, error in
				if success {
					readSteps()
				} else if error != nil {
					print(error!.localizedDescription)
				}
			}
		}
	}
	
	func readStepCount(for date: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
			// Specify the `stepQuantityType` as the data that we want to read from `HealthKit`
		guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
		
			// We need date to get step count for a period of time
//		let now = Date()
		let startOfDay = Calendar.current.startOfDay(for: date)
		
			// Specify that time range is from start of day until now
		let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: date, options: .strictStartDate)
		
			// Now query the data (steps), Apple records data hourly, so we need to sum it up.
		let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
			
			guard let result = result, let sum = result.sumQuantity() else {
				completion(0.0)
				return
			}
			
			completion(sum.doubleValue(for: HKUnit.count()))
			
		}
			// Execute, execute, execute.
		healthStore.execute(query)
		
	}
}

// MARK: - View Model
class HealthModel: ObservableObject {
	/// Unified Storage for all `Health` related stuff. Like `Authorization` and `stepCount`.
	private var healthStore = HKHealthStore()
	private var healthManager = HealthManager()
	
	@Published var userStepCount = ""
	@Published var isAuthorized = false
	@Published var monthlySteps: [String: Double] = [:]
	
	init() {
		healthRequest()
	}
	
	func healthRequest() {
			// Request permission and follow up if granted.
		healthManager.setUpHealthRequest(healthStore: healthStore) {
			self.changeAuthorizationStatus()
			self.readStepsTakenToday()
			self.readStepsInAMonth()
		}
	}
	
	func readStepsTakenToday() {
		healthManager.readStepCount(for: Date(), healthStore: healthStore) { step in
			if step != 0.0 {
				DispatchQueue.main.async {
					self.userStepCount = String(format: "%.0f", step)
				}
			}
		}
	}
	
	func readStepsInAMonth() {
		let days = 0...30
		for day: Int in days {
			if let date = NSCalendar.current.date(byAdding: .day, value: -day, to: Date()) {
				healthManager.readStepCount(for: date, healthStore: healthStore) { step in
					DispatchQueue.main.async {
						let day = date.formatted(date: .abbreviated, time: .omitted)
						self.monthlySteps[day] = step
					}
				}
			}
		}
	}
	
	func changeAuthorizationStatus() {
			// Check if the user has authorized sharing their steps.
		guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
		let status = self.healthStore.authorizationStatus(for: stepQtyType)
		
			// Publishing changes from background threads is not allowed, use main thread instead.
		DispatchQueue.main.async {
			switch status {
				case .notDetermined:
					self.isAuthorized = false
				case .sharingDenied:
					self.isAuthorized = false
				case .sharingAuthorized:
					self.isAuthorized = true
				default:
					self.isAuthorized = false
			}
		}
	}
}
