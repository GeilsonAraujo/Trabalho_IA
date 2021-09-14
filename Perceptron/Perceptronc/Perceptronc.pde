class perceptron{
  float[][] entrada;
  float[] peso_entrada;
  float bias;
  float peso_bias;
  PrintWriter dadoscpos, dadoscneg;
  perceptron(float[][] ent, float[] peso_ent, float b, float peso_b, PrintWriter dadospos, PrintWriter dadosneg){
    entrada = ent;
    peso_entrada = peso_ent;
    bias = b;
    peso_bias = peso_b;
    dadoscpos = dadospos;
    dadoscneg = dadosneg;
  }
  
  void teste(){
    float u;
    //calculo para as saidas
    for (int i = 0; i < entrada.length; i++){
      u = 0;
     
      for (int j = 0; j < entrada[i].length; j++){
        u = u + peso_entrada[j] * entrada[i][j]; 
      }
      u = u + bias * peso_bias;
      if (u <= 0){
        for(int j = 0; j <entrada[i].length; j++){
          dadoscneg.print(entrada[i][j]+"\t");
        }
        dadoscneg.print("\n");
      }
      else{
        for(int j = 0; j <entrada[i].length; j++){
          dadoscpos.print(entrada[i][j]+"\t");
        }
        dadoscpos.print("\n");
      }
    }
  }
  
  
}
