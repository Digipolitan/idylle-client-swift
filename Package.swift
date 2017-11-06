// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "IdylleClient",
    products: [
        .library(name: "IdylleClient", targets: ["IdylleClient"])
    ],
    targets: [
        .target(name: "IdylleClient"),
        .testTarget(
            name: "IdylleClientTests",
            dependencies: [
                "IdylleClient"
            ]
        )
    ]
)
