import matplotlib.pyplot as plt

arquivo = open('csetvirg15.txt', 'r')
reta = open('dados-plano-PL-PW-setvirg15.txt', 'r')
a = arquivo.readlines();
c = reta.readlines();
aux = (len(a)-1)/2

xret = []
yret = []
x=[]
y=[]
x2 = []
y2 = []
vy = 4.5
vx = 1
xret.append(((-vy*float(c[1].split('\t')[1])-float(c[1].split('\t')[2]))/float(c[1].split('\t')[0])))
xret.append(vx)
yret.append(vy)
yret.append((-vx*float(c[1].split('\t')[0])-float(c[1].split('\t')[2]))/float(c[1].split('\t')[1]))

for i in range(int(aux)+1):
    spl = a[i].split(',')
    x.append(float(spl[2]))
    y.append(float(spl[3]))
for i in range(int(aux)+1, len(a)):
    spl = a[i].split(',')
    x2.append(float(spl[2]))
    y2.append(float(spl[3]))

plt.plot(xret, yret, color = 'green')
for i in range(len(x)):
    s = plt.scatter(x[i],y[i], color = 'red')
for i in range(len(x2)):
    v = plt.scatter(x2[i], y2[i], color = 'blue')
plt.xlabel('comprimento da pétala')
plt.ylabel('largura da pétala')
plt.legend((s, v),('setosa', 'virginica'), scatterpoints= 1, loc = 'best')
plt.show()
