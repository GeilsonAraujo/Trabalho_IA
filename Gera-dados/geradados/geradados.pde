IntList aux;
PrintWriter dadost, dadosc;
dadost = createWriter("setvers15.txt");
dadosc = createWriter("csetvers15.txt");
String[] lines = loadStrings("setvers.txt");
int b;
aux = new IntList();
b = int(random(0,49));
aux.append(b);
dadost.println(lines[b]);
for (int i = 1; i<30; i++){
    if(i % 2 == 0){
      b = int(random(0,49));}
    else {
      b = int(random(50,99));}
    while(aux.hasValue(b)==true){
      if(i % 2 == 0){
        b = int(random(0,49));}
      else {
        b = int(random(50,99));}
    }
    aux.append(b);
    dadost.println(lines[b]);
  
}

for(int i = 0; i< 100; i++){
  if(aux.hasValue(i)==false){
    dadosc.println(lines[i]);
  }
}


dadost.flush();
dadost.close();
dadosc.flush();
dadosc.close();
