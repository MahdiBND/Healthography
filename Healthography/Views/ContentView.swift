//
//  ContentView.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			CovidInfo()
				.tabItem {
					Label("Covid", systemImage: "allergens")
				}
			
			HealthView()
				.tabItem {
					Label("Health", systemImage: "stethoscope")
				}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.preferredColorScheme(.dark)
    }
}
