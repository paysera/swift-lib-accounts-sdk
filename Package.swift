// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraAccountsSDK",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "PayseraAccountsSDK", targets: ["PayseraAccountsSDK"]),
    ],
    dependencies: [
        .package(name: "PayseraCommonSDK", url: "https://github.com/paysera/swift-lib-common-sdk", from: "4.0.0")
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
