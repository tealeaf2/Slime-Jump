//Global variables and all other variables
Clouds[] clouds;
Platforms[] platforms;
Slime slime;
Jump superjump;
Spike[] spikes;

//Font
PFont noteworthy_b;
PFont noteworthy_l;

int slime_radius = 25;

//Set variables
int count_clouds = 15;
int count_plat = 7;
float scroll_speed = 0.2;
int down_speed = 5;
int jump_value = 0;

int tick; //To have another ticker for frame()
float velocity;
float platwidth = 100;
int win_ceiling = 1500; //cave_ceiling at value/3; can make this value bigger or smaller depending on time spent on game
float v_bound;

float player_height = 0; //To keep track of score

//For keypresses
boolean isPressed;
boolean startPressed = false;

int scene = 1;
PImage cave;
float imagey = 0;
int scene_tick = 0;
boolean check1_reached = false;
boolean changed = false;
int scene_tick_max = 100;

boolean jump_touched = false;
int count_spikes = 2;

//For start_screen animation
int starty = 0;

//For end screen
boolean lose = false;
