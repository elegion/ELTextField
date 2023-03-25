// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "TextField",
                      platforms: [
                          .iOS(.v12),
                      ],
                      products: [
                          .library(name: "TextField",
                                   targets: ["TextField"]),
                      ],
                      targets: [
                          .target(name: "TextField",
                                  path: "Code"),
                      ])
