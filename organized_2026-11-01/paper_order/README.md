# 按原论文顺序复现：本次交付

运行目录：`<RUN_OUTPUT>`

Notebook 共 28 个代码单元已执行，无错误输出；20 张原编号图已保存。14 张尚不能完整重画的实证图保留位置与缺口。图像是数据重算，不是论文截图；字体、核密度估计细节、部分热图排序不宣称逐像素一致。

## Notebook 顺序

1. 第 3 章：图 3.1–3.7、表 3.1，数据和模型设置。
2. 第 4.1 章：结构数据处理和宇宙分布。
3. 第 4.2 章：EC、GO、功能表征。
4. 第 4.3 章：未知蛋白宇宙。
5. 第 4.4–4.5 章：CLEAN 和 SepFun；缺输入的模型明确标为未复现。
6. 附录 A：新口径与改进分析。附录 B：状态和缺失输入。

## 已实际绘制

图 3.1–3.7；图 4.6–4.15；图 4.19–4.21，共 20 张。

GO 概览图 3.3–3.5 使用能对上原图计数的 size >10 结构簇注释成员；没有把全部训练集的统计混入。图 4.19–4.20 使用旧代码的 last-local 映射规则，并明确这些是继承的本地 EC 类别。

## 尚缺的数据与配置

| 图表 | 缺口 | 当前检查 |
|---|---|---|
| Figure 4.1–4.5 | 缺少原始结构获取清单、分阶段聚类表和严格对应的 pLDDT 快照；不根据目前文件数补造原图。 | 02_data/data/all (local); 02_data/data/alignment_db (local) |
| Figure 4.16–4.18 | Mixed 本地可用，但 EC/MFO embeddings、原始序列聚类参照及共同排序不足以重建完整原图；Mixed 部分检查放在附录。 | 02_data/data/Embedding (cloud_only: 02_data/data/Embedding); 02_data/data/all (local) |
| Figure 4.22–4.23 | 缺少未知宇宙相同样本的 ProteinVec 多 aspect 表征，无法重画局部/宇宙对照。 | 02_data/data/Embedding (cloud_only: 02_data/data/Embedding); 02_data/data/Universe_1000_2000 (cloud_only: 02_data/data/Universe_1000_2000) |
| Table 4.8–4.10 | 需恢复精确测试映射、逐样本 Foldseek 预测与增强训练清单。当前不重新训练，也不补造指标。 | 02_data/data/all (local); 03_models_and_tools/tttianhao-CLEAN-0cf2cac/results (local) |
| Figure 4.24–4.25 | 缺少最终四模型精确 checkpoint/输入对应和多 aspect 参照，不能生成完整的模型对照热图与小提琴图。 | 02_data/data/Embedding (cloud_only: 02_data/data/Embedding); 03_models_and_tools/tttianhao-CLEAN-0cf2cac/data/prost5 (cloud_only: 03_models_and_tools/tttianhao-CLEAN-0cf2cac/data/prost5); 03_models_and_tools/tttianhao-CLEAN-0cf2cac/results (local) |
| Figure 4.26–4.27; Table 4.12 | 六个编码器的 checkpoint 身份、训练配置、输入 embedding 与逐样本预测不齐全。 | 03_models_and_tools/sep_clr-master/Protein_Model (cloud_only: 03_models_and_tools/sep_clr-master/Protein_Model); 01_code/Code/src (local); 02_data/data/Embedding (cloud_only: 02_data/data/Embedding) |

原代码明确引用的聚类表包括 `02_data/data/all/all_cluster.tsv`、`afall_ID50_cluster.tsv`、`select_cluster.tsv`，测试映射还涉及 `new_foldseek_key_cluster.tsv`。恢复这些文件后还需核对结构获取清单与 pLDDT 快照，不能只凭目录存在判定可复现。

## 结果状态

表 4.3 与原论文数值不一致，报告差异而不改数字。表 4.2 只能验证聚合总数，其序列/结构分解仍缺输入。表 4.11、4.12 显示的是明确标注的论文报告值，不是本次模型推断。完整最终模型训练、逐样本预测和完整多 aspect 热图均未完成。

原文件没有改写；新版覆盖的是此前新建的统一 notebook，替换前已保存备份。


公开副本移除了 notebook 输出；完整执行输出、20 张 PNG 和本地图片总览保留在本机。设置 THESIS_ROOT 和 THESIS_FINAL_PDF 后在 Python 3.11 环境运行，Rscript 用于历史 RDS 对照；本仓库不包含原始数据和模型权重。
