# 实验逻辑与证据地图

以下依据本地代码和已保存输出重建，是实验组织图，不代表每一步都已验证可从零运行。单元格编号统一为从 0 开始的 JSON cell index，和执行计数不是同一概念。

| 阶段 | 核心问题 / 操作 | 主要代码 | 数据和产物 | 当前证据 |
|---|---|---|---|---|
| 数据探索 | 序列聚类和结构聚类如何对应；结构覆盖、长度、pLDDT 如何分布 | `0 Data Exploration.ipynb` | `data/all/*cluster.tsv`、结构 PDB、EC 字典 | notebook 和部分 PDB 存在；all 目录仅云端，部分变量依赖已有内核状态 |
| 已知酶宇宙 | 同一结构簇内 EC 是否一致；GO 是否富集 | `1 Function Enrichment Analysis.ipynb` | CLEAN split100、序列簇、Foldseek 簇、UniProt GO、GO_analysis H5/RDS | cell 6 选簇内最高平均 pLDDT 代表，cell 7 用 >90；EC / GO / embedding 三部分在同一 notebook |
| 未知功能探索 | 本地簇如何映射全 AFDB；哪些大簇缺少功能解释 | `2 Unknown Universe Exploration.ipynb` | `Mem_all.txt`、`Clu_all.txt`、Universe FASTA、Disen H5 | cell 7 选择成员数严格大于 1000 且小于 2000 的簇；实际完整输入仍有缺口 |
| 表征和训练数据 | 增强数据与结构/功能标签如何进入表征学习 | `3 CLEAN & SepFun.ipynb`、`disen_part.ipynb` | `pos_con_augu.csv`、Disen train/test H5、Fun_fold H5、各种 embedding | 观察到掩码增强、MLP 和标签构建；sep_clr-master 和 embedding 目录仅云端，完整训练来源未闭合 |
| 模型比较 | 各种 embedding / triplet 配置对 EC 推断的影响 | `evaluate_models.ipynb`、`test_CLEAN.ipynb`、CLEAN_pre50 两个副本 | CLEAN 推断函数、模型权重、不同 test CSV | 提取到带明确模型名的保存指标；没有重跑，也没有确认不同文件的公平比较条件 |
| 表征分析 / 汇总 | 结构与功能信息如何体现在向量几何中 | `Summary.ipynb`、`Embedding Analysis.ipynb` | RepFunFold / RepFunEC embedding、cosine similarity、图形 | 保存输出和图片可归档；输入 embedding 目前缺失 |

## 数据角色

- 原始来源候选：UniProt reviewed TSV、AFDB representative/member 表、检索到的序列/结构。这里只根据文件名和读取关系标注，尚未验证每份文件的下载时间、版本与授权。
- 中间与派生数据：各类 `Disen*.h5`、`Fun_fold.h5`、`local2Universe.h5`、GO_analysis、采样/增强 CSV 和 FASTA。
- 模型资产：embedding H5、CLEAN/ESM 权重、外部模型目录。权重与数据不是可直接放入普通 Git 历史的代码。
- 结果：notebook 保存文本、嵌入图片、GO RDS；独立 figure 与 CLEAN results 目录仅云端，尚未取回。

## 与现有仓库研究叙事的关系

现有根 README 提出结构先验有效边界、I(S;Y)、按依赖强度分层的模型比较。该问题可以作为后续重设计方向，但本地已观察到的代码主要是结构聚类、功能一致性、表示相似度与若干 EC 预测实验。本次没有确认根 README 中所列 01–04 脚本及其“预期指标”构成已运行的流水线。

另外，单个簇内 EC 熵不是自动等同于全局互信息 I(S;Y)；后续如使用该理论，应先写清随机变量、采样总体、多标签 EC 处理和统计定义，再连接到性能比较。
