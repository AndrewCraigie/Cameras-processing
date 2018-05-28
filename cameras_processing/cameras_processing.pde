// Andrew Craigie
// cameras_processing.pde

// Processing sketch to investigate control of the camera

Axis axis;

float camR = 800.0;
float camX = 0.0;
float camY = 0.0;
float camZ = 0.0;

float targetX = 0.0;
float targetY = 0.0;
float targetZ = 0.0;

float camDirX = 0.0;
float camDirY = 1.0;
float camDirZ = 0.0;

float camAlpha = -30.0;    // Angle of camera around x axis
float camBeta = 60.0;     // Angle of camera around y axis

float camBetaIncrement = 1.0;
float camAlphaIncrement = 0.0;

boolean wobble = true;

void setup () {
  size(800, 800, P3D);

  axis = new Axis(0.0, 0.0, 0.0, width, height, width, 2);
}

void keyPressed() {

  if (keyCode == DOWN){
    camR += 10;
    println("Camera radius: ", camR);
  }
  if (keyCode == UP){
    camR -= 10; 
    println("Camera radius: ", camR);
  }

  if (key == 'o' || key == 'O') {
    ortho(-camR/2, camR/2, -camR/2, camR/2); // Same as ortho()
  }

  if (key == 'p' || key == 'P') {
    perspective();
  }
  
  if (key == 'w' || key == 'W') {
    wobble = !wobble;
    camAlpha = 0;
  }
  
}

void mouseDragged() {
  camAlpha = map(mouseY, 0, height, 180, -180);
  camBeta = map(mouseX, 0, width, -180, 180);
}

void updateCamera() {
  camX = camR * cos(radians(camAlpha)) * cos(radians(camBeta));
  camY = camR * sin(radians(camAlpha));
  camZ = camR * cos(radians(camAlpha)) * sin(radians(camBeta));
}


void draw() {
  background(0);


  updateCamera();
  camera(camX, camY, camZ, targetX, targetY, targetZ, camDirX, camDirY, camDirZ);

  axis.draw(color(255, 0, 0), color(0, 255, 0), color(0, 0, 255));
  
  pushStyle();
  stroke(255, 100, 0);
  strokeWeight(4);
  fill(255, 255, 100, 50);
  box(100, 100, 100);
  popStyle();

  camBeta += camBetaIncrement;
  
  if (wobble) {
    camAlphaIncrement += 0.1;
    camAlpha += sin(camAlphaIncrement) * 2;
  }
  
}
