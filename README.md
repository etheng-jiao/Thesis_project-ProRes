# Thesis_project-ProRes

project/
├── data/
│   ├── train_ec_labels.csv        # 训练集EC注释
│   ├── test_ec_labels.csv         # 测试集EC注释
│   ├── foldseek_clusters.csv      # 3,291个簇的成员列表
│   └── protein_embeddings/        # 预计算的ProstT5/ProtT5嵌入
├── src/
│   ├── 01_compute_dependency.py   # 计算每个簇的I(S;Y)
│   ├── 02_split_test_by_isd.py    # 按I(S;Y)分组测试数据
│   ├── 03_predict_and_evaluate.py # 运行CLEAN预测+计算性能
│   ├── 04_analyze_representation.py # 表征几何分析
│   └── utils.py                   # 公用函数
├── results/
│   ├── dependency_scores.csv      # 每个簇的I(S;Y)
│   ├── prediction_performance.csv # 每组的F1/ACC
│   ├── figures/
│   │   ├── fig1_isd_distribution.png
│   │   ├── fig2_performance_vs_isd.png
│   │   └── fig3_tsne_representations.png
│   └── report.md                  # 2-3页实验报告
└── README.md
