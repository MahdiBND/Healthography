//
//  Route.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import Foundation
import Alamofire
import SwiftUI

	// MARK: - Endpoints
enum Route {
	case countries, covid
}

	// MARK: - Variables
extension Route {
	var path: String {
		switch self {
			case .covid:
				return "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true"
				
			case .countries:
				return "https://restcountries.com/v3.1/all"
		}
	}
	
	var method: HTTPMethod {
		switch self {
			default: return .get
		}
	}
	
	var parameters: [String: String] {
		switch self {
			default: return [:]
		}
	}
}



	// MARK: - Request Convertible
extension Route: URLRequestConvertible {
	func asURLRequest() throws -> URLRequest {
		let url = URL(string: self.path)!
		
		var request = URLRequest(url: url)
		request.method = method
		
		if method == .get {
			request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
		} else if method == .post {
			request = try JSONParameterEncoder().encode(parameters, into: request)
		}
		return request
	}
}
