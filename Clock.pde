int Encoder1pin = 2; //D0 = Yellow
int Encoder2pin = 3; //D1 = Yellow/Black
int Encoder3pin = 4; //D2 = Green
int Encoder4pin = 5; //D3 = Green/Black

int Driver1pin = 7;  //2 = Orange 
int Driver2pin = 8;  //3 = Brown 
int Driver3pin = 9;  //4 = Brown/Black
int Driver4pin = 10; //5 = Red
int Driver5pin = 11; //6 = Red/Black 
int Driver6pin = 12; //7 = Blue
int Driver7pin = 13;
int Auxpin = 6;  //1 = Orange/Black

int pattern_counter = 0;

int tenths = 0;
int seconds_ones = 0;
int minutes_ones = 0;
int hours_ones = 0;
int seconds_tens = 0;		  // Initialise values for tens and ones units of h,m,s
int minutes_tens = 0;		  // these are the values actually sent to the LEDs
int hours_tens = 0;
int seconds = 56;
int minutes = 34;     // Inititialise actual values for h,m,s
int hours = 12;

boolean countdown_enabled = false;
int countdown_tenths = 0;
int countdown_seconds_ones = 0;
int countdown_minutes_ones = 0;
int countdown_hours_ones = 0;
int countdown_seconds_tens = 0;		  // Initialise values for tens and ones units of h,m,s
int countdown_minutes_tens = 0;		  // these are the values actually sent to the LEDs
int countdown_hours_tens = 0;
int countdown_seconds = 0;
int countdown_minutes = 0;     // Inititialise actual values for h,m,s
int countdown_hours = 0;

char displaydigit[10] = {0,0,0,0,0,0,0,0,0,0};

int clock_mode = 0;
int old_clock_mode = 0;
// Clock Modes: 1. Time 2.Countdown 3.Serial 0.Off
#include <MsTimer2.h>




void setup () {
  pinMode(Auxpin,OUTPUT);

  pinMode(Encoder1pin, OUTPUT);      
  pinMode(Encoder2pin, OUTPUT); 
  pinMode(Encoder3pin, OUTPUT); 
  pinMode(Encoder4pin, OUTPUT); 

  pinMode(Driver1pin, OUTPUT); 
  pinMode(Driver2pin, OUTPUT); 
  pinMode(Driver3pin, OUTPUT); 
  pinMode(Driver4pin, OUTPUT); 
  pinMode(Driver5pin, OUTPUT); 
  pinMode(Driver6pin, OUTPUT); 
  pinMode(Driver7pin, OUTPUT); 
  //pinMode(Driver8pin, OUTPUT); 

  Serial.begin(9600);
  Serial.print("Clock Starting Up!\n");

  Serial.println("Initializing timer interrupt.");
  MsTimer2::set(100, Tick); // Every 100ms, run the Tick
  MsTimer2::start();
  AllCellsOff();
  
  Serial.println("Powering Up...");
  PrintMenu();
}



void loop () {
  delay(1);
  if (Serial.available() > 0) {
    // read the incoming byte:
    byte incomingByte = Serial.read();
    switch (incomingByte) {
    case 115:
      SetTime();
      PrintMenu();
      break;
     case 116:
      Serial.print("Displaying Time...\n\n\n\n");
      old_clock_mode=clock_mode;
      clock_mode=1;
      PrintMenu();
      break;
    case 100:
      InputDigits();
      PrintMenu();
      old_clock_mode=clock_mode;
      clock_mode=3;
      break;
    case 112:
      Serial.println("Executing Test Pattern...");
      PrintMenu();
      old_clock_mode=clock_mode;
      clock_mode=4;
      break;
    case 99:
      CountDown();
      countdown_enabled=true;
      PrintMenu();
      old_clock_mode=clock_mode;
      clock_mode=2;
      break;
     case 111: //O (Power off)
      if (clock_mode==0){ // We are off already, lets turn back on)
      clock_mode=old_clock_mode;
      Serial.println("Powering on...");
      } else {
      old_clock_mode=clock_mode;
      clock_mode=0;
      Serial.println("Powering off...");
      }
      PrintMenu();
      break;
     case 49: //1 is on
      old_clock_mode=0;
      clock_mode=1; 
      break;
     case 48: //0 is off
      old_clock_mode=1;
      clock_mode=0;
      break;
    }

  }

}


void SetDigit (int pin, int value){
  UnlatchAll();
  //Next Setup our encode
  digitalWrite(Encoder4pin, HIGH && (value & B00001000));
  digitalWrite(Encoder3pin, HIGH && (value & B00000100));
  digitalWrite(Encoder2pin, HIGH && (value & B00000010));
  digitalWrite(Encoder1pin, HIGH && (value & B00000001));
  //Now Latch!
  Latch(pin);
  //Now Unlatch!
  UnLatch(pin);

}

void UnlatchAll(){
  //This function Unlatches all of the drivers
  digitalWrite(Driver1pin, HIGH);
  digitalWrite(Driver2pin, HIGH);
  digitalWrite(Driver3pin, HIGH);
  digitalWrite(Driver4pin, HIGH);
  digitalWrite(Driver5pin, HIGH);
  digitalWrite(Driver6pin, HIGH);
  digitalWrite(Driver7pin, HIGH);
  digitalWrite(Auxpin, HIGH);
}

void Latch(int pin){
  switch (pin) {
  case 1:
    digitalWrite(Driver1pin, LOW);
    break;
  case 2:
    digitalWrite(Driver2pin, LOW);
    break;
  case 3:
    digitalWrite(Driver3pin, LOW);
    break;
  case 4:
    digitalWrite(Driver4pin, LOW);
    break;
  case 5:
    digitalWrite(Driver5pin, LOW);
    break;
  case 6:
    digitalWrite(Driver6pin, LOW);
    break;
  case 7:
    digitalWrite(Driver7pin, LOW);
    break;
  case 0:
    digitalWrite(Auxpin, LOW);
    break;
  }
}
void UnLatch(int pin){
  switch (pin) {
  case 1:
    digitalWrite(Driver1pin, HIGH);
    break;
  case 2:
    digitalWrite(Driver2pin, HIGH);
    break;
  case 3:
    digitalWrite(Driver3pin, HIGH);
    break;
  case 4:
    digitalWrite(Driver4pin, HIGH);
    break;
  case 5:
    digitalWrite(Driver5pin, HIGH);
    break;
  case 6:
    digitalWrite(Driver6pin, HIGH);
    break;
  case 7:
    digitalWrite(Driver7pin, HIGH);
    break;
  case 0:
    digitalWrite(Auxpin, HIGH);
    break;
  }
}


void DisplayTime () {			   // Function to display the time
    seconds_ones = seconds % 10;	     // Get the 1's digit of seconds
  if (seconds>=10){			    // If seconds greater than 10
    seconds_tens = seconds / 10;
  }	   // Get 10's digit of seconds
  else {
    seconds_tens = 0;
  }			 // Otherwise 10s is 0

    minutes_ones = minutes % 10;	     // Repeat for minutes
  if (minutes>=10){
    minutes_tens = minutes / 10 ;
  }
  else {
    minutes_tens = 0;
  }

  hours_ones = hours % 10;		   // Repeat for hours
  if (hours>=10){
    hours_tens = hours / 10 ;
  }
  else {
    hours_tens = 0;
  }  
  SetDigit(0,8);
  SetDigit(1,tenths);  // Send digits to LEDs
  SetDigit(2,seconds_ones);  // Send digits to LEDs
  SetDigit(3,seconds_tens);
  SetDigit(4,minutes_ones);
  SetDigit(5,minutes_tens);
  SetDigit(6,hours_ones);
  SetDigit(7,hours_tens);
}

void Tick() {
if (countdown_enabled==true){  
  
  countdown_tenths--;
     if (countdown_tenths<0){
    countdown_tenths=9;
    countdown_seconds--;
    if (countdown_seconds<0){			  
      countdown_seconds = 59;				 
      countdown_minutes--;		  
      if (countdown_minutes < 0){			
        countdown_hours--;			
        countdown_minutes = 59;				
        if (countdown_hours < 0){
          countdown_enabled=false;
          countdown_hours=0;
          countdown_minutes=0;
          countdown_seconds=0;
          countdown_tenths=0;
        }
      }
    }
  }
}//End if countdown enabled
if (countdown_hours <= 0 && countdown_minutes <= 0 && countdown_seconds <= 0 && countdown_tenths <= 0)
{
  countdown_enabled=false;
  countdown_hours=0;
  countdown_minutes=0;
  countdown_seconds=0;
  countdown_tenths=0;
}

    
  				     // If a tick has occured
  tenths = tenths + 1;		    // Increment the seconds
  if (tenths>10){
    tenths=0;
    seconds=seconds+1;
    if (seconds>59){			    // If a minute has passed
      seconds = 0;				  // Send seconds back to 0
      minutes = minutes + 1;		    // Increment the minutes
      if (minutes >59){			   // If an hour has passed
        hours = hours + 1;			// Increment the hours
        minutes = 0;				// Send the minutes back to 0
        if (hours > 23){
          ;			 // If a day has passed
          hours = 0;				  // Set hours back to 0
        }
      }
    }
  }
switch(clock_mode) {
   case 0: //Off
     AllCellsOff();
     break;
   case 1: //Time
     DisplayTime();
     break;
   case 2: //Countdown
     DisplayCountdown();
     break;     
   case 3: //Serial
     DisplayDigits();
     break;
   case 4: //Serial
     TestPattern();
     break;
  }//End Clock_mode case 


}//End Tick


