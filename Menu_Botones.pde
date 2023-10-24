class Menu {
  Button startButton, exitButton;
  boolean inGame;
  PImage fondo;
  

  Menu() {
    inGame = false;
    fondo = loadImage("");
    startButton = new Button("Iniciar", 1280/2, 800/2 - 30, 120*2, 40*2);
    exitButton = new Button("Salir", 1280/2, 800/2 + 60, 120*2, 40*2);
    startButton.FillButton(#29E101);
    startButton.FillText(0);
    
    exitButton.FillButton(#E0DF00);
    exitButton.FillText(0);
  }

  void display() {
    if (!inGame) {
      background(250);
      textFont(createFont("Arial", 24));
      textAlign(CENTER, CENTER);
      startButton.display();
      exitButton.display();
    } /*else {
      background(0);
      fill(255);
      textSize(24);
      text("¡Juego en progreso!", width/2, height/2);
    }*/
  }

  void handleMouseClick() {
    if (startButton.isMouseOver()) {
      inGame = true;
    } else if (exitButton.isMouseOver()) {
      exit();
    }
  }
}

class Button {
  String label;
  float x, y, w, h;
  int rgbT,rgbB;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    rgbT = 255;
    rgbB = 100;
  }

  void display() {
    fill(rgbB);
    rectMode(CENTER);
    rect(x, y, w, h, 10);
    fill(rgbT);
    textSize(18);
    text(label, x, y);
  }
  
  void FillText(int rgb){
    rgbT = rgb;
  }
  
  void FillButton(int rgb){
    rgbB = rgb;
  }

  boolean isMouseOver() {
    return (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2);
  }
}
