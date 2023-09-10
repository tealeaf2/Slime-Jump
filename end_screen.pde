void lose_screen(){
  background(255);
  
  pushMatrix();
  translate(width/2, height/2);
  fill(0);
  text("You failed. Try again :(", -80, 0);
  textSize(15);
  text("Press r to restart", -65, 30);
  popMatrix(); 
}

//For reset of the whole game
void reset_start (){
   slime.x = width/2;
   slime.y = height;
   lose = false;
   scene = 1;
   velocity = 1.5;
   tick = 0;
   player_height = 0;
   
   for(Platforms platform: platforms){
     platform.x = random(0, width - 100);
   }
   for(Spike spike: spikes){
     spike.y += -height;
   }
}


void win_screen(){
  noLoop();
  
  PImage space;
  space = loadImage("win_screen.jpeg");
  
  image(space, 0, 0, width, height);
  translate(width/2, height/2);
  fill(255);
  textFont(noteworthy_b);
  textSize(20);
  text("You made it to space! You won!", -120, 0);
}
