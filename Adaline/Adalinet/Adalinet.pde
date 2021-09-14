class adalinet{
  float[][] entrada;
  float[] peso_entrada;
  float[] resultado;
  float precisao;
  float taxa_aprendizado;
  float bias;
  float validation_accuracy, trainning_accuracy;
  float[] fold_accuracy = new float[5];
  float[] validation_error;
  FloatList trainning_accuracy_ep;
  IntList trainning_error;
  int epocas;
  adalinet(float[][] ent, float[] peso_ent, float[] result, float b, float e, float taxa_ap){
    entrada = ent;
    peso_entrada = peso_ent;
    resultado = result;
    precisao = e;
    taxa_aprendizado=taxa_ap;
    epocas = 0;
    bias = b;
    validation_accuracy=0;
    trainning_accuracy=0;
    fold_accuracy = new float[5];
    trainning_accuracy_ep = new FloatList();
    trainning_error = new IntList();
    validation_error = new float[5];
  }
  
  adalinet inicio(){
    adalinet a;
    a = new adalinet(entrada, peso_entrada, resultado, bias, precisao, taxa_aprendizado);
    float z = 0, w = 0;
    int aux = entrada.length/5;
    IntList aux3 = a.trainning_error;
    FloatList aux4 = trainning_accuracy_ep;
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
      a = new adalinet(in, peso_entrada, out, bias, precisao, taxa_aprendizado);
      w = w + a.treinar(aux3, aux4);
      aux1[i] = a.teste(intest, outtest, a.peso_entrada, a.bias);
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
  
  float treinar(IntList terror, FloatList tacc_ep){
    FloatList acc_ep = new FloatList();
    IntList err = new IntList();
    float  erro_ant, erro_atual;
    float a=0, y=0, u, res = 0, ex = 0;
    //repetiĂ§ĂŁo do calculo de acordo com a precisao
    err.append(0);
    acc_ep.append(0);
    do{
      res = 0;
      //calculo para cada conjunto de entrada
      erro_ant = eqm();
      for (int i = 0; i < entrada.length; i++){
        u = -bias;
        for (int j = 0; j < entrada[i].length; j++){
          u = u + peso_entrada[j]*entrada[i][j];
        }
        
        y = resultado[i] - u;
        if(u<=-1){
          ex = -1;
        }
        else{
          ex = 1;
        }
        if(ex!= 0.0){
          res = res+1;
        }
        for (int j = 0; j < peso_entrada.length; j++){
          peso_entrada[j] = peso_entrada[j] + taxa_aprendizado*y*entrada[i][j];
        }
        bias = bias + taxa_aprendizado*y*(-1);
      }
      erro_atual = eqm();
      epocas = epocas+1;    
      a = erro_atual-erro_ant;
      
      if(a<0){
        a = erro_ant - erro_atual;
      }
      acc_ep.append(res/entrada.length);
      err.append(int(res)-err.get(err.size()-1));
      
    }while(a>precisao);
    terror.append(err);
    tacc_ep.append(acc_ep);
    return(epocas*entrada.length-res)/(epocas*entrada.length);
  }
  
  float eqm(){
    float eqm = 0, u;
    for(int i = 0; i<entrada.length; i++){
      u = -bias;
      for(int j = 0; j<entrada[i].length; j++){
        u = u + entrada[i][j]*peso_entrada[j];
      }
      eqm  = eqm + pow((resultado[i]-u), 2);
    }
    eqm = eqm / entrada.length;
    return eqm;
  }
  float teste(float[][]intest, float[]outtest, float[] peso_test, float bias_test){
    float y, res=0;
    for(int i = 0; i < intest.length; i++){
      float u = 0;
      for(int j = 0; j < intest[i].length; j++){
        u = u + intest[i][j]*peso_test[j];
      }
      u = u - bias_test;
      if(u<=-1){
        y=-1;
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
