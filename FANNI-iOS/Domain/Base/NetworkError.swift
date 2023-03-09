//
//  NetworkError.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

enum NetworkError: Error {
    case isNotHttpURLResponse
    case fail(_ statusCode: Int)
}
