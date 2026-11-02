# 来源与局限

## 引擎

本快照继承自 SpektraLab 原生引擎。已有本地来源记录标注基础提交 `fd891c6bc5eb350387602deb5c1ef9b6dcdab948`，上游 https://github.com/JamesQiu2005/SpektraLab 。这不是宣称当前每个文件都与该提交逐字节相同：此前的本地修改（包括日期后背/片边行为）及后续移动适配均随引用文件保留。

`upstream-comparison.json` 对照整理时保存的本地上游参考树逐文件比较。该本地参考树本身已经可能包含历史修改，不可把“与本地参考相同”误认为“上游 Git 提交完全相同”。未伪造或重建上游 Git 历史。

## Swift/Metal 摘录

PCAdjustments ← Model/Adjustments.swift；PCCurveMath ← Model/CurveMath.swift；PCMask ← Model/Mask.swift；PCGeometry ← Model/Geometry.swift 与 CropRect；PCDecodeSettings ← DecodeSettings；PCOutputUniforms ← Canvas/ColourManagement.swift 中的 uniform 布局；PCShaders ← Canvas/Shaders.metal。包含引用文件内部的适配，不包含移动页面或独立宿主模块。

## 光谱材料

光谱模型与原始材料数据来自 Andrea Volpato / spektrafilm。`profile-changes.json` 明确区分继承参考树中相同的数据和本地增加/修改的数据。名称带 new 的实验配置不得被描述为真实胶片的完整实测校准。`NEW_FILMS_EXPERIMENTAL.json` 记录其基底与近似调整。

印相预计算数组与其他常量位于 `spektrafilm_constants.bin`，保留时未修改字节。历史 bake 的所有输入版本尚未全部独立重建，因此本仓库保留现有上游条款与 Colour BSD 署名，并明确记录未知部分，不宣称已完成所有数组的来源考证。

## 观片调光

LightTableLampResponse.swift 中的调光响应及外圈折射来自 fuyuan9972-svg/LightTable 公开源码的 LightResponse.swift、PhotoOptics.swift、LoupeRenderer.swift，按MIT许可移植，包含iOS适配与独立EDR回退；没有其专有EDR组件。

## 公开边界

本仓库不含 UI、照片、品牌包装图或应用签名。公开部分不能替代整个App在适用GPL下的完整对应源码义务。Silverphase仅作为文档组织参考，未纳入其独立应用代码或素材。
