//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송형욱 on 2023/04/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "FANNI",
    platform: .iOS,
    product: .app,
    dependencies: [
        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/ThirdPartyLib"))
    ],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "ENABLE_TESTS": .boolean(true),
    ])
)
