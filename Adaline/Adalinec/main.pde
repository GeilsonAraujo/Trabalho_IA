PrintWriter SL_SW_dadoscpos, PL_PW_dadoscneg, SL_SW_dadoscneg, PL_PW_dadoscpos;
SL_SW_dadoscpos = createWriter("SL-SW-virgvers-virginica15.txt");
SL_SW_dadoscneg = createWriter("SL-SW-virgvers-versicolor15.txt");
PL_PW_dadoscpos = createWriter("PL-PW-virgvers-virginica15.txt");
PL_PW_dadoscneg = createWriter("PL-PW-virgvers-versicolor15.txt");
String[] dadosc = loadStrings("cvirgvers15.txt");
String[] SL_SW_dadost = loadStrings("dados-plano-SL-SW-virgvers15.txt");
String[] PL_PW_dadost = loadStrings("dados-plano-PL-PW-virgvers15.txt");
float[] linha, linha2;
float[] dados;
float[][] SL_SW_entrada = new float[dadosc.length][2];
float[][] PL_PW_entrada = new float[dadosc.length][2];
//passando os valores da avaliacao para o array 'arq'
for (int i = 0; i < dadosc.length; i++){
  dados = float(split(dadosc[i], ","));
  for (int j = 0; j< dados.length-1; j++){
    if(j<2){
      SL_SW_entrada[i][j] = dados[j];
    }
    else{
      PL_PW_entrada[i][j%2] = dados[j];
    }
  }
}

//definindo o bias e os pesos
linha =  float(split(SL_SW_dadost[1],"\t"));
linha2 = float(split(PL_PW_dadost[1],"\t"));
float[] SL_SW_peso_entrada, PL_PW_peso_entrada;
float SL_SW_bias = linha[linha.length -1], PL_PW_bias=linha2[linha2.length -1];
adalinec a,b;
SL_SW_peso_entrada = new float[linha.length-1];
PL_PW_peso_entrada = new float[linha2.length-1];
//definição aleatoria para o peso das entradas
for (int i = 0; i < SL_SW_peso_entrada.length; i++){
  SL_SW_peso_entrada[i] = linha[i];
  PL_PW_peso_entrada[i] = linha2[i];
}
a = new adalinec(SL_SW_entrada, SL_SW_peso_entrada, SL_SW_bias, SL_SW_dadoscpos, SL_SW_dadoscneg);
SL_SW_dadoscpos.println("SL\tSW");
SL_SW_dadoscneg.println("SL\tSW");
//faz o teste depois do treinamento, se o resultado for 1 a classe definida sera 'A' se o resultado for -1 a classe definida sera 'B'
a.teste();
for (int i = 0; i < SL_SW_peso_entrada.length; i++){
  SL_SW_peso_entrada[i] = linha[i];
  PL_PW_peso_entrada[i] = linha2[i];
}
b = new adalinec(PL_PW_entrada, PL_PW_peso_entrada, PL_PW_bias, PL_PW_dadoscpos, PL_PW_dadoscneg);
PL_PW_dadoscpos.println("PL\tPW");
PL_PW_dadoscneg.println("PL\tPW");
//faz o teste depois do treinamento, se o resultado for 1 a classe definida sera 'A' se o resultado for -1 a classe definida sera 'B'
b.teste();
SL_SW_dadoscpos.flush();
SL_SW_dadoscneg.flush();
SL_SW_dadoscpos.close();
SL_SW_dadoscneg.close();
PL_PW_dadoscpos.flush();
PL_PW_dadoscneg.flush();
PL_PW_dadoscpos.close();
PL_PW_dadoscneg.close();
