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
            api = .init(request: .init(page: 1, q: "RxSwift"))
            
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
                    expect(api.urlInfo.path).to(equal("/search/repositories"))
                }
                
                it("requestInfo.method == .get") {
                    expect(api.requestInfo.method).to(equal(.get))
                }
                
                it("requestInfo.parameters.page == 1") {
                    expect(api.requestInfo.parameters?.page).to(equal(1))
                }
                
                it("requestInfo.parameters.q == 'RxSwift'") {
                    expect(api.requestInfo.parameters?.q).to(equal("RxSwift"))
                }
                
                it("api.request(response.name).name.contain('RxSwift')") {
                    do {
                        let response = try await api.request()
                        await expect(response.items.map { $0.name }).toEventually(contain("RxSwift"))
                    } catch {
                        print("\(error)")
                    }
                }
            }
        }
    }

}
