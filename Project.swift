import ProjectDescription

let project = Project(
    name: "RailMapiOS",
    packages: [
            .package(path: "RailMapiOS/Packages/Helpers"),
        ],
    targets: [
        .target(
            name: "RailMapiOS",
            destinations: .iOS,
            product: .app,
            bundleId: "com.railmap.RailMapiOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["RailMapiOS/Sources/**"],
            resources: ["RailMapiOS/Resources/**"],
            dependencies: [.package(product: "Helpers")],
            coreDataModels: [
                .coreDataModel("CoreData/RailMap.xcdatamodeld")
            ]
        ),
        .target(
            name: "RailMapiOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.railmap.RailMapiOSTests",
            infoPlist: .default,
            sources: ["RailMapiOS/Tests/UnitTests/**"],
            resources: [],
            dependencies: [.target(name: "RailMapiOS"), .package(product: "Helpers")]
        ),
        .target(
            name: "RailMapiOSUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.railmap.RailMapiOSUITests",
            infoPlist: .default,
            sources: ["RailMapiOS/Tests/UITests/**"],
//            resources: [],
            dependencies: [
                .target(name: "RailMapiOS"),
                .package(product: "Helpers"),
                .sdk(name: "XCTest.framework", type: .framework),
                .sdk(name: "UIKit.framework", type: .framework),
            ]
        )

    ],
    resourceSynthesizers: .default //+ [.coreData()]
)
