from pymol import cmd

# 获取所有加载的对象名称
object_names = cmd.get_names('all')

# 选择第一个对象作为参考结构
if object_names:
    reference = object_names[14]
else:
    raise ValueError("No PDB files loaded in PyMOL")

# 对齐其他结构到参考结构
for obj in object_names[:14]:
    print(obj)
    cmd.super(obj, reference)

for obj in object_names[15:]:
    print(obj)
    cmd.super(obj, reference)

# 显示所有蛋白质并设置显示模式
cmd.show('cartoon', 'all')
cmd.color('cyan', 'all')

# 调整视角
cmd.zoom('all')

# 可选：保存对齐后的图像
#cmd.png('aligned_proteins.png', width=1920, height=1080, dpi=300)
