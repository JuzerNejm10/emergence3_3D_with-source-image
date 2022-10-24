int w, h;

float xstart, xnoise, ystart, ynoise;
float xstartNoise, ystartNoise;
float rad = 150;
float lineLength = -200;
String radCheck = "more";
String lineCheck = "more";
float strokeW = random(0.2, 1.2);
String bckground="";
int opacity;

PImage source;

void setup() {
  strokeWeight(strokeW);

  xstartNoise = random(20);
  ystartNoise = random(20);
  xstart = random(10);
  ystart = random(10);

  if (xstartNoise<8) {
    bckground = "color";
  } else {
    bckground = "image";
  }
}

void settings() {
  source = loadImage("courbet.jpg");
  w = source.width;
  h = source.height;
  size(w, h, P3D);
  smooth(4);
}

void draw () {
  if (bckground == "color") {
    background(255);
  } else {
    image(source, 0, 0);
  }

  float randRad = random(1, 17.1);

  if (rad<3000&&radCheck=="more") {
    rad+=randRad;
  } else {
    rad-=randRad;
    if (rad>2000) {
      radCheck = "less";
    } else {
      radCheck = "more";
    }
  }

  float randLineLength = random(1, 2.1);

  if (lineLength<500&&lineCheck=="more") {
    lineLength+=randLineLength;
  } else {
    lineLength-=randLineLength;
    if (lineLength>-100) {
      lineCheck = "less";
    } else {
      lineCheck = "more";
    }
  }

  xstartNoise+=0.1;
  ystartNoise+=0.1;
  xstart+=(noise(xstartNoise)*0.3);
  ystart+=(noise(ystartNoise)*0.1)-0.1;
  xnoise = xstart;
  ynoise = ystart;
  int z;
  for (int y = 0; y <= height; y+=5) {
    ynoise += 0.01;
    xnoise = xstart;
    for (int x = 0; x <= width; x+=7) {
      xnoise += 0.01;
      z = (int)random(0, (y-x)*2);
      if (xstartNoise>8) {
        dP2D(x, y, noise(xnoise, ynoise));
      } else {
        dP3D(x, y, z, noise(xnoise, ynoise));
      }
    }
  }
}

void dP2D(int x, int y, float noiseF) {
  pushMatrix();
  translate(x, y);  
  stuff(x, y, noiseF);
}

void dP3D(int x, int y, int z, float noiseF) {
  pushMatrix();
  translate(x, y, z);
  stuff(x, y, noiseF);
}

void stuff(int x, int y, float noiseF) {
  rotate(noiseF * radians(rad));
  color c = source.get(int(x), int(y));
  opacity = (int)random(50, 256);
  stroke(c, opacity);      
  line(0, 0, lineLength, 0);
  popMatrix();
}

void mousePressed() {
  restart();
}

void restart() {
  rad = 150;
  lineLength = -200;
  radCheck = "more";
  lineCheck = "more";
  strokeW = random(0.5, 1.2);
  translate(0, 0);
  frameCount = -1;
}
