//
//  TemplateAPI_Test.swift
//  FANNI-iOSUITests
//
//  Created by 송형욱 on 2023/03/13.
//

import XCTest
import Nimble
import Quick
@testable import FANNI_iOS


final class TemplateAPI_Test: QuickSpec {
    
    
    override func spec() {
        
        var api: TemplateAPI.Template!
        
        beforeSuite {
            api = .init(request: .init(id: 1))
        }
        
        afterSuite {
            api = nil
        }
        
        describe("Template API를 호출") {
            context("TemplateAPI를 실행 시") {
                
                it("urlInfo.host == baseURL") {
                    expect(api.urlInfo.host).to(equal("api.github.com"))
                }
                
                it("urlInfo.path == Path") {
                    expect(api.urlInfo.path).to(equal("search/repositories"))
                }
                
                it("requestInfo.method == .get") {
                    expect(api.requestInfo.method).to(equal(.get))
                }
            }
        }
    }

}
