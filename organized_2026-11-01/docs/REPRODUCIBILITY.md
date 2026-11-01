# 复现状态与缺口

## 已完成

本地可访问的 75,223 个文件（逻辑大小 52,589,077,555 bytes）通过 APFS clonefile 形成独立副本，不是硬链接。修改副本不会修改原文件。缓存、.git 和 41 个仅云端条目未递归复制。云端目录的内部规模未知。

建立文件清单、复制映射、23 个 notebook 来源哈希、288 条文本路径引用记录；提取历史文本/图形和 8 条明确 EC 评估指标。公开副本剥离全部 notebook 输出及机器路径。原始副本保留输出。

## 阻止完整复现的缺口

1. `Code/src`、`sep_clr-master`、`data/Embedding`、`data/all`、`data/alignment_db`、CLEAN 的 `results` / `data/prost5` / `data/pretrained` 等是云端占位；没有把这些目录当作空目录或完整归档。
2. 原代码使用旧机器绝对路径、交互式变量和混合运行顺序。替换路径仅改善阅读和迁移，不足以保证 Run All。
3. 公开副本中的 `../local_snapshot` 假定工作目录为本地 `github_export`。其他机器需要先恢复数据并重新配置；`<LOCAL_USER_HOME>` 是未解决的外部路径占位符。
4. 未安装和锁定整个研究环境；`imports_observed.txt` 是静态导入名称清单，不是 pip requirements，不能直接安装。外部工具要求也可能互相冲突。
5. 没有执行原 notebook，以免触发下载、长训练或写入错误路径；也没有把抽取指标说成本次复现实测。

## 具体代码疑点（未改动原稿）

- `1 Function Enrichment Analysis.ipynb` cell 42：循环解包 `key, inner_dict`，写入使用 `value`；需确认是否错误引用旧变量。
- `0 Data Exploration.ipynb` 开头读取 `id_ec`、`rec_dic` 等尚未在此前单元格定义的变量，说明需要整理初始化依赖。
- `3 CLEAN & SepFun.ipynb` cell 101：不同指标的标签变量不一致，见结果说明。

## 推荐首先复现的实验

以 `evaluate_models.ipynb` 的 237 样本对比为候选：恢复 split10_re2 / new2 数据、四组 checkpoint 与 embedding；建立固定样本 ID 清单；统一评估函数、阈值和随机种子；先只运行基线，再逐个加入变体。当前这些条件不齐备，未创建声称可运行的伪流水线。

## 云端恢复后

先将缺失内容下载到本地，再重新运行只读盘点，复制新增内容到本整理目录；核对已有哈希，补全实验输入—模型—结果关系。`metadata/cloud_missing.json` 列出目前已知的缺口。原文件不应被自动“清理”或覆盖。

## GitHub 范围

只上传本次整理的代码阅读副本、文档、指标证据和精简清单。大数据、权重、第三方项目完整副本、未经解析的 RDS、全部历史 notebook 输出和图片留在本地。模式匹配扫描未发现所检查格式的凭据；该检查不是对所有隐私和授权问题的保证。
