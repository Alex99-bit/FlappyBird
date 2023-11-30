class Menu {
  Button startButton, exitButton;
  boolean inGame;

  Menu() {
    inGame = false;
    startButton = new Button("Iniciar", 1280/2, 800/2 - (30/6), 120*3, 40*3);
    exitButton = new Button("Salir", 1280/2, 800/2 + (30*6), 120*2, 40*2);
    
    startButton.FillButton(#29E101);
    startButton.FillText(255);
    startButton.SetTextSize(70);
    
    exitButton.FillButton(#E0DF00);
    exitButton.FillText(255);
    exitButton.SetTextSize(50);
  } 

  void display() {
    if (!inGame) {
      background(fondo);
      textFont(createFont("Arial", 24));
      textAlign(CENTER, CENTER);
      startButton.display();
      exitButton.display();
      interfaz.UI_Score();
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
  int rgbT,rgbB,textSize;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    rgbT = 255;
    rgbB = 100;
    textSize = 18;
  }

  void display() {
    fill(rgbB);
    rectMode(CENTER);
    rect(x, y, w, h, 50);
    fill(rgbT);
    textSize(textSize);
    text(label, x, y);
  }
  
  void FillText(int rgb){
    rgbT = rgb;
  }
  
  void FillButton(int rgb){
    rgbB = rgb;
  }

  void SetTextSize(int size){
    textSize = size;
  }
  
  void SetNewLabel(String newLabel){
    label = newLabel;
  }
  
  boolean isMouseOver() {
    return (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2);
  }
}
