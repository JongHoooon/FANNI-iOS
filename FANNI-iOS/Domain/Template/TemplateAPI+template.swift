//
//  TemplateAPI+template.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

extension TemplateAPI {
    struct Template: NetworkAPIProtocol {
        typealias Parameter = TemplateDTO.Request
        typealias Response = TemplateDTO.Response
        
        let urlInfo: URLInfo
        let requestInfo: RequestInfo<TemplateDTO.Request>
        
        init(request: TemplateDTO.Request) {
            self.requestInfo = .init(
                method: .get,
                headers: nil,
                parameters: request
            )
            self.urlInfo = .templateAPI()
        }
    }
}
