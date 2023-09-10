//Khang Le, kle2, Creative Processing, function.pde
//All of the functions of the main game


//All of the initializations for the class as well as the other objects
void setup2(){
  int index = 0;
  int cloud_shape = 1;
  boolean direction = false;
  velocity = 1.5;
  cave = loadImage("cave_background.png");
  cave.resize(cave.width/2, cave.height/2);
  
  clouds = new Clouds[count_clouds];
  platforms = new Platforms[count_plat];
  spikes = new Spike[count_spikes];
  
  slime = new Slime(width/2, height); //Initialize slime
  superjump = new Jump(random(0, width - 50), random(-height * 2, -height * 4));
  
  for(int i = 0; i < count_spikes; i++)
    spikes[i] = new Spike(random(100, width - 100), -400 * i);
  
  for(int i = 1; i <= count_clouds; i++){
    if(random(0, 1) < 0.5) {
      cloud_shape = 2;
      direction = !direction;
    }
    else {
      cloud_shape = 1;
      direction = !direction;
    }
    clouds[index++] = new Clouds(random(0, width), random(-height, height), random(0.2, 1.2), cloud_shape, direction); //Initializing clouds
  }
  
  index = 0;
  for(int i = 1; i <= count_plat; i++){ //Initialize platforms
    platforms[index++] = new Platforms(random(0, width - 100), 80 * i, false, index); //Default middle value is 80 * i
  }
}


//To animate scene2
void scene2(){
  //last_layer();
  background(182, 214, 219);
  
  for(Clouds cloud: clouds){
    cloud.makecloud(); 
    cloud.movecloud();
    cloud.scrolling();
    cloud.cloud_check();
  }
  superjump.scrolling();
  cloud_move_func();
  
  superjump.jump_sprite();
  slime_movement();
  
  for(Spike spike: spikes){
    spike.sprite();
    spike.scrolling();
    spike.reset();
    spike.moving();
  }
    
  
  for(Platforms platform: platforms) { //Platform detection with slime
    platform.platform_sprite2(platwidth);
    platform.scrolling();
    platform.plat_check();
    platform.moving();
  }
  superjump.reset();
}


//To animate scene1
void scene1(){
  //last_layer();
  background(19, 19, 19);
  image(cave, 0, imagey);
  cave_move_func();
  superjump.jump_sprite();
  slime_movement();
  
  if(imagey >= height) imagey -= cave.height * 3/2;
  
  superjump.scrolling();
  
  for(Spike spike: spikes){
    spike.sprite();
    spike.scrolling();
    spike.reset();
    spike.moving();
  }
  
  for(Platforms platform: platforms) { //Platform detection with slime
    
    platform.platform_sprite1();
    platform.scrolling();
    platform.plat_check();
    platform.moving();
  }
  
  superjump.reset();
}


//For hitting the superjump
void detect_big_jump() {
  if(sqrt(pow(slime.slimey() - superjump.y(), 2) + pow(slime.slimex() - superjump.x(), 2)) <= 20 + v_bound) {
    jump_touched = true;
    tick = 0;
    velocity = 2;
    jump_value = 0;
  }
}


void detect() { //For detection of collision or off screen
  if(slime.slimey() > height + 100) lose = true;
   
  if(slime.calculate_velocity(velocity, tick/2) <= 0) calc_collision();
}


void scenes(){
   switch(scene){
     case(1):
       scene1();
       break;
     case(2):
       scene2();
       break;
     default:
       break;
    }
}


//To calculate every collision between the slime and spikes and slime and platforms
void calc_collision(){
  v_bound = pow(abs(slime.calculate_velocity(velocity, tick/2)), 3);
  
  for(Spike spike: spikes){
    spike.calculate_collision();
  }
  
  detect_big_jump();
  
  for(Platforms platform: platforms) {
    if(jump_touched) break;
    if(slime.calculate_velocity(velocity, tick/2) > 0) break;
    
    //Big problem is with frameRate and how it checks too little, so I had to overcompensate values
    if (abs(platform.platy() - slime.slimey()) <= (20 + v_bound) && slime.slimey() <= platform.platy()){
      if(slime.slimex() >= platform.platx() - 10 && slime.slimex() <= platform.platx() + platwidth) {
        slime.moveplat(platform);
        tick = 0;
        velocity = 1.4;
        jump_value = 0;
      }
    }
  }
}


void slime_movement(){ //The gravity of the slime happening
  if(tick >= 2) jump_touched = false;
  
  tick++;
  slime.make_slime();
  slime.boundary_check();
  
  if(tick % 2 == 0){
    slime.gravity(tick/2, velocity);
    
    if(jump_value < 15) //For the slime to look like its in the air
      jump_value++;
  }
}

//Brings height up everytime slime goes up
void player_score_up() {
  if(slime.slimey() <= height/2) player_height++;
}


void cave_move_func() { //Centering camera in scene1
  if(slime.slimey() <= height/2) {
    for(Platforms platform: platforms){
      platform.movedown();
    }
    for(Spike spike: spikes){
      spike.movedown();
    }
    slime.movedown();
    superjump.movedown();
    imagey += 3;
  }
}


//Couldve been a lot better coded into one function ngl
void cloud_move_func() { //Centering camera scene2
  if(slime.slimey() <= height/2) { //For each time the guy jumps
    for(Clouds cloud: clouds){
      cloud.movedown();
    }
    for(Platforms platform: platforms){
      platform.movedown();
    }
    for(Spike spike: spikes){
      spike.movedown();
    }
    slime.movedown();
    superjump.movedown();
  }
}
