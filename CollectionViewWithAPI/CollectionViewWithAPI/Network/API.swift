//
//  API.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
import Alamofire


protocol GenericServiceProtocol {
    associatedtype T
    func request(params: Parameters?, completion: @escaping ((ResponseResult<T>) -> Void)) -> DataRequest
}

public typealias JSON = [String : Any]

enum ResponseResult<T> {
    case success(T)
    case failure(Error?)
}

enum EventService<T: Codable> {
    case allEvents

}

extension EventService: GenericServiceProtocol {
    
    private var url: String {
        return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/" + path
    }
    
    private var path: String {
        switch self {
        case .allEvents:
            return "sandbox/products"
    
        }
    }
    
    private var parserKey: String {
        return "result"
    }
    
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
            
        }
    }
    
    private var headers: HTTPHeaders {
        let header: HTTPHeaders = [:]
        
        switch self {
        default:
            ""
        }
        return header
    }
    
    private var encoding: ParameterEncoding {
        switch self {
        default: return JSONEncoding.default
        }
    }
    
    @discardableResult
    func request(params: [String: Any]? = nil, completion: @escaping ((ResponseResult<T>) -> Void)) -> DataRequest {
      
        return Alamofire.request(url,
                                 method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: headers)
            
            .validate(statusCode: 200...600)
            .responseJSON { response in
                DispatchQueue.main.async {
                    if let statusCode = response.response?.statusCode, statusCode == 401 {
                        NotificationCenter.default.post(name: NSNotification.Name.init("application_logout"), object: nil)
                        return
                    }
                    let statusCode = response.response?.statusCode ?? 0
                    switch response.result {
                    case .success(let json) where statusCode >= 200 && statusCode <= 299:
                        var objectData: Any = json
                        
                        if let result = json as? JSON, let object = result["data"] as? JSON {
                            objectData = object
                        } else if let result = json as? JSON, let results = result[self.parserKey] as? [JSON] {
                            objectData = results
                        } else if let result = json as? [JSON] {
                            objectData = result
                        }
                        
                        guard let obj = T.fromDictionary(objectData) else {
                            completion(.failure(nil))
                            return
                        }
                        completion(.success(obj))
                    case .success:
                        let error = NSError(domain: "error", code: statusCode, userInfo: nil)
                        completion(.failure(response.error ?? error))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
    }
}

