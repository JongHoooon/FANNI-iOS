//
//  NetworkAPI+RequestInfo.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension NetworkAPI {
    /**
     URLRequest에서 사용할 정보
     */
    struct RequestInfo<T: Encodable> {
        var method: Method
        var headers: [String: String]?
        var parameters: T?
        
        init(
            method: NetworkAPI.Method,
            headers: [String : String]? = nil,
            parameters: T? = nil
        ) {
            self.method = method
            self.headers = headers
            self.parameters = parameters
        }
    }
}

extension NetworkAPI.RequestInfo {
    /**
     요청 메소드
     */
    func requests(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = parameters.flatMap { try? JSONEncoder().encode($0) }
        headers.map {
            request.allHTTPHeaderFields?.merge($0) { lhs, rhs in lhs }
        }
        return request
    }
}
