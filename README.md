# Comparação entre Adaline e Perceptron utilizando conjunto de dados IRIS
Este repositório contém os códigos implementados a partir de pseudocódigos encontrados no livro de Danilo G. Spatti, Ivan N. da Silva e Rogério A. Flauzino, “Redes Neurais Artificiais Para Engenharias e Ciências Aplicadas”, tais códigos foram implementados com intuito didático para introdução as redes neurais, onde foi feito uma comparação entre as redes neurais Adaline e Perceptron utilizando o conjunto de dados IRIS. As redes neurais foram implementadas com o treinamento e classificação separadamente. Os códigos encontram-se nas pastas com os nomes das redes neurais.
#Dados
Os dados utilizados para treinamento e classificação foram gerados a partir do conjunto de dados IRIS e utilizando o programa ```geradados.pde``` encontrado na pasta ``` Gera-dados```. Como entrada do programa foram utilizados os arquivos ```setvers.txt```, ```setvirg.txt``` e ```virgvers.txt``` que contém 100 linhas cada e se encontram na mesma pasta. Para geração dos arquivos de treinamento e de classificação encontrados nas pastas ```Dados-treinamento``` e ``` Dados-classificação ``` é preciso alterar a linha a seguir, além do nome do arquivo de entrada que se deseja obter os dados.
```
for (int i = 1; i<30; i++){
```
Onde o valor ```30``` deve ser alterado para a quantidade de amostras desejadas em cada arquivo de treinamento, por exemplo para a geração dos arquivos ```virgvers30.txt``` e ```cvirgvers30.txt``` utilizou-se o valor ```60``` pois era desejado 30 amostras de Iris-versicolor e 30 de Iris-virgínica.
# Treinamento
Para o treinamento das redes neurais, foram utilizados os arquivos na pasta ``` Dados-treinamento ```, cada treinamento utiliza apenas um arquivo de entrada e apresenta 6 arquivos de saída. Para que não haja erros no treinamento deve-se alterar o seguinte trecho de código de acordo com o arquivo de entrada:
```
if(split(split(lines[i],",")[4], 't').length == 2) resultado[i] = 1;
  else resultado[i] = -1;
```
Para arquivos de entrada que possuam ```setvers``` ou ```setvirg``` nos nomes deve-se utilizar o código anterior e para arquivos de entrada que possuam ```virgvers``` em seu nome deve-se utilziar o código a seguir, que altera a letra ```t``` pela letra ```g```. 
```
if(split(split(lines[i],",")[4], 'g').length == 2) resultado[i] = 1;
  else resultado[i] = -1;
```
O arquivo de entrada para o treinamento foi separado em 5 folds, e durante o treinamento a rede neural treina com um fold e faz uma classificação com o restante.
Os resultados dos treinamentos encontram-se nas pastas ```Redes-Neurais/Adaline/Adalinet/Resultados``` e ```Redes-Neurais/Perceptron/Perceptront/Resultados``` os arquivos em tais pastas apresentam o peso das entradas das redes neurais, assim como o valor do bias, a seguir apresentam os valores para validation accuracy que representa a média do fold accuracy, trainning accuracy, fold accuracy e validation error; além de tais informações apresentadas, em resultados apresentam ainda duas pastas ```trainning accuracy``` e ```trainning error```, que apresentam os valores correspondentes do trainning accuracy e trainning error para cada época do treinamento de cada fold.
# Classificação
Para a classificação das redes neurais foram utilizados os arquivos resultantes do treinamento e os arquivos da pasta ```Dados-classificação```. Para cada classificação foram utilizados 3 arquivos de entrada, dois dos arquivos encontrados no resultado do treinamento e um dos arquivos na pasta dos dados de classificação. Os arquivos devem representar o mesmo conjunto de dados, por exemplo para a classificação utilizando o arquivo ```cvirgvers15.txt``` deve-se utilizar os arquivos ```dados-plano-SL-SW-virgvers15.txt``` e ```dados-plano-PL-PW-virgvers15.txt```. Como saída são apresentados 4 arquivos que possuem os valores que foram determinados para cada classe, no caso são dois arquivos para as características e comprimento e largura da sépala e outros dois para as características de comprimento e largura da pétala. Os dois arquivos para cada característica indicam os valores do arquivo de treinamento que foram designados para cada classe, por exemplo utilizando para os dados da classificação ```cvirgvers15.txt``` dois arquivos representam os valores que pertencem a classe ```Iris-virginica```e dois representam os valores que pertencem a classe ```Iris-versicolor```.
Os resultados da classificação encontram-se nas pastas ```Redes-Neurais/Adaline/Adalinec/Resultados``` e ```Redes-Neurais/Perceptron/Perceptronc/Resultados```.
# Gráficos
Os gráficos na pasta ```Gráficos/Planos``` apresentam os resultados da classificação das redes neurais em um plano, considerando os valores de cada linha dos arquivos como um ponto no plano (x,y). Para a criação da reta no gráfico deve-se utilizar os resultados do treinamento das redes neurais, onde se consideram os pesos das redes e o valor do bias de forma que a reta fique igual a:
```
P1*x+P2*y+BIAS=0
```
Onde ```P1``` e ```P2``` são os pesos obtidos no resultado do treinamento.
Para a geração do gráfico deve-se colocar em ```arquivo = open('csetvirg30.txt', 'r')``` o nome do arquivo da pasta ```Dados-classificação``` que corresponde ao mesmo conjunto de dados indicado em ```reta = open('dados-plano-PL-PW-setvirg30.txt', 'r')```; por exemplo para os arquivos ```dados-plano-SL-SW-setvirg30.txt``` e ```dados-plano-PL-PW-setvirg30.txt``` utiliza-se ```csetvirg30.txt```.
No seguinte trecho de código os valores ```vy``` e ``` vx```, que representam a posição de um ponto (x,y) e auxiliam no calculo do segundo ponto (x2,y2) da reta, devem ser alterados para cada gráfico para que a reta não fique muito grande, de modo que os pontos não sejam bem vizualizados nem fique muito curta de modo que não corte o plano que apresenta os pontos.
```
vy = 4.5
vx = 1
xret.append(((-vy*float(c[1].split('\t')[1])-float(c[1].split('\t')[2]))/float(c[1].split('\t')[0])))
xret.append(vx)
yret.append(vy)
yret.append((-vx*float(c[1].split('\t')[0])-float(c[1].split('\t')[2]))/float(c[1].split('\t')[1]))
```

O gráfico na pasta ```Gráficos/Gráfico4X4``` apresenta os valores das amostras utilizadas para treinamento e classificação no plano, onde cada característica é combinada com as outras em cada linha para uma visualização no plano dos dados.
