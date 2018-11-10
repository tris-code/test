// swift-tools-version:4.2
/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

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
