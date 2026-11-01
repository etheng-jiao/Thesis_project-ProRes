# Thesis / ProRes：实验归档与可复现性盘点

本目录是 2026-11-01 对本地 Thesis 项目的整理成果。**历史 notebook 输出已归档，但完整模型实验尚未重新运行。** 原论文资料、数据、外部工具与探索代码混杂，因此本次优先恢复来源关系，而不重写或伪造完整训练流水线。

## 从这里开始

1. [实验逻辑](docs/EXPERIMENT_LOGIC.md)：每阶段的问题、输入、代码、输出与缺口。
2. [结果及解释边界](docs/RESULTS.md)：8 条历史指标与来源；不可混用不同测试集。
3. [复现状态](docs/REPRODUCIBILITY.md)：云端缺失、路径、环境和代码问题。
4. [数据清单](metadata/data_catalog.csv)、[路径依赖](metadata/path_dependencies.json)、[notebook 清单](metadata/notebook_catalog.json)。

## 目录

- `notebooks/`：23 个 notebook 的阅读副本；移除历史输出、执行编号和单元格元数据，替换本机绝对路径。没有执行这些 notebook。
- `src/`：原 Code 目录中的 Python / shell 脚本阅读副本；路径做同样替换。
- `results/`：带来源的历史指标 CSV 与原始文本证据。
- `metadata/`：数据分组、依赖、来源哈希、缺失目录和模式匹配扫描报告。
- `scripts/verify_archive.py`：无需训练依赖的归档一致性检查。

完整本地整理目录还包括 `local_snapshot/`（75,223 个独立文件副本）、`results/figures/`（从 notebook 提取的历史图片）、完整盘点与复制日志。约 52.6 GB 的本地数据和权重未上传 GitHub。41 个仅云端条目中包含整个目录，因此其内部文件数和大小未知，不能称为完整备份。

## 验证

```sh
python3 scripts/verify_archive.py
```

这个命令验证归档文件、指标证据和 notebook 格式，不会重跑模型，也不会写入原 Thesis 目录。完整模型复现请先阅读复现状态文档。

本分支新增 `organized_2026-11-01/`，保留仓库原有文件和主分支内容。根 README 中的假设、计划和 Expected Results 不应视为本次整理确认的实测结论。

外部工具（CLEAN、ESM、ProstT5、DeepFRI、Foldseek 等）保留在本地快照，未作为本项目原创代码重新发布。本次未授予任何新的软件或数据许可证；原作者权利与已有许可继续适用。
