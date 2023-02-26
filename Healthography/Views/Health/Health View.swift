//
//  HealthView.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct HealthView: View {
	@StateObject var model = HealthModel()
    var body: some View {
		NavigationView {
			VStack {
				if !model.isAuthorized {
					Text("Please allow this app to use your Health data.")
				} else {
					Text("Today's Steps: \(model.userStepCount)")
						.padding()
					
					ChartView(datas: model.monthlySteps)
						.frame(height: 200)
						.padding()
				}
				
				NavigationLink(destination: CountryInfo()) {
					Text("Countries")
						.font(.title)
						.padding()
				}
				
				Spacer()
			}
		}
		.refreshable {
			model.readStepsTakenToday()
		}
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
