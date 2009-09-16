void TestPattern() {
if (tenths == 0){  
  
if (pattern_counter == 10)
pattern_counter=0;

  SetDigit(1,pattern_counter);  // Send digits to LEDs
  SetDigit(2,pattern_counter);  // Send digits to LEDs
  SetDigit(3,pattern_counter);
  SetDigit(4,pattern_counter);
  SetDigit(5,pattern_counter);
  SetDigit(6,pattern_counter);
  SetDigit(7,pattern_counter);
    SetDigit(0,8);
pattern_counter++;
}
} // end test pattern

void DisplayDigits(){

  SetDigit(0,10);
  SetDigit(1,displaydigit[7]);  // Send digits to LEDs
  SetDigit(2,displaydigit[6]);  // Send digits to LEDs
  SetDigit(3,displaydigit[5]);
  SetDigit(4,displaydigit[4]);
  SetDigit(5,displaydigit[3]);
  SetDigit(6,displaydigit[2]);
  SetDigit(7,displaydigit[1]);
}

void DisplayCountdown(){
    countdown_seconds_ones = countdown_seconds % 10;	     // Get the 1's digit of seconds
  if (countdown_seconds>=10){			    // If seconds greater than 10
    countdown_seconds_tens = countdown_seconds / 10;
  }	   // Get 10's digit of seconds
  else {
    countdown_seconds_tens = 0;
  }			 // Otherwise 10s is 0

    countdown_minutes_ones = countdown_minutes % 10;	     // Repeat for minutes
  if (countdown_minutes>=10){
    countdown_minutes_tens = countdown_minutes / 10 ;
  }
  else {
    countdown_minutes_tens = 0;
  }

  countdown_hours_ones = countdown_hours % 10;		   // Repeat for hours
  if (countdown_hours>=10){
    countdown_hours_tens = countdown_hours / 10 ;
  }
  else {
    countdown_hours_tens = 0;
  }  
  SetDigit(0,8);
  SetDigit(1,countdown_tenths);  // Send digits to LEDs
  SetDigit(2,countdown_seconds_ones);  // Send digits to LEDs
  SetDigit(3,countdown_seconds_tens);
  SetDigit(4,countdown_minutes_ones);
  SetDigit(5,countdown_minutes_tens);
  SetDigit(6,countdown_hours_ones);
  SetDigit(7,countdown_hours_tens);
}
