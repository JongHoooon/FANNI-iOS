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
    dependencies: [
    ]
)
