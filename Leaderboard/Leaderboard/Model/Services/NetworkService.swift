//
//  NetworkService.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import Foundation
import Alamofire

class NetworkService{
    
    static let shared = NetworkService()
    private init(){}
    
    func performRequest<T: Decodable>(from url: String,
                                      model: T.Type,
                                      method: HTTPMethod = .get,
                                      parameters: Parameters? = nil,
                                      headers: HTTPHeaders? = nil,
                                      completion: @escaping (Result<T, Error>) -> Void) -> DataRequest{
        
        let request = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: model, queue: .main, decoder: JSONDecoder()) { (response) in
                switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        return request
    }
}

