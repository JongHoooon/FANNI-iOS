//
//  URLInfo+Template.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension NetworkAPI.URLInfo {
    static func TemplateAPI() -> Self {
        Self.init(host: "xxx.xxx.com", path: "path/component?id=1")
    }
}
