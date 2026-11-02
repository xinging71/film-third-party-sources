#!/bin/bash
# Module-only build helper; no application UI, signing, or private project settings.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
mode="${1:-macos}"
case "$mode" in
 macos) sdk=macosx; target=arm64-apple-macos15.0; metal=air64-apple-macos15.0 ;;
 ios) sdk=iphoneos; target=arm64-apple-ios17.0; metal=air64-apple-ios17.0 ;;
 simulator) sdk=iphonesimulator; target=arm64-apple-ios17.0-simulator; metal=air64-apple-ios17.0-simulator ;;
 *) echo 'Usage: bash tools/build-engine.sh [macos|ios|simulator]' >&2; exit 2 ;;
esac
out="$root/build/$mode"
mkdir -p "$out/objects" "$out/air" "$out/Engine"
sdkroot="$(xcrun --sdk "$sdk" --show-sdk-path)"
objects=()
for f in "$root"/Engine/src/{core,gpu,pipeline}/*.cpp; do
 object="$out/objects/$(basename "$(dirname "$f")")-$(basename "${f%.cpp}").o"
 xcrun --sdk "$sdk" clang++ -target "$target" -isysroot "$sdkroot" -std=c++20 -O2 -fPIC \
   -I"$root/Engine/include" -I"$root/Engine/src" -I"$root/Engine/src/core" -I"$root/Engine/third_party/metal-cpp" -c "$f" -o "$object"
 objects+=("$object")
done
xcrun libtool -static -o "$out/libspektrafilm.a" "${objects[@]}"
airs=()
for f in "$root"/Engine/src/shaders/*.metal; do
 air="$out/air/$(basename "${f%.metal}").air"
 xcrun --sdk "$sdk" metal -target "$metal" -isysroot "$sdkroot" -fmetal-math-mode=safe -fmetal-math-fp32-functions=precise -c "$f" -o "$air"
 airs+=("$air")
done
xcrun metallib "${airs[@]}" -o "$out/Engine/spektrafilm.metallib"
xcrun --sdk "$sdk" metal -target "$metal" -isysroot "$sdkroot" -fmetal-math-mode=safe -fmetal-math-fp32-functions=precise -c "$root/Ports/SpektraLab/PCShaders.metal" -o "$out/air/pc.air"
xcrun metallib "$out/air/pc.air" -o "$out/Engine/pc-frontend.metallib"
cp -R "$root/Materials/Engine/." "$out/Engine/"
echo "PASS: $mode engine static library and Metal kernels. No App binary produced."
