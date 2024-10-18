#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/shuttle-hq/shuttle"
TOOL_NAME="cargo-shuttle"
TOOL_TEST="cargo-shuttle --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if cargo-shuttle is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	local platform

	case "$OSTYPE" in
	darwin*) platform="apple-darwin" ;;
	linux*) platform="unknown-linux-musl" ;;
	*) fail "Unsupported platform" ;;
	esac

	local architecture

	case "$(uname -m)" in
	x86_64*) architecture="x86_64" ;;
	# They are releasing aarch64 binary since 0.36.7: https://github.com/sagiegurari/cargo-make/commit/ab3cac2261c0ba67ab6d7a277aff8252faec0b1c
	aarch64 | arm64) architecture="aarch64" ;;
	*) fail "Unsupported architecture" ;;
	esac

	# Examples of download URLs:
	# https://github.com/shuttle-hq/shuttle/releases/download/v0.47.0/cargo-shuttle-v0.47.0-x86_64-apple-darwin.tar.gz
	# https://github.com/shuttle-hq/shuttle/releases/download/v0.47.0/cargo-shuttle-v0.47.0-x86_64-unknown-linux-musl.tar.gz
	url="${GH_REPO}/releases/download/v${version}/cargo-shuttle-v${version}-${architecture}-${platform}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp "$ASDF_DOWNLOAD_PATH"/cargo-shuttle "$install_path"
		test -e "$ASDF_DOWNLOAD_PATH"/shuttle && cp "$ASDF_DOWNLOAD_PATH"/shuttle "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
