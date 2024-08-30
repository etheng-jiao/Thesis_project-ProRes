
# download afpdb
for i in `cat /Users/eth-may/Desktop/dtu/semester7/Thesis/data/Entry.txt`;do wget -q -N -O ./${i}.pdb https://alphafold.ebi.ac.uk/files/AF-${i}-F1-model_v4.pdb;done
# delete sparse file
find . -name "*" -type f -size 0c | xargs -n 1 rm -f

# convert to 3Di
echo 'I7FA35.pdb' | /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/encode_pdbs.py /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/data/foldseek_v1/encoder.pt /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/data/foldseek_v1/states.txt --pdb_dir /Users/eth-may/Desktop/dtu/semester7/Thesis/data/afpdb --virt 270 0 2

for i in `cat /Users/eth-may/Desktop/dtu/semester7/Thesis/data/Entry.txt`; do echo ${i}.pdb | /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/encode_pdbs.py /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/data/foldseek_v1/encoder.pt /Users/eth-may/Desktop/dtu/semester7/Thesis/foldseek-analysis/training/data/foldseek_v1/states.txt --pdb_dir /Users/eth-may/Desktop/dtu/semester7/Thesis/data/afpdb --virt 270 0 2 ;done