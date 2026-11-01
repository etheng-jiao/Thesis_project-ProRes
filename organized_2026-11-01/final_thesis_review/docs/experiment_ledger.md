# 最终论文逐项实验台账

来源：`<THESIS_FINAL_PDF>`，77 页。覆盖结果章的 27 张图、12 张表。图表状态表示底层计算覆盖程度，不表示已逐像素复制原图。方法章示意图不作为实验结果。

`recomputed_raw_annotations`：从原始注释和保存的簇成员关系重算；`recomputed_intermediate`：从保存中间结果重算，并未重跑上游 Foldseek；`partial`：只有部分统计或定义可核验；`reported_only`：原论文报告值；`blocked`：输入或实验配置不齐。

| 图表 | PDF页 | 内容 | 状态 | 依据或缺口 |
|---|---:|---|---|---|
| Figure 4.1 | 39 | Sequence length before/after structure retrieval | blocked | Exact retrieved ID lists / structure acquisition manifest |
| Figure 4.2 | 40 | Average pLDDT distribution | blocked | Exact structure snapshot and per-protein pLDDT |
| Figure 4.3 | 41 | Sequence cluster sizes | blocked | data/all sequence clustering tables |
| Figure 4.4 | 41 | Filtered pLDDT and representative structure clusters | blocked | Representative structure IDs, confidence values and clustering tables |
| Figure 4.5 | 42 | Merged sequence/structure cluster sizes | partial | Expanded membership available; pre-merge sequence/structure assignments cloud-only |
| Figure 4.6 | 43 | Mapped universe cluster sizes | recomputed_intermediate | Mem_all.txt; Clu_all.txt |
| Figure 4.7 | 43 | EC consistency by cluster size | recomputed_intermediate | Fun_fold.h5; split100.csv |
| Figure 4.8 | 45 | GO term counts | recomputed_raw_annotations | Dated UniProt TSV; Fun_fold.h5 |
| Figure 4.9 | 45 | GO term counts by EC consistency | recomputed_raw_annotations | go_cluster_recomputed.csv |
| Figure 4.10 | 46 | Significant GO fraction | recomputed_raw_annotations | One-sided hypergeometric; per-cluster BH; stored RDS verification |
| Figure 4.11 | 46 | Significant GO fraction by EC consistency | recomputed_raw_annotations | go_cluster_recomputed.csv |
| Figure 4.12 | 47 | Q7N2V3 BP enrichment | recomputed_raw_annotations | go_enrichment_recomputed.csv |
| Figure 4.13 | 48 | Q7N2V3 BP annotation heatmap | recomputed_raw_annotations | Raw GO annotations; source membership |
| Figure 4.14 | 48 | P20921 BP enrichment | recomputed_raw_annotations | go_enrichment_recomputed.csv |
| Figure 4.15 | 48 | P20921 BP annotation heatmap | recomputed_raw_annotations | Raw GO annotations; source membership |
| Figure 4.16 | 49 | Q7N2V3 ProteinVec similarity | partial | Mixed case recomputed and plotted; EC/MFO embeddings cloud-only |
| Figure 4.17 | 50 | P20921 ProteinVec similarity | partial | Mixed case recomputed and plotted; EC/MFO embeddings cloud-only |
| Figure 4.18 | 50 | ProteinVec similarity mean and variance | blocked | Complete aspect embedding snapshots cloud-only |
| Figure 4.19 | 51 | Universe sizes by inherited EC consistency | partial | Counts available; reverse mapping overwrites multi-local groups; unknown proteins lack verified EC |
| Figure 4.20 | 51 | Universe EC-consistency proportions | partial | Legacy assigned category is not an observed universe EC label |
| Figure 4.21 | 52 | 1000-2000 universe cluster subset | recomputed_intermediate | Mem_all.txt; Clu_all.txt; legacy reverse-map explicitly audited |
| Figure 4.22 | 53 | Universe case ProteinVec similarity | blocked | Universe aspect embeddings cloud-only |
| Figure 4.23 | 54 | Universe vs local embedding distribution | blocked | Universe aspect embeddings cloud-only |
| Figure 4.24 | 59 | Four trained encoder case comparisons | blocked | Exact final encoder/input embedding and checkpoint mapping |
| Figure 4.25 | 60 | Trained encoder similarity distributions | blocked | Final model embeddings and training configs |
| Figure 4.26 | 62 | SepFun six-encoder heatmap | blocked | Six checkpoint identities, embeddings, exact loss/configuration |
| Figure 4.27 | 63 | SepFun prediction correctness | blocked | Per-protein six-model predictions and held-out manifest |
| Table 4.1 | 40 | Clustering flow counts | partial | Final 3291/194521 verified; upstream stages cloud-only |
| Table 4.2 | 44 | Sequence vs structure EC consistency | partial | 2283/1008 and singleton679 verified; 2x2 table needs upstream assignments |
| Table 4.3 | 44 | EC hierarchy consistency | recomputed_discrepancy | Both first-label and full-label-set interpretations computed |
| Table 4.4 | 44 | GO annotation counts | recomputed_raw_annotations | Dated raw UniProt annotations |
| Table 4.5 | 47 | Q7N2V3 GO terms | recomputed_raw_annotations | Raw annotation hypergeometric/BH and stored result comparison |
| Table 4.6 | 52 | Selected universe subset counts | recomputed_intermediate | Legacy reverse-map counts plus collision-aware mapping |
| Table 4.7 | 53 | Two universe case sizes | recomputed_intermediate | Mem_all.txt and complete local/global map |
| Table 4.8 | 56 | Foldseek test assignment counts | blocked | Exact search hits, membership and test ID assignment |
| Table 4.9 | 56 | Foldseek EC prediction metrics | blocked | Per-protein predictions, evaluation denominator |
| Table 4.10 | 56 | Augmentation training counts | partial | CSV assets available but exact sequence split/augmentation lineage unresolved |
| Table 4.11 | 57 | CLEAN final benchmark | reported_only | Values visually transcribed; arithmetic audited; final models NOT rerun |
| Table 4.12 | 62 | SepFun ablations | reported_only | Values transcribed; no six-model rerun |
