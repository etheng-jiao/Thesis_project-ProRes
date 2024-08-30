file = '/Users/eth-may/Desktop/dtu/semester7/Thesis/tttianhao-CLEAN-0cf2cac/data/new.csv'
data_file = open(file,'r')
output = open('/Users/eth-may/Desktop/dtu/semester7/Thesis/data/new.txt','w')
data = {}
head = data_file.readline()
for line in data_file:
    data['ID'].append(line.split(' ')[0])
    data['EC'].append(line.split(' ')[1])
    data['Seq'].append(line.split(' ')[2])
    output.write(line.split(' ')[0])

