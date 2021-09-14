class adalinec{
  float[][] entrada;
  float[] peso_entrada;
  float bias;
  PrintWriter dadoscpos, dadoscneg;
  adalinec(float[][] ent, float[] peso_ent, float b, PrintWriter dadospos, PrintWriter dadosneg){
    entrada = ent;
    peso_entrada = peso_ent;
    dadoscpos = dadospos;
    dadoscneg = dadosneg;
    bias = b;
  }
  
  void teste(){
    float u;
    //calculo para as saidas
    for (int i = 0; i < entrada.length; i++){
      u = -bias;
      for (int j = 0; j < entrada[i].length; j++){
        u = u + peso_entrada[j] * entrada[i][j]; 
      }
      if (u <= 0){
        for(int j = 0; j <entrada[i].length; j++){
          dadoscneg.print((entrada[i][j])+"\t");
        }
        dadoscneg.print("\n");
      }
      else{
        for(int j = 0; j <entrada[i].length; j++){
          dadoscpos.print((entrada[i][j])+"\t");
        }
        dadoscpos.print("\n");
      }
    }
  }
}
