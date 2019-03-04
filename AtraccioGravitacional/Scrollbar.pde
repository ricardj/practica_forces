class Scrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  float realMouseX;
  float realMouseY;
  String title = "Default Name";
  

  Scrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    //int widthtoheight = sw - sh;
    int widthtoheight = 100;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos ;//+ swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(realMouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    
    realMouseX = mouseX- SCREEN_WIDTH/2;
    realMouseY = mouseY- SCREEN_HEIGHT/2;
    
    if (realMouseX> xpos && realMouseX  < xpos+swidth &&
      realMouseY > ypos && realMouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    textSize(30);
    fill(150);
    float b = (spos-xpos) * ratio;
    textAlign(LEFT,CENTER);
    text( str((int)b), xpos-60, ypos+4);
    textSize(15);
    text( title, xpos, ypos-10);
    
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(170,0,0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  public float getPos() {

    // Convert spos to be values between
    // 0 and 8
    return (int)((spos-xpos) * ratio);
  }
  public void setPos(int value){
    newspos = value/ratio+xpos;
  }
  
  
}
