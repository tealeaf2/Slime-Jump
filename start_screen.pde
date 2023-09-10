//Coding the start of the screen for the user
void start_screen(){
  if(keyPressed) {
    startPressed = true;
    tick = 0;
  }
  
  background(255);
  
  pushMatrix();
  translate(width/2, height/2);
  rectMode(CENTER);
  strokeWeight(4);
  fill(255);
  stroke(57, 59, 57);
  rect(10, starty + 10, 200, 50, 50);
  stroke(0);
  rect(0, starty, 200, 50, 50);
  fill(0);
  
  textFont(noteworthy_l);
  textSize(10);
  text("Use A and D to move", -40, -30);
 
  textSize(25);
  text("ANY BUTTON", -80, starty + 10);
  
  textFont(noteworthy_b);
  textSize(15);
  text("- press any button to start -", -85, -50);
  popMatrix();
  
  if(tick > 400) tick = 0;
  if(tick < 200) starty++;
  else starty--;
  tick++;
  
  textFont(noteworthy_l);
  rectMode(CORNER);
  
}
