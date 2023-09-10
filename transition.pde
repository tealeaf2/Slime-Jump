//To check if the threshold has been reach and starts the scene change
void next_scene_check() {
  if(player_height >= win_ceiling / 3 && !changed) {
    check1_reached = true;
    scene_tick++;
    
    if(scene_tick < scene_tick_max) {
      scene_animate();
    }
    else {
      scene_tick = 0;
      check1_reached = false;
      changed = true;
    }
  }
}


//Animation transition from scene1 to scene2
void scene_animate(){
  background(19, 19, 19);
  image(cave, 0, imagey);
  
  for(Platforms platform: platforms){
    if(scene_tick < scene_tick_max/2) platform.moveleft();
    else if(scene_tick < scene_tick_max) platform.moveright();
    platform.platform_sprite1();
  }
  
  slime.make_slime();
  imagey += cave.height/50;
  
  stroke(255);
  fill(255);
  if(scene_tick < scene_tick_max/2) circle(width/2, height/2, pow(scene_tick,2));
  else {
    circle(width/2, height/2, pow(scene_tick_max/2, 2) - pow(scene_tick - scene_tick_max/2, 2));
    scene = 2;
  }
}
