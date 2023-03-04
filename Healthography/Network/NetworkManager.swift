//
//  Network.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import SwiftUI
import Alamofire
import Combine

class ApiManager {
	private var session: Session = {
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .returnCacheDataElseLoad
		config.timeoutIntervalForRequest = 20
		
		let responseCacher = ResponseCacher(behavior: .modify { _, response in
			let userInfo = ["date": Date()]
			return CachedURLResponse(
				response: response.response,
				data: response.data,
				userInfo: userInfo,
				storagePolicy: .allowed)
		})
		
		return Session(
			configuration: config,
			cachedResponseHandler: responseCacher)
	}()
	
		/// Requests Api with the given route and process response based on the type.
		/// - Returns: Response data decoded to `T`
	func request<T: Decodable>(_ route: Route, type: T.Type) async throws -> T {
		try await withCheckedThrowingContinuation { continuation in
			session.request(route).validate()
				.responseDecodable(of: type) { response in
					switch response.result {
						case .failure(let error):
							continuation.resume(throwing: error)
							return
						case .success(let value):
							continuation.resume(returning: value)
							return
					}
				}
		}
	}
}
