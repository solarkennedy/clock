void PrintSerial(){
Serial.print("The Time is: ");
Serial.print(hours, DEC);
Serial.print(":");
if (minutes <= 10) Serial.print("0");
Serial.print(minutes, DEC);
Serial.print(":");
if (seconds <= 10) Serial.print("0");
Serial.print(seconds, DEC);
Serial.print("\n");
}

void PrintMenu(){
  Serial.print("\nMenu:\n (S)et Time  (D)isplayDigits Test(P)attern (O)ff (C)ount Down (T)ime  \n");
}

void SetTime(){
  byte newhoursa;
  byte newhoursb;
  byte newminutesa;
  byte newminutesb;
  boolean gotinput = false;
  Serial.flush();
  Serial.print("Please input the time in the form of HHMM: \n");
  while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newhoursa = Serial.read();
      gotinput=true;
    }
    }
  newhoursa-=48;
  Serial.print(newhoursa, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newhoursb = Serial.read();
      gotinput=true;
    }
    }
  newhoursb-=48;
  Serial.print(newhoursb, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newminutesa = Serial.read();
      gotinput=true;
    }
    }
  newminutesa-=48;
  Serial.print(newminutesa, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newminutesb = Serial.read();
      gotinput=true;
    }
    }
  newminutesb-=48;
  Serial.print(newminutesb, DEC);
  
  Serial.print("\n Thanks!\n");
  
  hours = newhoursa * 10 + newhoursb;
  minutes = newminutesa * 10 + newminutesb;
  seconds = 0;  
}

void PrintTime(){
  Serial.print("\n\n\n\n");
  PrintSerial();
  PrintMenu();
}

void CountDown(){
  Serial.print("\n\n\n\n");
  byte newhoursa;
  byte newhoursb;
  byte newminutesa;
  byte newminutesb;
  boolean gotinput = false;
  Serial.flush();
  Serial.print("Please input the countdown time in the form of HHMM: \n");
  while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newhoursa = Serial.read();
      gotinput=true;
    }
    }
  newhoursa-=48;
  Serial.print(newhoursa, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newhoursb = Serial.read();
      gotinput=true;
    }
    }
  newhoursb-=48;
  Serial.print(newhoursb, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newminutesa = Serial.read();
      gotinput=true;
    }
    }
  newminutesa-=48;
  Serial.print(newminutesa, DEC);
  
  gotinput=false;
   while (gotinput == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      newminutesb = Serial.read();
      gotinput=true;
    }
    }
  newminutesb-=48;
  Serial.print(newminutesb, DEC);
  
  Serial.print("\n Thanks!\n");
  
  countdown_hours = newhoursa * 10 + newhoursb;
  countdown_minutes = newminutesa * 10 + newminutesb;
  countdown_seconds = 0; 
  countdown_tenths=0;
 
}

void InputDigits(){
  Serial.print("\n\n\n\n");
  Serial.print("Please enter the 7 digits you want to display:");
  for (int counter=1; counter <= 7; counter++)
  {
    int tempholder = 0;
    tempholder=ReadChar() - 48;
    if (tempholder==0 || tempholder==1 || tempholder==2 || tempholder==3 || tempholder==4 || tempholder==5 || tempholder==6 || tempholder==7 || tempholder==8 || tempholder==9 || tempholder ==0)
    {
       displaydigit[counter]=tempholder;
    } else {
      displaydigit[counter]=0xa;
    }
  }
}

char ReadChar(){
  char readit = 0;
  boolean input=false;
   while (input == false) {
    // read the incoming byte:
    if (Serial.available() > 0){
      readit = Serial.read();
      input=true;
    }
    }
    return readit;
}
