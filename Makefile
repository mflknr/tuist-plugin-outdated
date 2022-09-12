BINARY_PATH = .build/release/tuist-outdated
RELEASE_BINARY_ASSET = tuist-plugin-outdated.tuist-plugin.zip

release-asset:
	swift build -c release
	zip -r -j -X $(RELEASE_BINARY_ASSET) $(BINARY_PATH)