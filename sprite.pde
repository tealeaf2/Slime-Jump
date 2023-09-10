//Khang Le, Creative Processing, final, sprite.pde
//For all of the sprites and custom objects in the level

class Clouds {
  float xpos; 
  float ypos;
  float speed;
  float shape;
  boolean direction;
  
  Clouds(float x, float y, float sp, float size, boolean direc){
    xpos = x;
    ypos = y;
    speed = sp;
    shape = size;
    direction = direc;
  }
  
  void makecloud(){
    fill(255);
    stroke(255);
    
    if(shape == 1){ //cloudSprite 1
      shape1();
    }
   
    else if(shape == 2){ //cloudSprite 2
      shape2();
    }
  }
  
  void shape1() {
      arc(xpos + 20, ypos + 100, 40, 30, PI, TWO_PI);
      arc(xpos + 50, ypos + 100, 50, 50, PI, TWO_PI);
      arc(xpos + 80, ypos + 100, 20, 30, PI, TWO_PI);
  }
  
  void shape2() {
      arc(xpos + 40, ypos + 100, 50, 30, PI, TWO_PI);
      arc(xpos + 80, ypos + 100, 60, 80, PI, TWO_PI);
      arc(xpos + 110, ypos + 100, 20, 30, PI, TWO_PI);
  }
  
  void movecloud(){
    if(direction == true) xpos += speed;
    else xpos -= speed;
  }
  
  void movedown() { ypos += down_speed / 2; }
  
  void scrolling() { ypos += scroll_speed / 3; }
  
  void cloud_check(){
    if(ypos > height + 80) ypos = -200;
    if(xpos > width + 200) xpos = -130;
    else if(xpos < -150) xpos = width + 80;
  }
}


class Platforms {
  float x;
  float y;
  boolean act_move;
  int platvalue;
  int move_value = 2;
  
  Platforms(float cx, float cy, boolean move, int index){
    x = cx;
    y = cy;
    act_move = move;
    platvalue = index;
  }
  
  float platx() { return x; } //I didn't know that you could just do platform.x for xpos
  float platy() { return y; }
  int index() { return platvalue; }
  
  void moving(){
    if(act_move) {
      if(x >= width - 100 || x <= 0) move_value = -move_value;
      x += move_value;
    }
  }
  
  //Total platheight = 20;
  void platform_sprite2(float platwidth){
    stroke(255, 247, 87);
    strokeWeight(2);
    line(x, y, x + platwidth, y);
  
    strokeWeight(1);
    stroke(232, 143, 235);
    fill(232, 143, 235);
    rect(x + 10, y + 2, platwidth - 20, 3);
  
    stroke(186, 117, 189);
    fill(186, 117, 189);
    rect(x + 20, y + 5, platwidth - 40, 10);
  }
  
  void platform_sprite1(){
    stroke(83, 86, 89);
    fill(83, 86, 89);
    rect(x,y, 100, 2);
    
    stroke(152, 154, 158);
    fill(152, 154, 158);
    rect(x, y + 3, 100, 10);
    
    stroke(200, 203, 207);
    fill(200, 203, 207);
    rect(x, y + 2, 100, 1);
  }
  
  void scrolling() { 
    y += scroll_speed; 
  }
  
  void plat_check() {
    if(y > height + 20) {
      y = -20;
      x = random(0, width - 100);
      if(random(player_height, win_ceiling) <= random(player_height, win_ceiling)) act_move = true;
      else act_move = false;
    }
  }
  
  void movedown() { 
    y += down_speed; 
  }
  void moveleft() { x -= width/30; }
  void moveright() { x += width/30; }
}


class Slime {
  float x;
  float y;
  float acceleration = -0.1;
  
  Slime(float xpos, float ypos) {
    x = xpos;
    y = ypos;
  }
  
  float slimex() { return x; }
  float slimey() { return y; }
  
  void gravity(float t, float velocity) {
    y = y - velocity * t - acceleration/2 * pow(t, 2);
  }
  
  float calculate_velocity(float velocity, float t) {
    return velocity + acceleration * t;
  }
  
  void moveleft() { x -= 3; }
  void moveright() { x += 3; }
  void moveplat(Platforms platform) { y = platform.platy() - 10; }
  void movedown() {y += down_speed; }
  
  void boundary_check() {
    if(x > width + 25) x = -25;
    else if(x < -25) x = width + 25;
  }
  
  
  void make_slime(){
    pushMatrix();
    translate(x, y);
    strokeWeight(3); //Outside body
    stroke(192, 215, 252);
    fill(152, 192, 245);
    arc(0, 0, slime_radius*2 - jump_value, slime_radius * 2, PI, TWO_PI);
    arc(0, 0, slime_radius*2 - jump_value, 40 + jump_value, 0, PI); //Change the third and fourth value for slime jumping
    
    strokeWeight(5);
    stroke(127, 211, 250, 80); //Inner body
    fill(186, 226, 245, 90);
    arc(0, -2, slime_radius * 4/5, slime_radius * 4/5, PI, TWO_PI);
    arc(0, -2, slime_radius * 4/5 - jump_value, (10 + slime_radius) / 5 + jump_value, 0, PI);
  
    strokeWeight(3);
    stroke(0); //Eyes
    ellipse(-8, -12, 1, 5);
    ellipse(8, -12, 1, 5);
  
    strokeWeight(2); //Smile
    noFill();
    arc(0, -2, 8, 4, 0, PI);
  
    stroke(255); //Pupils
    point(-8, -16);
    point(8, -16);
    popMatrix();
  }
}


class Jump {
  float x, y;
  
  Jump(float x_random, float y_random) {
    x = x_random;
    y = y_random;
  }
  
  float x() { return x; }
  float y() { return y; }
  
  void jump_sprite() {
    stroke(41, 117, 60);
    fill(63, 186, 94);
    circle(x, y, 30);
    stroke(75, 222, 112);
    fill(75, 222, 112);
    circle(x, y, 20);
    stroke(85, 242, 124);
    fill(85, 242, 124);
    circle(x, y, 15);
  }
  
  void movedown() {y += down_speed; }
  void scrolling() { y += scroll_speed; }
  void reset() { 
    if(y - 100 >= height) {
      y -= random(height * 2, height * 4);
      x = random(20, width - 20);
    }
  }
}


class Spike {
  float x, y, size = 0;
  boolean act_move = false;
  int move_value = 3;
  
  Spike (float x_random, float y_random) {
    x = x_random;
    y = y_random;
  }
  
  void sprite(){
    pushMatrix();
    translate(x, y);
    rotate(frameCount / -150.0);
    stroke(176, 67, 48);
    fill(240, 89, 62);
    star(0, 0, 25 + size, 30 + size, 20); 
    stroke(255, 110, 84);
    fill(255, 110, 84);
    star(0, 0, 15 + size, 20 + size, 10); 
    popMatrix();
    
    stroke(0);
    fill(0);
    circle(x- 5, y- 5, 3);
    circle(x+ 5, y- 5, 3);
    strokeWeight(3);
    line(x- 5, y +5, x +5, y+5);
    
    strokeWeight(2);
    stroke(255);
    fill(255);
    point(x- 7, y- 7);
    point(x+ 3, y- 7);
  }
  
  void movedown() {y += down_speed; }
  void scrolling() { y += scroll_speed; }
  
  void calculate_collision() {
    if(sqrt(pow(slime.slimey() - y, 2) + pow(slime.slimex() - x, 2)) <= size + 30 + v_bound) lose = true;
  }
  
  
  void moving(){
    if(act_move) {
      if(x >= width - 100 || x <= 0) move_value = -move_value;
      x += move_value;
    }
  }
  
  void reset(){
    if(y >= height + 100) {
      x = random(100, width - 100);
      y = random(-height - 100, -height * 2);
      
      if(random(0, 10) <= 5) {
        act_move = true;
        size = 0;
      }
      else {
        act_move = false;
        size = random(10, 30);
      }
    }
  }
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
