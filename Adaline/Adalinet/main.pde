PrintWriter dadostplano1, dadostplano2, trainning_accuracy1, trainning_accuracy2, trainning_error1, trainning_error2;
dadostplano1 = createWriter("dados-plano-SL-SW-setvirg40.txt");
dadostplano2 = createWriter("dados-plano-PL-PW-setvirg40.txt");
trainning_accuracy1 = createWriter("trainning-accuracy-SL-SW-setvirg40.txt");
trainning_accuracy2 = createWriter("trainning-accuracy-PL-PW-setvirg40.txt");
trainning_error1 = createWriter("trainning-error-SL-SW-setvirg40.txt");
trainning_error2 = createWriter("trainning-error-PL-PW-setvirg40.txt");
String[] lines = loadStrings("setvirg40.txt");
float[] linha;
float[] aux1, aux2, resultado;
float[][] entrada1 = new float[lines.length][];
float[][] entrada2 = new float[lines.length][];
//passando os valores do arquivo de treinamento para os arrays 'entrada' e 'resultado'
resultado = new float[lines.length];
for (int i = 0 ; i < lines.length; i++) {
  linha = float(split(lines[i], ","));
  aux1 = new float[linha.length-3];
  aux2 = new float[linha.length-3];
  for (int j = 0; j < (linha.length)-3; j++){
    aux1[j] = linha[j];
    aux1[j] = aux1[j]*0.1;
    
    aux2[j] = linha[j+2];
    aux2[j] = aux2[j]*0.1;
  }
  entrada1[i] = aux1;
  entrada2[i] = aux2;
  if(split(split(lines[i],",")[4], 't').length == 2) resultado[i] = 1;
  else resultado[i] = -1;
}

float[] peso_entrada;
float e = 0.001;
float bias = 0;
float taxa_aprendizado = 0.5;
adalinet a, b;
peso_entrada = new float[entrada1[0].length];
//definiÃ§Ã£o aleatoria para o peso das entradas
for (int i = 0; i < peso_entrada.length; i++){
  peso_entrada[i] = random(0.0,0.99);
}
a = new adalinet(entrada1, peso_entrada, resultado, bias, e, taxa_aprendizado);
//treinamento
a = a.inicio();
dadostplano1.println("SL\t\tSW\t\tBias");
for (int i = 0; i<a.peso_entrada.length; i++){
  dadostplano1.print(a.peso_entrada[i]*0.1+"\t");
}
dadostplano1.println(a.bias);
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
int k = 0;
for(int i = 0; i<a.trainning_accuracy_ep.size(); i++){ 
  if(a.trainning_accuracy_ep.get(i) == 0.0){
    i++;
    k = 0;
    trainning_accuracy1.println("Novo Treinamento");
    trainning_error1.println("Novo Treinamento");
  }
  trainning_accuracy1.println(k+","+str(a.trainning_accuracy_ep.get(i)));
  trainning_error1.println(k+","+str(a.trainning_error.get(i)));
  k++;
}

b = new adalinet(entrada2, peso_entrada, resultado, bias, e, taxa_aprendizado);
//treinamento
b = b.inicio();
dadostplano2.println("PL\t\tPW\t\tBias");
for (int i = 0; i<b.peso_entrada.length; i++){
  dadostplano2.print(b.peso_entrada[i]*0.1+"\t");
}
dadostplano2.println(b.bias);
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
k = 0;
for(int i = 0; i<b.trainning_accuracy_ep.size(); i++){ 
  if(b.trainning_accuracy_ep.get(i) == 0.0){
    i++;
    k = 0;
    trainning_accuracy2.println("Novo Treinamento");
    trainning_error2.println("Novo Treinamento");
  }
  trainning_accuracy2.println(k+","+str(b.trainning_accuracy_ep.get(i)));
  trainning_error2.println(k+","+str(b.trainning_error.get(i)));
  k++;
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
