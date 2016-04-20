import PackageDescription

let package = Package(
    name: "hello",
    dependencies: [
        .Package(url: "https://github.com/neonichu/CJavaVM", majorVersion: 1)
    ]
)
