"""Validate archived evidence only; never execute historical notebooks."""
import csv,hashlib,json
from pathlib import Path
root=Path(__file__).resolve().parent.parent
provenance=json.loads((root/'metadata/notebook_provenance.json').read_text())
for r in provenance:
 p=root/r['export'];assert hashlib.sha256(p.read_bytes()).hexdigest()==r['export_sha256'],p
 d=json.loads(p.read_text());assert all(not c.get('outputs') for c in d['cells'])
evidence=json.loads((root/'results/historical_metrics_evidence.json').read_text())
rows=list(csv.DictReader((root/'results/historical_metrics.csv').open()))
assert len(rows)==len(evidence)==8
for r,e in zip(rows,evidence):
 assert r['notebook']==e['notebook'] and int(r['cell_index_0based'])==e['cell_index_0based']
 assert float(r['f1'])>=0 and float(r['f1'])<=1
print(f'PASS: {len(provenance)} notebook hashes and {len(rows)} historical metric records. No model experiments rerun.')
