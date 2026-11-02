# 冲印房 · 第三方引用源码与适配

本仓库公开「冲印房」引用的第三方代码、相关材料数据，以及这些引用文件中的移动端适配修改。源码快照对应本地开发构建 **1.0.0 (57)**，整理日期：2026-11-02。

**这不是完整 App 仓库，也不能独立构建或还原 App。** 不包含移动界面、页面布局、原创业务模块、图标、胶片包装图、演示照片、支付码、签名证书或设备资料。本仓库不能被描述为整个 App 的完整对应源码；保留 UI 不公开，并不自动免除适用 GPL 对组合程序的对应源码要求。

## 公开范围

| 目录 | 内容 | 来源 |
|---|---|---|
| `Engine/` | C++/Metal 原生成像引擎、头文件及其适配修改 | [SpektraLab](https://github.com/JamesQiu2005/SpektraLab)，光谱模型来自 [spektrafilm](https://github.com/andreavolpato/spektrafilm) |
| `Ports/SpektraLab/` | 引用的调色/曲线/蒙版/几何/解码数据模型、Metal shader 与 uniform 布局 | SpektraLab |
| `Ports/LightTable/` | 公开调光响应及镜片外圈折射内核的 iOS 适配 | [LightTable](https://github.com/fuyuan9972-svg/LightTable) |
| `Materials/` | 材料配置、印相数据、DI 观看变换与引擎常量 | spektrafilm / SpektraLab，见分项说明 |
| `licenses/` | 上游完整许可证和署名文件 | 各权利人 |

感谢 **Hanze Qiu**、**Andrea Volpato**、**fuyuan9972-svg** 及相关依赖贡献者。上游作者未参与或背书本应用。本仓库不包含 LightTable 的专有 EDR 二进制，也不把它包含在 MIT 授权范围内。

## 阅读与验证

- [许可与材料边界](LICENSES.md)
- [来源、修改及已知限制](PROVENANCE.md)
- [逐文件哈希与来源清单](manifest.json)
- [公开范围及明确排除项](SCOPE.md)
- [修改说明](CHANGES.md)

## 模块构建

需要 Apple Silicon Mac、Xcode 与 Metal Toolchain。无联网运行服务，无开发签名要求。

```bash
bash tools/build-engine.sh macos
bash tools/build-engine.sh ios
```

输出位于 `build/<platform>/`：引擎静态库、Metal 内核和材料资源。调用方需自行实现宿主，并链接 Metal、Foundation、QuartzCore、CoreText、CoreGraphics、Accelerate 和 C++ 标准库。`Ports/SpektraLab` 是源码摘录，其缺失的移动宿主类型没有以私有实现补齐；不是可直接运行的完整 Swift 包。

本仓库没有读取或拷贝用户真实照片；构建不产生 App、IPA 或签名配置。
