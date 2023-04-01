//
//  Dependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by 송형욱 on 2023/04/01.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension Package {
    static let Rx = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift.git",
        requirement: .upToNextMajor(from: "6.5.0")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then",
        requirement: .upToNextMajor(from: "3.0.0")
    )
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.0.1")
    )
    static let FireBase = Package.remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "9.0.0")
    )
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxRelay = TargetDependency.package(product: "RxRelay")
    static let Then = TargetDependency.package(product: "Then")
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let FireBaseAuth = TargetDependency.package(product: "FireBaseAuth")
    static let FireBaseAnalytics = TargetDependency.package(product:"FireBaseAnalytics")
    static let FirebaseCrashlytics = TargetDependency.package(product: "FirebaseCrashlytics")
}
