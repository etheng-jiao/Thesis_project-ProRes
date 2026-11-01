# Final thesis: executed analysis and revision audit

This update supersedes the earlier archive's reproduction-status notes. It audits the 77-page final thesis (June 2024), covering all 27 result figures and 12 tables. Original local files were preserved; revisions are new artifacts.

- [Single notebook](00_reproduce_thesis.ipynb): the local version has 15 successfully executed code cells. This public copy removes outputs and machine-specific paths; the recomputed summary tables are in `results/`.
- [Review and proposed English revisions](docs/REVIEW_AND_REVISIONS.md): verified findings, discrepancies, revised results/conclusion, and next experiments.
- [Experiment ledger](docs/experiment_ledger.md): coverage and missing inputs for every result figure/table.

Recomputed: cluster EC consistency, EC hierarchy sensitivity (does not match Table 4.3), universe membership statistics, all 41,501 GO enrichment records from raw annotations, two GO case heatmaps, Mixed embedding case statistics, and SepFun training-label counts. Table 4.11 numbers are transcribed report values used for arithmetic auditing, not rerun predictions.

Not completed: upstream Foldseek pipeline, final CLEAN benchmark inference/training, complete ProteinVec aspect analyses, and six SepFun models. Critical inputs remain cloud-only or lack exact configuration/checkpoint provenance. The early four-model experiment in the notebook is not the final thesis benchmark.

## Run with restored local data

Use Python 3.11 and the locked packages in `requirements.txt`; R 4.3.2 / `Rscript` is used to read historical RDS for comparison. Set `THESIS_ROOT` to the organized local Thesis directory and `THESIS_FINAL_PDF` to the final PDF, then run the notebook in order. The organized root must contain `01_code/Code`, `02_data/data`, and `03_models_and_tools/tttianhao-CLEAN-0cf2cac`. Data, weights, third-party projects and the source PDF are not bundled here. New outputs go to a fresh timestamped `04_results` directory.

The notebook is not a data-free demo: absent files are genuine reproduction blockers. An executed availability check is not a successful model experiment. No model confidence intervals or new training outcomes are fabricated.
