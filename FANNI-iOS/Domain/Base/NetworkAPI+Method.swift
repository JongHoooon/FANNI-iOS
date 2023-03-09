//
//  NetworkAPI+Method.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension NetworkAPI {
    /**
     URLRequest에서 사용할 Method
    */
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
}
