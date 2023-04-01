//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송형욱 on 2023/04/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    platform: .iOS,
    product: .framework,
    packages: [
        .Rx,
        .Then,
        .SnapKit,
        .FireBase
    ],
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxRelay,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.FireBaseAuth,
        .SPM.FireBaseAnalytics,
        .SPM.FirebaseCrashlytics
    ]
)


