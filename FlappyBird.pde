/*
  
  Este es el codigo main para el juego flappy bird

*/


Menu menu = new Menu();

Bird player = new Bird(50);
//Tube tubo = new Tube(1280,800/2,0,100,10);

ArrayList<Tube> tubos;
float tuboWidth = 100;
float tuboSpeed = 5;
int distanciaEntreTubos = 200; // Distancia entre tubos en píxeles

PImage fondo;

void setup() {
  size(1280, 800);
  fondo = loadImage("background.png");
  frameRate(60);
  tubos = new ArrayList<Tube>();
  tubos.add(new Tube(width, random(100, height - distanciaEntreTubos - 100), random(100, 300), tuboWidth, tuboSpeed));
}

void draw() {
  background(250);
  if(menu.inGame){
    player.BirdDraw();
    player.PControl();
    player.GolpeLimits();
  
    for (int i = tubos.size() - 1; i >= 0; i--) {
      Tube tubo = tubos.get(i);
      tubo.Draw();
      tubo.Update();
      if (tubo.IsOffScreen()) {
        tubos.remove(i);
      }
      
      // Metodo para determinar la colision con los tubos
      player.GolpeMuro(tubo);
    }
  
    if (frameCount % 120 == 0) { // Agrega un nuevo tubo cada 2 segundos (60 fotogramas por segundo)
      float topHeight = random(100, height - distanciaEntreTubos - 100);
      float bottomHeight = random(100, 300);
      tubos.add(new Tube(width, topHeight, bottomHeight, tuboWidth, tuboSpeed));
    }
    
    if(!player.vivo){
      menu.inGame = false;
      player.y = height/4;
      player.vivo = true;
    }
  }else{
    menu.display();
  }
  
}

// Evento para el jugador
void keyPressed() {
  if (key == ' ') {
    player.saltando = true;
  }
}

void mousePressed() {
  if (!menu.inGame) {
    menu.handleMouseClick();
  }
}


class Bird extends Transform {
  int score;
  int colorBird;
  float salto = -8;  
  boolean saltando = false, vivo = true;

  Bird(float rad) {
    super(100, 800 / 2);
    //rb = new RigidBody();
    radio = rad;
    gravity = 0;
    colorBird = #FF0000;
  }

  void BirdDraw() {
    fill(colorBird);
    circle(x, y, radio);
    //print(" << "+y+" >>");
  }

  void PControl() {
    if (saltando) {
      gravity = salto; // Establece la velocidad vertical en lugar de aplicar una fuerza
      saltando = false;
    }
    gravity += 0.3; // Gravedad
    y += gravity;
  }

  void GolpeBalls(Transform otro) {
    float deltaX, deltaY, cuadrado, raiz;
    deltaX = x - otro.x;
    deltaY = y - otro.y;
    cuadrado = (deltaX * deltaX) + (deltaY * deltaY);
    raiz = sqrt(cuadrado);

    // Verifica si está chocando con el otro objeto
    if (raiz < (radio + otro.radio)) {
      vivo = false;
    }
  }

  void GolpeLimits() {
    if (y >= height || y <= 0) {
      vivo = false;
      //print("  Valio :c  ");
    }
  }
  
  // Colision entre el pajaro y el muro
  void GolpeMuro(Transform wall){
    // Calcula los bordes del objeto
    float left = x;
    float right = x + radio/2;
    float top = y;
    float bottom = y + radio/2;
  
    // Calcula los bordes del muro
    float wallLeft = wall.x;
    float wallRight = wall.x + wall.scaleX;
    float wallTop = wall.y;
    float wallBottom = wall.y + wall.scaleY;
  
    // Verifica la colisión
    if (right > wallLeft && left < wallRight && bottom > wallTop && top < wallBottom) {
      // Colisión detectada
      vivo = false;
    }
  }
}


class Tube extends Transform{
  float x, topHeight, bottomHeight, _width;
  float speed;

  Tube(float x, float topHeight, float bottomHeight, float _width, float speed) {
    this.x = x;
    this.topHeight = topHeight;
    this.bottomHeight = bottomHeight;
    this._width = _width;
    this.speed = speed;
  }

  void Draw() {
    fill(0, 255, 0); // Color verde para los tubos
    rect(x, 0, _width, topHeight); // Tubo superior
    rect(x, height - bottomHeight, _width, bottomHeight); // Tubo inferior
  }

  void Update() {
    x -= speed;
  }

  boolean IsOffScreen() {
    return x + _width < 0;
  }  
}
