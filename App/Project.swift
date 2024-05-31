//
//  Project.swift
//  RailMap
//
//  Created by Jérémie Patot on 24/05/2024.
//

import ProjectDescription

let project = Project(
    name: "RailMap",
    organizationName: "jeremie-ada",
    targets: [
        .target(
            name: "RailMap",
            destinations: .iOS,
            product: .app,
            bundleId: "jeremie-ada.RailMap",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "Launch Screen.storyboard"
                ]
            ),
            sources: .paths([.relativeToManifest("App/Sources/**")]),
            resources: "App/Sources/**",
            coreDataModels: [.coreDataModel("Projects/App/Sources/RailMap.xcdatamodeld")]
        ),
        .target(
            name: "RailMapTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "jeremie-ada.RailMapTests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "Launch Screen.storyboard"
                ]
            ),
            sources: .paths([.relativeToManifest("App/Sources/**")]),
            resources: "App/Sources/**",
            dependencies: [
                .target(name: "RailMap"),
                .xctest
            ]
        ),
        .target(
            name: "RailMapUITests",
            destinations: [.iPhone],
            product: .uiTests,
            bundleId: "jeremie-ada.RailMapTests"
        )
    ]
)
