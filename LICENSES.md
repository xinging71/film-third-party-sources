# 许可与署名

本表映射已有许可，不对第三方材料增加新的授权。保留每个文件中的原始声明。

| 范围 | 条款 |
|---|---|
| SpektraLab 引用的引擎与 Swift/Metal 代码及其修改 | GPL-3.0-or-later，见 `COPYING` 与 `licenses/SpektraLab-GPL-3.0.txt` |
| spektrafilm 胶片/相纸配置、其直接衍生配置及印相预计算 LUT | CC BY-SA 4.0，上游前言与法律文本保留于 `licenses/Profiles-and-LUTs-CC-BY-SA-4.0.txt`；原作者 Andrea Volpato |
| SpektraLab 独立材料配置/滤色拟合包 | 按继承的上游材料 CC BY-SA 4.0 条款分发，保留 `Materials/Engine/PRODUCT_PROFILES_NOTICE.md` 中 Hanze Qiu 的独立建模声明；不把这些数据说成 Andrea Volpato 的原始实测数组 |
| DI 观看变换 | SpektraLab 引擎的数学观看变换，沿用 GPL 声明；不等同于材料数据的印相 LUT |
| LightTable 公开调光函数及镜片折射内核 | MIT，Copyright (c) 2026 fuyuan9972-svg，见 `licenses/LightTable-MIT.txt` |
| Apple metal-cpp | Apache-2.0，保留 vendored LICENSE 与 `licenses/metal-cpp-Apache-2.0.txt` |
| volk、stb | 各自 MIT 声明，见 `Engine/third_party`；stb 的 MIT/public-domain 双许可中采用 MIT |
| Colour 衍生数据 | 保留 Colour Developers BSD-3-Clause 声明，见 `licenses/Colour-BSD-3-Clause.txt` |
| 其他继承的引擎常量 | 沿用 spektrafilm/SpektraLab 已发表的项目许可与署名；历史数据输入版本尚未全部确定，见 PROVENANCE.md |

`Materials/Engine/spektrafilm_constants.bin` 是继承的混合数组容器，不是可统一改为 MIT 的文件。其中材料/印相派生数组沿用 CC BY-SA，Colour 数组保留 BSD 声明；不对 CIE、Hanatos 等历史输入宣称新的独立授权。

上游原始许可证及历史变更文件原样保留；历史文件里「28款未修改」的描述不能替代本快照的材料状态，新增和改动见 CHANGES.md。

没有发布任何品牌包装图片、照片、App 图标或 UI 素材；代码和数据许可不意味着取得品牌商标授权。材料名称仅用于说明所模拟的产品，不暗示官方关系。

参考结构：[Silverphase 的许可清单](https://github.com/akinal5765-byte/Silverphase/blob/main/LICENSES.md)。本应用没有因此使用 Silverphase 的代码、截图或图标。
