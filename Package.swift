// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraAccountsSDK",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "PayseraAccountsSDK", targets: ["PayseraAccountsSDK"]),
    ],
    dependencies: [
        .package(
            name: "PayseraCommonSDK",
            url: "https://github.com/paysera/swift-lib-common-sdk",
            .exact("4.3.0")
        )
    ],
    targets: [
        .target(
            name: "PayseraAccountsSDK",
            dependencies: ["PayseraCommonSDK"]
        ),
        .testTarget(
            name: "PayseraAccountsSDKTests",
            dependencies: ["PayseraAccountsSDK"]
        ),
    ]
)
