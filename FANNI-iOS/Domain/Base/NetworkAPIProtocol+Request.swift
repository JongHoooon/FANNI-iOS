//
//  NetworkAPIProtocol+Request.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension NetworkAPIProtocol {
    /*
     API 호출 로직
     */
    func request() async throws -> Response {
        let url = self.urlInfo.url
        let request = self.requestInfo.requests(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.isNotHttpURLResponse
        }
        guard httpResponse.statusCode == 200 else {
            // !!!: Retry?
            throw NetworkError.fail(httpResponse.statusCode)
        }
        
        let decodedData = try JSONDecoder().decode(Response.self, from: data)
        return decodedData
    }
}
