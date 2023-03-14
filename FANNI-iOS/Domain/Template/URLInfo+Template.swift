//
//  URLInfo+Template.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension NetworkAPI.URLInfo {
    static func templateAPI() -> Self {
        Self.init(host: "api.github.com", path: "/search/repositories")
    }
}
