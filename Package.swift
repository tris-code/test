// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Test",
    products: [
        .library(name: "Test", targets: ["Test"]),
        .library(name: "Measure", targets: ["Measure"]),
    ],
    targets: [
        .target(name: "Test"),
        .target(name: "Measure"),
        .testTarget(name: "TestTests", dependencies: ["Test"]),
        .testTarget(name: "MeasureTests", dependencies: ["Test", "Measure"])
    ]
)
