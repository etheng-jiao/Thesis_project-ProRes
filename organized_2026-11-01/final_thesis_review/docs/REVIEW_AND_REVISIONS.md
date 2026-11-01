# 最终论文复现审计与修订建议

审计日期：2026-11-01。对照论文：`<THESIS_FINAL_PDF>`，77 页，June 2024。以下 PDF 页码包含封面，印刷页码为 PDF 页码减 7。

本次从已保存簇成员关系和原始注释重算了可以运行的分析；没有从头重跑 Foldseek、CLEAN 或 SepFun 训练。原 PDF、原 notebook、原数据与权重内容未修改。新分析集中在 `00_reproduce_thesis.ipynb`，最新结果目录为 `04_results/reproduction_20261101_203343_390414/`。完整覆盖清单见 `experiment_ledger.md` / CSV：27 张结果图、12 张结果表。

## 1. 已经得到实证支持的部分

| 实验 | 本次实际计算 | 和论文的关系 |
|---|---|---|
| 已知酶簇 | 194,521 个成员、3,291 个簇 | 表 4.1 最终两项吻合；上游聚类没有重跑 |
| 完整 EC 列表一致性 | 一致 2,283；不一致 1,008；单成员簇 679 | 与图 4.7 / 表 4.2 的主要总数吻合 |
| GO BP | 6,459 terms / 171,659 annotated members / 1,307 clusters | 表 4.4 全部吻合 |
| GO MF | 4,294 / 187,838 / 1,318 | 表 4.4 全部吻合 |
| GO CC | 898 / 121,909 / 1,192 | 表 4.4 全部吻合 |
| GO 富集 | 从原始 UniProt TSV 重算 41,501 条 cluster-term 结果 | 全部与 R 保存结果按键对应；显著性判断一致 |
| GO 平均显著条目比例 | BP .901871；MF .859126；CC .624317 | 与论文 .90 / .86 / .62 吻合 |
| 蛋白宇宙 | flag 为 1 或 2 的成员记录 22,163,577 条，2,982 个簇 | 与论文 22.16M / 2,982 吻合；这是记录数，未额外证明全局 protein ID 无重复 |
| 选定宇宙子集 | 351 个簇、11,792 个本地成员、506,261 个宇宙成员记录 | 表 4.6 吻合，沿用旧代码反向映射取最后一个本地簇的口径 |
| 两个案例 | Q7N2V3：51 → 7,253；P20921：50 → 34,425 | 表 4.7 吻合 |
| SepFun 训练标签 | 12,621 条序列、2,809 个 EC、987 个 fold ID | 4.5 节训练规模吻合，不能代替模型复现 |

GO 重算定义：簇大小 >10；背景为这些簇中具有对应 GO aspect 注释的蛋白；不额外传播 GO 祖先节点；对每个簇观察到的 GO terms 做单侧超几何检验，并在该簇内做 BH 校正。这个定义可以数值重现保存的 R 结果，但并不证明其背景与多重检验范围是唯一合理选择。没有把保存的 p 值直接当作重算输出。

41,501 条 p 值和 41,500 条校正值在严格容差下吻合；MF/C0SPA0/GO:0043169 的极端尾概率在直接计算中出现下溢，原值约 5.81e-301、校正值约 5.23e-300。补充分析用 log survival probability 检查该数值。它不改变 .05 阈值判断。不要把微小数值差异误解为生物学不一致。

## 2. 必须先修正或核清的结果

### 表 4.3 的 EC 层级数不能复现

| 在原 1,008 个不一致簇中 | EC level 1 | level 2 | level 3 |
|---|---:|---:|---:|
| 论文报告 | 713 | 587 | 522 |
| 现存标签，每个蛋白仅取第一个 EC | 683 | 549 | 472 |
| 现存标签，比较所有 EC 前缀的集合 | 648 | 504 | 422 |

`GO_homo.ipynb` cell 13 的旧实现确实只取 `sublist[0]`。这忽略多 EC 蛋白的其他注释，并会受标签顺序影响。上述差异可能来自数据快照、成员关系或处理口径，现有证据还不能唯一定位原因。论文中的 91% / 87% / 85% 总体比例依赖这组数字，在找到原输入之前应标为待核验。

另有一个簇仅因 EC 列表顺序不同而被列为不一致；集合比较会改变它的分类。新版同时保留旧口径和集合口径，避免悄悄改写历史结果。

### “约 70% 一致”需要处理 singleton 和规模效应

2,283 / 3,291 = 69.37%，但 679 个 singleton 在定义上必然一致。排除 singleton 后为 1,604 / 2,612 = **61.41%**。建议同时报告这两个数字，明确分母。图 4.7 的趋势不是严格单调，原分箱还没有展示 size >=900 的 18 个簇。

不要把 EC 不一致直接命名为“function unrelated to structure”。这只能说明该聚类粒度下完整 EC 注释不相同；不能推断功能不依赖结构，也不能排除局部活性位点差异、注释缺失或多功能酶。

### 宇宙映射存在多对一覆盖与统计口径差异

`2 Unknown Universe Exploration.ipynb` cell 4 用 `Universe2Local_data[key] = local`，会覆盖同一宇宙簇先前的本地簇。当前 `Clu_all.txt` 包含 3,291 个本地 ID，映射到 3,044 个宇宙 ID；其中 223 个宇宙 ID 对应多个本地 ID，涉及 470 个本地 ID，总计 247 次覆盖机会。

成员 flag 筛选后，非空宇宙簇为 2,982，对应 3,229 个本地 ID；62 个映射目标没有保留成员。当前文件不能复现论文所述“552 个本地簇映射到 247 个宇宙簇，其余 2,735 个一对一”；这段文字的 552+2735=3287 也不等于 3291。不要把“覆盖次数 247”当作“多对一宇宙簇个数”。

新版保存完整 long-form local→universe 映射。表 4.6 的吻合是对旧处理的复现，不代表旧选择逻辑没有偏差。未知蛋白没有实测 EC，继承本地簇标签得到的“EC-consistent universe”应改成“universe clusters mapped from EC-consistent local clusters”。

### GO 的部分文字比例和图示需要统一定义

本次严格按“所有条目的 adjusted p < .05”计算，BP/MF/CC 的簇比例为 **59.07% / 47.19% / 24.83%**；论文文字为约 65% / 52% / 25%。前两项不符，需要检查是否把直方图接近 1 的最后一个分箱当成精确 100%。平均显著比例则已复现。

原注释导出 cell 42 循环变量是 `inner_dict`，写盘却引用 `value`；本地 `funF_ccGO.h5` 仅 800 bytes。新版避开这些导出文件，直接读取原始 UniProt 注释。GO 数量和显著比例都可能受簇大小、注释覆盖率及术语频率影响。新版增加规模分层表，不把原始组间差异直接解释为独立的功能差异。

### 表 4.11 不支持“增强后全面且显著提升”

以下是原 PDF 数字的差值审计，**不是本次模型推断结果**。

| 分组 | AugProstT5 − ProstT5 F1 | Accuracy |
|---|---:|---:|
| 全部 | +.005 | −.028 |
| 未映射 | −.043 | −.043 |
| 已映射 | +.027 | −.017 |
| EC 一致 | −.022 | −.022 |
| EC 不一致 | +.035 | −.015 |

ProstT5 增强的 F1 在三个分组上升、两个分组下降；accuracy 五个分组全部下降。ProtT5 增强的两项指标在五个分组全部下降。没有多种子方差或配对不确定性估计，不能使用统计意义上的“significant”。

未增强 ProstT5 的报告值在五组都高于 ProtT5，但这只能支持“该实验配置下表现更好”，不能单独隔离结构信息的因果作用。训练配方和模型预训练差异需要控制。

### 测试样本数可能受 CSV 表头处理影响

CLEAN 旧读取器无条件跳过首行。`new_test.csv` 没有表头，实际 195 条，旧读取器得到 194；`new2.csv` 实际 238 条，旧口径 237；`split10_re2.csv` 实际 5,837 条，旧口径 5,836。`new.csv` 与 `split100.csv` 有表头，不受该问题影响。

不能因此直接宣布表 4.11 或 4.12 使用错误分母；必须恢复每个实验的预测 ID 和输入清单后核验。旧保存输出中确有 194 样本实验。新版把两个口径并列报告。

## 3. 建议如何重写研究逻辑

建议主问题改为：**在控制样本规模与同源性后，结构聚类所定义的功能异质性，如何影响表征学习与结构引导数据增强的收益？**

这样可以将论文的三个部分连接起来：先测量结构簇的 EC/GO 异质性，再检验这种异质性是否对应预测难度，最后测试增强或双编码器能否改善特定分组。避免从“cosine 热图看起来相似”直接跳到“结构与功能不可分离”的结论。

优先补充的实验：

1. **固定评估协议。** 保存每个分组的 protein IDs、EC 标签集合、训练/测试/验证来源；去重应先于切分。增强样本也纳入同源性与结构重叠检查。所有模型使用相同样本、标签空间和阈值选择规则；阈值只在验证集选择。
2. **保存逐样本预测。** 输出真实与预测 EC 集合及候选得分，确认 accuracy 是 exact-match 还是其他定义。一起报告 micro/macro/weighted F1，避免单个 weighted F1 遮盖稀有类。报告分组样本数和簇数。
3. **估计不确定性。** 多种子训练；在相同测试样本上比较模型，用簇为单位做配对 bootstrap，避免把同簇近似重复蛋白当独立样本。没有预测记录时，不从三位小数表格伪造置信区间。
4. **增强的对照。** 相同增强数量、相同计算预算，比较无增强、随机/序列相似增强、结构相似增强；显式区分真实标签与伪标签，记录伪标签置信度。先检查测试相关信息是否参与增强选择，目前不能宣称已经确认或排除了泄漏。
5. **GO 控制。** 使用一致、可解释的背景；比较直接注释与祖先传播口径；控制簇大小和注释覆盖；在规模匹配或分层后再讨论 EC 一致性的额外作用。
6. **表征几何控制。** 余弦相似度排除对角线和重复配对；报告每簇统计而非让大簇占据所有权重；加入跨簇随机对照和标签打乱对照。新版 Mixed 案例同时报告包含自相似度的旧值与去对角线值。高余弦不能自动等同于高功能信息。
7. **SepFun 验证。** 完整记录六个编码器的 checkpoint、loss、权重、seed；用独立 held-out probe 分别测 EC 与 fold 可预测性。联合熵满足 H(Z1,Z2)=H(Z1)+H(Z2)−I(Z1;Z2)，边际熵没有固定时，最大化联合熵不等价于最小化依赖。需要首先核实代码到底优化了什么估计量。
8. **避免按结果定义可预测区域。** 图 4.27 按 Fold-null 的正确/错误排序可作可视化，但正确区域内 Fold-null 表现好是定义结果。新的分组应在看测试结果之前，由 EC 异质性、结构相似度或注释覆盖定义。

这些是下一轮实验设计，不是本次已经获得的结果。当前重点应先解决样本清单、表 4.3 和映射口径，再追加模型复杂度。

## 4. 可直接替换的英文段落

以下为新写的修订文字，未写回原 PDF。Benchmark 和 SepFun 数字明确作为 thesis-reported results 使用；完成重新推断后应更新状态。

### Revised result: EC consistency

Using the saved cluster membership and EC annotations, we recovered 3,291 clusters containing 194,521 proteins. Under the original ordered-list definition, 2,283 clusters (69.37%) had identical EC annotations across their members. This proportion includes 679 singleton clusters, which are necessarily consistent. Among the 2,612 non-singleton clusters, 1,604 (61.41%) were consistent. We therefore interpret these results as annotation homogeneity at the resolution of the chosen clustering pipeline, rather than evidence that function is determined by global structure. The EC hierarchy counts reported in Table 4.3 were not recovered from the available snapshot and require reconciliation before quantitative interpretation.

### Revised result: GO enrichment

Reanalysis of the dated UniProt annotations recovered the annotation counts in Table 4.4 and 41,501 cluster-term enrichment records. Using the original cluster-specific testing family and annotated-protein background, the mean fraction of significant terms was 0.902 for biological process, 0.859 for molecular function, and 0.624 for cellular component. These results demonstrate enrichment relative to the specified background. Comparisons between EC-consistent and EC-inconsistent clusters require additional control for cluster size and annotation coverage, and should not be interpreted as independent evidence of a causal structure-function relationship.

### Revised result: augmentation

In the reported benchmark, augmentation had mixed effects on ProstT5-based prediction. Weighted F1 increased from 0.437 to 0.442 on the full test set and from 0.277 to 0.312 in the EC-inconsistent subset. It decreased in the unmapped and EC-consistent subsets, while accuracy decreased in all five evaluated subsets. ProtT5-based prediction deteriorated under augmentation across all reported subsets. These observations motivate investigation of subgroup-dependent augmentation effects, but do not establish a statistically significant or uniformly beneficial effect. The original model predictions remain to be independently reproduced.

### Revised result: SepFun

The reported Fold-null encoder achieved the highest F1 among the six evaluated encoders (0.322), whereas the best EC encoder was EC-max (0.293). The entropy constraints affected the two encoder families differently. These results do not establish successful disentanglement, nor do they demonstrate that structure and function cannot be disentangled. Such claims require direct measurements of retained task information and cross-encoder dependence under controlled training conditions. The six-model benchmark remains pending independent rerun.

### Revised conclusion

This study characterizes functional annotation heterogeneity within structure-based protein clusters and examines its association with representation-based enzyme prediction. Reanalysis supports the main cluster counts and GO enrichment calculations, while identifying unresolved EC hierarchy counts and mapping definitions. The reported prediction results suggest that structural augmentation can benefit some evaluation subsets while harming others. The current evidence supports a conditional, task-dependent role for structural information; it does not establish universal gains from augmentation or the intrinsic inseparability of structure and function. Future work should prioritize reproducible evaluation manifests, subgroup-aware uncertainty estimates, and direct tests of representation content.

## 5. 还缺什么，才算“全部复现”

- `02_data/data/all/`：序列/结构簇表和测试检索映射，用于图 4.1–5、表 4.2 分解、Foldseek 分类器。
- `02_data/data/Embedding/`、CLEAN `data/prost5/`、相关 `data/pretrained/` / `esm_data/`：ProteinVec 各 aspect、ProtT5/ProstT5 及各训练模型所需输入。
- `01_code/Code/src/`、SepFun 模型目录及实际训练配置：确认六编码器和最终基准的 checkpoint 对应关系。
- CLEAN `results/`：逐样本预测与最终测试分组清单，用于核验表 4.11/4.12 的分母、阈值、指标与不确定性。

以上部分仍为云端占位或实验来源未闭合。恢复后应先做只读清单和哈希核对，再继续运行；不应执行会覆盖原资产的旧 notebook。早期 237 样本的四模型实验是另一个实验，不能代替最终论文基准。单一 notebook 中的跳过提示不代表该实验通过。
