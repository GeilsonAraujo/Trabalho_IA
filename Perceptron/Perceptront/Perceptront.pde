class perceptront{
  float[][] entrada, trainning_accuracy_ep, trainning_error;
  float[] peso_entrada;
  float[] resultado;
  float bias;
  float peso_bias;
  float taxa_aprendizado;
  float validation_accuracy, trainning_accuracy;
  float[] fold_accuracy = new float[5];
  float[] validation_error;
  int epocas;
  perceptront(float[][] ent, float[] peso_ent, float[] result, float peso_b, float taxa_ap, int ep){
    entrada = ent;
    peso_entrada = peso_ent;
    resultado = result;
    bias = 1;
    peso_bias = peso_b;
    taxa_aprendizado=taxa_ap;
    epocas = ep;
    validation_accuracy=0;
    trainning_accuracy=0;
    fold_accuracy = new float[5];
    trainning_accuracy_ep = new float[5][epocas];
    trainning_error = new float[5][epocas];
    for(int i = 0; i<5; i++){
      for(int j = 0; j< epocas; j++){
        trainning_error[i][j] = 0;
      }
    }
    validation_error = new float[5];
  }
  
  perceptront inicio(){
    perceptront a;
    a = new perceptront(entrada, peso_entrada, resultado, peso_bias, taxa_aprendizado, epocas);
    float z = 0, w = 0;
    int aux = entrada.length/5;
    float[][] aux3 = a.trainning_error, aux4 = trainning_accuracy_ep;
    float[][] intest = new float[aux][];
    float[][] in = new float[entrada.length-aux][];
    float[] outtest = new float[aux];
    float[] out = new float[resultado.length-aux];
    float[] aux1 = new float[5], aux2 = new float[5];
    for(int i = 0; i<5; i++){
      int k = 0;
      for(int j = i*aux; j<i*aux+aux; j++){
        intest[k] = entrada[j];
        outtest[k] = resultado[j];
        k++;
      }
      k = 0;
      for(int j = 0; j<entrada.length; j++){
        if(j==i*aux){
          j=j+aux;
        }
        if(j == entrada.length){
          break;
        }
        in[k] = entrada[j];
        out[k] = resultado[j];
        k++;
      }
      a = new perceptront(in, peso_entrada, out, peso_bias, taxa_aprendizado, epocas);
      w = w + a.treinar(aux3[i], aux4[i]);
      aux1[i] = a.teste(intest, outtest, a.peso_entrada, a.peso_bias);
      aux2[i] = outtest.length-(aux1[i]*outtest.length);
      z = z + aux1[i];
    }
    a.trainning_error = aux3;
    a.trainning_accuracy_ep = aux4;
    a.validation_error = aux2;
    a.fold_accuracy = aux1;
    a.validation_accuracy = z/5;
    a.trainning_accuracy = w/5;
    return a;
  }
  
  float treinar(float[] terror, float[] tacc_ep){
    float erro, res=0;
    float u, y;
    //repetição do calculo de acordo com a quantidade de epocas
    for (int k = 0; k < epocas; k++){
      res = 0;
      //calculo para cada conjunto de entrada
      for (int i = 0; i < entrada.length; i++){
        //definicao do erro inicial
        erro = 1;
        //repeticao ate que nao se encontre mais erro
        while(erro != 0.0){
          //definindo a saida
          u = 0;
          //println(entrada[i].length);
          for (int j = 0; j < entrada[i].length; j++){
            u = u + entrada[i][j] * peso_entrada[j];
          }
          u = u + bias * peso_bias;
          if(u <= 0){ 
            y = 0;
          }
          else{
            y = 1;
          }
          //calculando o novo erro
          erro = resultado[i] - y;
          //calculando os novos pesos
          if(erro!=0.0){
            res = res+1;
            terror[k] = terror[k]+1;
            for (int j = 0; j < peso_entrada.length; j++){
              peso_entrada[j] = peso_entrada[j] + taxa_aprendizado * erro * entrada[i][j];
            }
            peso_bias = peso_bias + taxa_aprendizado*erro*bias; 
          }
        }
      }
      tacc_ep[k] = res/entrada.length;
    }
    
    return(epocas*entrada.length-res)/(epocas*entrada.length);
  }
  float teste(float[][]intest, float[]outtest, float[] peso_test, float pbias_test){
    float y, res=0;
    for(int i = 0; i < intest.length; i++){
      float u = 0;
      for(int j = 0; j < intest[i].length; j++){
        u = u + intest[i][j]*peso_test[j];
      }
      u = u + bias*pbias_test;
      if(u<=0){
        y=0;
      }
      else{
        y=1;
      }
      if(outtest[i]-y!=0.0){
        res = res + 1;
      }
    }
    return (outtest.length-res)/outtest.length;
  }
}
