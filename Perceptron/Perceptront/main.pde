PrintWriter dadostplano1, dadostplano2, trainning_accuracy1, trainning_accuracy2, trainning_error1, trainning_error2;
dadostplano1 = createWriter("dados-plano-SL-SW-setvers10.txt");
dadostplano2 = createWriter("dados-plano-PL-PW-setvers10.txt");
trainning_accuracy1 = createWriter("trainning-accuracy-SL-SW-setvers10.txt");
trainning_accuracy2 = createWriter("trainning-accuracy-PL-PW-setvers10.txt");
trainning_error1 = createWriter("trainning-error-SL-SW-setvers10.txt");
trainning_error2 = createWriter("trainning-error-PL-PW-setvers10.txt");
String[] lines = loadStrings("setvers10.txt");
float[] linha, aux1, aux2, resultado;
float[][] entrada1 = new float[lines.length][];
float[][] entrada2 = new float[lines.length][];
//passando os valores do arquivo de treinamento para os arrays 'entrada' e 'resultado'
resultado = new float[lines.length];
for (int i = 0 ; i < lines.length; i++) {
  linha = float(split(lines[i], ","));
  aux1 = new float[linha.length-3];
  aux2 = new float[linha.length-3];
  for (int j = 0; j < linha.length-3; j++){
    aux1[j] = linha[j];
    aux2[j] = linha[j+2];
  }
  entrada1[i] = aux1;
  entrada2[i] = aux2;
  if(split(split(lines[i],",")[4], 't').length == 2) resultado[i] = 1;
  else resultado[i] = 0;
}
int epocas=500;
float[] peso_entrada;
float peso_bias = 0;
float taxa_aprendizado = 1;
perceptront a, b;
peso_entrada = new float[entrada1[0].length];
//definição aleatoria para o peso das entradas
for (int i = 0; i < peso_entrada.length; i++){
  peso_entrada[i] = 0;
}
a = new perceptront(entrada1, peso_entrada, resultado, peso_bias, taxa_aprendizado, epocas);
a = a.inicio();
dadostplano1.println("SL\t\tSW\t\tBias");
for (int i = 0; i<a.peso_entrada.length; i++){
  dadostplano1.print(a.peso_entrada[i]+"\t");
}
dadostplano1.println(a.peso_bias);
dadostplano1.println("validation accuracy: "+ a.validation_accuracy);
dadostplano1.println("trainning accuracy: "+ a.trainning_accuracy);
dadostplano1.println("fold accuracy: ");
for(int i = 0; i<5; i++){
  dadostplano1.print(a.fold_accuracy[i]+ "\t");
}
dadostplano1.println("\nvalidation error: ");
for(int i = 0; i<5; i++){
  dadostplano1.print(a.validation_error[i]+ "\t");
}
for(int i = 0; i<5; i++){
  for(int j = 0; j<epocas; j++){
    trainning_accuracy1.println(j+","+a.trainning_accuracy_ep[i][j]);
    trainning_error1.println(j+","+a.trainning_error[i][j]);
  }
}
b = new perceptront(entrada2, peso_entrada, resultado, peso_bias, taxa_aprendizado, epocas);
b = b.inicio();
dadostplano2.println("PL\t\tPW\t\tPesoBias");
for (int i = 0; i<b.peso_entrada.length; i++){
  dadostplano2.print(b.peso_entrada[i]+"\t");
}
dadostplano2.println(b.peso_bias);
dadostplano2.println("validation accuracy: "+ b.validation_accuracy);
dadostplano2.println("trainning accuracy: "+ b.trainning_accuracy);
dadostplano2.println("fold accuracy: ");
for(int i = 0; i<5; i++){
  dadostplano2.print(b.fold_accuracy[i]+ "\t");
}
dadostplano2.println("\nvalidation error: ");
for(int i = 0; i<5; i++){
  dadostplano2.print(b.validation_error[i]+ "\t");
}
for(int i = 0; i<5; i++){
  for(int j = 0; j<epocas; j++){
    trainning_accuracy2.println(j+","+b.trainning_accuracy_ep[i][j]);
    trainning_error2.println(j+","+b.trainning_error[i][j]);
  }
}
dadostplano1.flush();
dadostplano1.close();
dadostplano2.flush();
dadostplano2.close();
trainning_accuracy1.flush();
trainning_accuracy1.close();
trainning_error1.flush();
trainning_error1.close();
trainning_accuracy2.flush();
trainning_accuracy2.close();
trainning_error2.flush();
trainning_error2.close();
