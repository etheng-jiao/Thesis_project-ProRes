# Thesis_project-ProRes
# Structure-Function Prior Validity Boundary

A systematic investigation of when structural information is useful (or not) for protein functional inference.

## Research Question

**What is the validity boundary of structural priors for protein functional inference?**

We hypothesize that the predictive utility of structural representations is determined by the strength of structure-function dependency I(S;Y). This work quantifies this dependency and examines its impact on representation learning and prediction performance.

## Project Structure
project/
├── data/
│ ├── train_ec_labels.csv # Training set EC annotations (CLEAN dataset)
│ ├── test_ec_labels.csv # Test set EC annotations (392 new enzymes)
│ ├── foldseek_clusters.csv # 3,291 Foldseek clusters with member lists
│ └── protein_embeddings/ # Pre-computed ProstT5/ProtT5 embeddings
│ ├── prostt5_train.pt
│ ├── prostt5_test.pt
│ ├── protT5_train.pt
│ └── protT5_test.pt
├── src/
│ ├── 01_compute_dependency.py # Compute I(S;Y) for each Foldseek cluster
│ ├── 02_split_test_by_isd.py # Stratify test samples by I(S;Y) bins
│ ├── 03_predict_and_evaluate.py # Run CLEAN prediction + compute F1/ACC
│ ├── 04_analyze_representation.py # Representation geometry analysis (t-SNE, cosine similarity)
│ └── utils.py # Shared utility functions
├── results/
│ ├── dependency_scores.csv # I(S;Y) scores per cluster
│ ├── prediction_performance.csv # F1/ACC per I(S;Y) bin
│ ├── figures/
│ │ ├── fig1_isd_distribution.png
│ │ ├── fig2_performance_vs_isd.png
│ │ └── fig3_tsne_representations.png
│ └── report.md # 2-3 page experimental summary
└── README.md

text

## Experimental Pipeline

### Phase 0: Data Preparation (Complete)
- CLEAN training set: 227,362 enzyme sequences with EC annotations
- CLEAN test set: 392 newly acquired enzymes
- Foldseek structural clusters: 3,291 clusters, 194,521 members
- Pre-computed embeddings: ProstT5 (structure-aware) and ProtT5 (sequence-only)

### Phase 1: Quantify Structure-Function Dependency
```bash
python src/01_compute_dependency.py
For each Foldseek cluster, compute EC distribution entropy and normalized mutual information NMI(S;Y)

Output: results/dependency_scores.csv

Phase 2: Stratify Test Data by Dependency Strength
bash
python src/02_split_test_by_isd.py
Assign each test protein to its corresponding Foldseek cluster

Bin by I(S;Y): High (>0.8), Medium (0.4-0.8), Low (<0.4)

Output: Grouped test indices for evaluation

Phase 3: Prediction Performance Evaluation
bash
python src/03_predict_and_evaluate.py
Run CLEAN framework with ProstT5 (structural model) and ProtT5 (sequence baseline)

Compute F1 and Accuracy for each I(S;Y) bin

Output: results/prediction_performance.csv

Phase 4: Representation Analysis
bash
python src/04_analyze_representation.py
Extract learned embeddings Z for test proteins

Compute intra-class / inter-class cosine similarity

Generate t-SNE/UMAP visualizations

Output: results/figures/fig3_tsne_representations.png

Expected Results
I(S;Y) Bin	Structural Model (ProstT5)	Sequence Baseline (ProtT5)	Δ
High (>0.8)	~0.90	~0.70	+0.20
Medium (0.4-0.8)	~0.50	~0.45	+0.05
Low (<0.4)	~0.25	~0.28	-0.03
Key Insight: Structural information is beneficial only when structure-function dependency is high. In low-dependency regions, structure-based models can perform worse than sequence-only baselines.

Dependencies
Python 3.9+

PyTorch 1.12+

scikit-learn

numpy, pandas

matplotlib, seaborn

umap-learn (for visualization)

Quick Start
bash
# Clone repository
git clone https://github.com/yourusername/structure-function-boundary.git
cd structure-function-boundary

# Install dependencies
pip install -r requirements.txt

# Place data files in ./data/
# Run full pipeline
python src/run_all.py
Citation
If you find this work useful, please cite:

text
@mastersthesis{yang2024exploration,
  title={Exploration of protein representations for enzyme function prediction},
  author={Yang, Huijiao},
  year={2024},
  school={Technical University of Denmark}
}
Contact
Huijiao Yang - s202360@student.dtu.dk

