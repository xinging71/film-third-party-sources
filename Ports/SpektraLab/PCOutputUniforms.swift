import Foundation
typealias Mat9f = (Float, Float, Float, Float, Float, Float, Float, Float, Float)
typealias K22f = (Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float,
                  Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float)

/// Must match `OutputTransformUniforms` in Shaders.metal field for field and
/// in order.
struct OutputTransformUniforms: Sendable {
    /// Source linear RGB → target linear RGB, **row-major**:
    /// `out[i] = Σ_j m[3i + j] · x[j]`.
    var matrix: Mat9f = (1, 0, 0, 0, 1, 0, 0, 0, 1)
    /// The target's RGB↔XYZ pair with adaptation, and the 22 scalars the
    /// CAM16 body reads. See `shaders/gamut.metal`'s `k` for what each is.
    var cam16M2X: Mat9f = (1, 0, 0, 0, 1, 0, 0, 0, 1)
    var cam16M2R: Mat9f = (1, 0, 0, 0, 1, 0, 0, 0, 1)
    var cam16K: K22f = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    var sourceCctfMode: UInt32 = 0
    var targetCctfMode: UInt32 = 0
    /// 0 skips the compression step entirely — `algorithm: "off"`, in which
    /// case `stats[0]` stays 0.
    var cam16Active: UInt32 = 0
    /// The lightness compression's own gate, which is not the same switch:
    /// `k[15..17]` are neutralised when it is off, but with the gate *on* and
    /// those values they would not be an identity.
    var cam16Lightness: UInt32 = 0
    var cmaxNL: UInt32 = 0
    var cmaxNH: UInt32 = 0
    var _pad0: UInt32 = 0
    var _pad1: UInt32 = 0
}

