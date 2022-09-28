// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "DirtAndVert",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "DirtAndVert",
            targets: ["DirtAndVert"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "DirtAndVert",
            dependencies: ["Publish"]
        )
    ]
)