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
  int vidas;
  float salto = -8;  
  boolean saltando = false, vivo = true;

  Bird(float rad) {
    super(100, 800 / 2);
    //rb = new RigidBody();
    radio = rad;
    gravity = 0;
    colorBird = #FF0000;
    vidas = 3;
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
  
  
  int aaah = 0;
  
  // Colision entre el pajaro y el muro
  void GolpeMuro(Transform wall){
    // Calcula los bordes del objeto
    float left = x;
    float right = x + radio/2;
    float top = y;
    float bottom = y + radio/2;
  
    float[] wallLeft = new float[2];
    float[] wallRight = new float[2];
    float[] wallTop = new float[2];
    float[] wallBottom = new float[2];
    
    // Calcula los bordes del muro
    wallLeft[0] = wall.x;
    wallRight[0] = wall.x + wall.scaleX;
    wallTop[0] = wall.y;
    wallBottom[0] = wall.y + wall.topHeight;
  
    // Verifica la colisión con el muro de arriba
    if (right > wallLeft[0] && left < wallRight[0] && bottom > wallTop[0] && top < wallBottom[0]) {
      // Colisión detectada
      
      vidas--;
      println("Vidas: "+vidas);
      
      // Provisional
      if(vidas <= 0){
        println(aaah+"Ahhhhh");
        aaah++;
      }
      
    }
  }
}


class Tube extends Transform{

  Tube(float x, float topHeight, float bottomHeight, float _width, float speed) {
    this.x = x;
    y = 0;
    this.topHeight = topHeight;
    this.bottomHeight = bottomHeight;
    scaleX = _width;
    velocity = speed;
  }

  void Draw() {
    fill(0, 255, 0); // Color verde para los tubos
    rect(x, y, scaleX, topHeight); // Tubo superior
    rect(x, 800 - bottomHeight, scaleX, bottomHeight); // Tubo inferior
  }

  void Update() {
    x -= velocity;
  }

  boolean IsOffScreen() {
    return x + scaleX < 0;
  }  
}
