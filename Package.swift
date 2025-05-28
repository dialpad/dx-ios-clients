// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DialpadChatbot",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "DialpadChatbot",
            targets: ["DialpadChatbot"])
    ],
    targets: [
        .target(
            name: "DialpadChatbot",
            dependencies: [])
    ]
)
