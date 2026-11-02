import CoreImage
import Foundation

// Adapted from LightTable/LightResponse.swift and PhotoOptics.swift.
// Copyright (c) 2026 fuyuan9972-svg. MIT; see Resources/Licenses/LightTable-MIT.txt.
// EDR expansion is an independent iOS fallback; no proprietary LightTableEDR binary.
enum LightTableLampResponse {
    static func photoLevel(_ brightness: Double) -> Double { sqrt(min(1, max(0.1, brightness.isFinite ? brightness : 1))) }
    static func brightMix(_ brightness: Double) -> Double { min(1, max(0, brightness - 1)/0.6) }
    private static let kernel = CIColorKernel(source: """
        kernel vec4 lampResponse(__sample color, float power, float edr) {
            float p = max(color.r, max(color.g, color.b));
            float signal = max(dot(color.rgb, vec3(0.2126,0.7152,0.0722)), p*0.35);
            vec3 result = color.rgb * (1.0 + 0.45*smoothstep(0.02,0.35,signal)*max(0.0,1.0-p));
            result *= sqrt(min(1.0,max(0.1,power)));
            float sourcePeak = max(result.r,max(result.g,result.b));
            float gain = max(1.0,power)*1.101531648960814;
            float peak = sourcePeak*gain;
            float excess = max(0.0,peak-0.80);
            float shoulder = 0.80+0.20*excess/(0.20+excess);
            float outputPeak = peak>0.80 ? max(sourcePeak,shoulder) : peak;
            result *= sourcePeak>0.0 ? outputPeak/sourcePeak : gain;
            if (edr>0.5) {
                float headroom = max(1.0,power*1.5);
                result *= 1.0+(headroom-1.0)*smoothstep(0.04,0.50,signal);
            }
            return vec4(result,color.a);
        }
        """)
    static func apply(_ image: CIImage, gain: Double, edr: Bool) -> CIImage {
        if gain < 0 { return image.applyingFilter("CIExposureAdjust", parameters:["inputEV":log2(max(0.05,-gain))]) }
        return kernel?.apply(extent: image.extent, arguments:[image,min(1.6,max(0.1,gain)),edr ? 1.0 : 0.0]) ?? image
    }
}

// Edge kernel ported from LightTable/LoupeRenderer.swift under the same MIT notice.
// The central 75% stays straight; the bounded outer inset avoids radial foldover.
enum LightTableLensOptics {
    static let maximumInset: CGFloat = 0.032
    private static let edge = CIWarpKernel(source: """
        kernel vec2 loupeEdge(vec2 centre, float radius, float strength) {
            vec2 delta = destCoord() - centre;
            float distance = length(delta);
            float r = distance / radius;
            float shoulder = smoothstep(0.75, 1.0, r);
            float lip = smoothstep(0.94, 1.0, r);
            float inset = radius * (0.028 * shoulder + 0.004 * lip) * strength;
            return centre + delta * (1.0 - inset / max(distance, 0.001));
        }
        """)
    static func apply(_ scene: CIImage, side: CGFloat) -> CIImage {
        let extent = CGRect(x:0,y:0,width:side,height:side), radius = side/2
        return edge?.apply(extent:extent, roiCallback:{ _, rect in rect.insetBy(dx:-radius*maximumInset-1,dy:-radius*maximumInset-1) },
            image:scene, arguments:[CIVector(x:radius,y:radius),radius,1.0])?.cropped(to:extent) ?? scene.cropped(to:extent)
    }
}
