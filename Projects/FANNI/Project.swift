//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송형욱 on 2023/04/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name = "fanni"

let project = Project.makeModule(
    name: name,
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
    ]),
    schemes: [
        .makeScheme(target: .debug, name: name),
        .makeScheme(target: .release, name: "\(name)Release")
    ]
)
