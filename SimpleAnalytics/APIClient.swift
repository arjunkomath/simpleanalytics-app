//
//  APIClient.swift
//  SimpleAnalytics
//
//  Created by Arjun Komath on 1/10/19.
//  Copyright © 2019 Arjun Komath. All rights reserved.
//

import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route: String, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
    
    static func getStats(route: String, completion:@escaping (Result<Stats, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: route, decoder: jsonDecoder, completion: completion)
    }
}
