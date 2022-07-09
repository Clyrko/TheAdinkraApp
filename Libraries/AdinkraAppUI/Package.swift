// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdinkraAppUI",
    defaultLocalization: "en",
    platforms: [.iOS("13.4")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AdinkraAppUI",
            targets: ["AdinkraAppUI"]),
    ],
    dependencies: [
//        .package(path: "../AdinkraAppDomainData"),
        .package(path: "../AdinkraAppPresentation"),
        .package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", from: "3.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdinkraAppUI",
            dependencies: [
                "Lottie",
                .product(
                    name: "AdinkraAppPresentation",
                    package: "AdinkraAppPresentation"
                )
            ],
            resources: [
                .process("AdinkraAppObjectDetectionOne.mlmodel"),
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AdinkraAppUITests",
            dependencies: ["AdinkraAppUI"]),
    ]
)
