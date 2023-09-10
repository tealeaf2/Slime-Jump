//Khang Le, kle2, Creative Processing, game.pde
//Main

void setup(){
  windowTitle("Slime Jump");
  setup2(); //Seperate setup so that I don't have to switch tabs
  size(450, 600);
  
  //For font
  noteworthy_b = createFont("Noteworthy-Bold", 15);
  noteworthy_l = createFont("Noteworthy-Bold", 15);
}


void draw(){
  if(!startPressed) start_screen();
  else if(lose) lose_screen();
  
  else if(startPressed && !lose) {
    
    //Main screen 
    //Runs all of the detection, animation, and threshold checks
    if(!check1_reached) {
      if(isPressed){ //Slime movement
        if(key == 'a') slime.moveleft();
        else if(key == 'd') slime.moveright();
      }
      scenes();
      detect();
      player_score_up();
    }
    
    //Score
    fill(255);
    textSize(20);
    text("Height: " + int(player_height), 20, 20);
    
    //Checks to see if second scene is reached
    next_scene_check();
  }
  
  if(isPressed && key == 'r' && lose) reset_start();

  if(player_height >= win_ceiling) win_screen();
}  

//For movement so that you can hold without delay
void keyPressed() { isPressed = true; }
void keyReleased() { isPressed = false; }
