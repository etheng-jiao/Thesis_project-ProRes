# 历史结果：已保存证据，而非本次复现实验

精确来源见 `../results/historical_metrics_evidence.json`，汇总见 CSV。以下数值都是原 notebook 的保存输出，代码可能在保存输出后被修改，因此不能仅凭执行编号证明一致性。

| notebook / cell | 模型标识 | 样本 / EC | Precision | Recall | F1 | 其他 |
|---|---|---|---|---|---|---|
| 3 CLEAN & SepFun / 51 | RepFunFoldEC_sep | 194 / 98 | .308 | .292 | .293 | ACC .366 |
| CLEAN_pre50-Copy1 / 22 | split50_triplet | 220 / 111 | .326 | .313 | .311 | ACC .391 |
| CLEAN_pre50-Copy2 / 26 | split_con_augu_50_prost_triplet | 56 / 29 | .897 | .862 | .871 | ACC .857 |
| evaluate_models / 9 | split10_triplet | 237 / 132 | .213 | .205 | .202 | AUC .602 |
| evaluate_models / 13 | split10pro_triplet | 237 / 132 | .0741 | .0456 | .0502 | AUC .523 |
| evaluate_models / 15 | split10_sub3Di_triplet | 237 / 132 | .019 | .0195 | .0183 | AUC .510 |
| evaluate_models / 17 | split10proSEQ_triplet | 237 / 132 | .224 | .205 | .204 | AUC .602 |
| test_CLEAN / 44 | split10pro_triplet | 392 / 177 | .222 | .213 | .207 | AUC .606 |

## 能说明什么

确实存在多种模型配置和 EC 预测实验的历史证据。evaluate_models 四条记录表面使用相同 train/test 参数和相同样本数，因此适合作为下一轮复现的首选候选；仍需验证样本 ID、embedding、checkpoint、阈值及评估实现。

## 不能说明什么

- 56 样本上的 .871 不能与 237 或 392 样本实验直接比较，不能称作总体最优结果。
- 不能仅从模型名称认定具体训练策略或预训练模型身份。
- ACC 与 AUC 是不同指标，不得合并为同一列进行比较。
- 未核实训练/测试同源性、增强数据泄漏、随机种子、多次运行方差和指标平均方式。
- 根 README 的 Expected Results 不属于以上历史实测证据。

## 需要单独复核的指标代码

`3 CLEAN & SepFun.ipynb` cell 101 中 F1 使用 `true_labels_full/pred_labels_full`，precision/recall 却使用另一组变量 `true_labels/pred_labels`。这段保存输出未纳入上表；不能当作同一测试集合的完整指标组。

本地 `results/figures/` 提取了原 notebook 中的 PNG，保留 notebook 名与 cell index；图片是历史可视化，未重新计算。GO_analysis 的 RDS/H5 已保存在本地快照，但本次未解析 RDS，也未从文件名推断富集显著性。
