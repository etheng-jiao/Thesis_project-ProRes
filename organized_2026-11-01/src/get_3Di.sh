
# download afpdb
for i in `cat ../local_snapshot/data/all100_entry.txt`;do wget -q -N -O ./${i}.pdb https://alphafold.ebi.ac.uk/files/AF-${i}-F1-model_v4.pdb;done
# delete sparse file
find . -name "*" -type f -size 0c | xargs -n 1 rm -f

for i in `cat ../local_snapshot/data/foldseek_Clu_key.txt`;do cp ../local_snapshot/data/afall/${i}.pdb . ;done


# convert to 3Di
echo 'I7FA35.pdb' | ../local_snapshot/foldseek-analysis/training/encode_pdbs.py ../local_snapshot/foldseek-analysis/training/data/foldseek_v1/encoder.pt ../local_snapshot/foldseek-analysis/training/data/foldseek_v1/states.txt --pdb_dir ../local_snapshot/data/afpdb --virt 270 0 2

for i in `cat ../local_snapshot/data/caseID.txt`; do echo ${i}.pdb | ../local_snapshot/foldseek-analysis/training/encode_pdbs.py ../local_snapshot/foldseek-analysis/training/data/foldseek_v1/encoder.pt ../local_snapshot/foldseek-analysis/training/data/foldseek_v1/states.txt --pdb_dir ../local_snapshot/data/afnew --virt 270 0 2 ;done

for i in `cat ../local_snapshot/data/alignment_db/rep.text`; do wget -o ”../local_snapshot/data/alignment_db/Rep_cluster/A0A0A1H8I4cluster“ “https://cluster.foldseek.com/api/cluster/A0A0A1H8I4/members?format=fasta&groupBy=&groupDesc=&itemsPerPage=10&multiSort=false&mustSort=false&page=1&sortBy=&sortDesc=false”

wget -O new_filename.extension http://example.com/file_to_download.extension


semester7/Thesis/data/afnew_foldseek_key



awk 'NR==FNR {arr[$1]; next} $2 in arr' ../local_snapshot/data/foldseek_Clu_key.txt ../local_snapshot/data/5-allmembers-repId-entryId-cluFlag-taxId.tsv

awk 'NR==FNR {arr[$1]; next} $1 in arr' ../local_snapshot/data/Clu_all.txt ../local_snapshot/data/5-allmembers-repId-entryId-cluFlag-taxId.tsv



awk 'NR==FNR {arr[$1]; next} $2 in arr' ../local_snapshot/data/clu_key_10.txt ../local_snapshot/data/5-allmembers-repId-entryId-cluFlag-taxId.tsv

awk 'NR==FNR {arr[$1]; next} $1 in arr' ../local_snapshot/data/univer_10.txt ../local_snapshot/data/5-allmembers-repId-entryId-cluFlag-taxId.tsv






find ../local_snapshot/data/Universe_fasta -type f -exec bash -c 'lines=$(wc -l < "{}"); if [ $lines -lt 100 ]; then echo "{}"; fi' \;

find  ../local_snapshot/data/Universe_fasta -type f -exec bash -c 'lines=$(wc -l < "{}"); if [ $lines -lt 2000 ]; then rm "{}"; fi' \;
