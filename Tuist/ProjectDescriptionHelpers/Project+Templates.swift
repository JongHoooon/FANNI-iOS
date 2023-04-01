import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "com.fanni",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        schemes: [Scheme] = []
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(
                    name: .debug,
                    xcconfig: .relativeToRoot("Configurations/StaticFrameworkKit-DEV.xcconfig")
                ),
                .release(
                    name: .release,
                    xcconfig: .relativeToRoot("Configurations/StaticFrameworkKit-PROD.xcconfig")
                )
            ], defaultSettings: .recommended)

        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )
        
        let _schemes: [Scheme] = schemes

        let targets: [Target] = [appTarget, testTarget]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: _schemes
        )
    }
}

public extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        let testAction: ProjectDescription.TestAction?
        
        switch target {
        case .debug:
            testAction = .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            )
        case .release:
            testAction = nil
            
        default:
            testAction = nil
        }
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: testAction,
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
