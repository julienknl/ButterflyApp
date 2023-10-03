//
//  RequestService.swift
//  Butterfly
//
//  Created by Julien on 27/11/2022.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case noInternetConnection, failed, unknown
}

class RequestService {
    
    //Since we can't pass any parameter for the GET method
    //We need to do a seperate method only for get
    func simpleRequest(url: RequestURL, completion: @escaping (Result<Any, RequestError>) -> Void) {
        AF.request(url.urlString(),
                   method: .get)
        //Validate the status code
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(_):
                    completion(.success(response.data as Any))

                case .failure(_):
                    completion(.failure(self.generateError(statusCode: response.response?.statusCode ?? 0)))
                }
            })
    }
    
    //Filtering error dependant on the status code
    //This will be useful to show different messages from the UI
    //For e.g No internet connection or a failed request message
    private func generateError(statusCode: Int) -> RequestError {
        switch statusCode {
            
        case 503:
            return .noInternetConnection
            
        default:
            return .failed
        }
    }
}