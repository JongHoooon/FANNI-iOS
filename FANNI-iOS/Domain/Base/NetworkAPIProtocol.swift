//
//  NetworkAPIProtocol.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

protocol NetworkAPIProtocol {
    typealias URLInfo = NetworkAPI.URLInfo
    typealias RequestInfo = NetworkAPI.RequestInfo
    
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
}
