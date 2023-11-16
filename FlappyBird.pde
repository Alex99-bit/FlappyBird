/*
  
  Este es el codigo main para el juego flappy bird

*/
Menu menu = new Menu();

Bird player = new Bird(50);
//Tube tubo = new Tube(1280,800/2,0,100,10);

ArrayList<Tube> tubos;
float tuboWidth = 100;
float tuboSpeed = 10;
int distanciaEntreTubos = 70; // Distancia entre tubos en píxeles

PImage fondo, bg_game, cloud;

float topHeight = random(100, 800 - distanciaEntreTubos - 100);
float bottomHeight = random(100, 300);

void setup() {
  size(1280, 800);
  fondo = loadImage("background.png");
  bg_game = loadImage("bg_game.jpg");
  cloud = loadImage("cloud.png");
  frameRate(60);
  tubos = new ArrayList<Tube>();
  tubos.add(new Tube(1280, topHeight, bottomHeight, tuboWidth, tuboSpeed));
}

void draw() {
  background(250);
  frameRate(60);
  if(menu.inGame){
    
    // Se muestra un fondo 
    image(bg_game, -50, -50);
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
  
    if (frameCount % (60*1) == 0) { // Agrega un nuevo tubo cada 2 segundos (60 fotogramas por segundo)
      topHeight = random(100, 800 - distanciaEntreTubos - 100);
      bottomHeight = random(100, 300);
      tubos.add(new Tube(1280, topHeight, bottomHeight, tuboWidth, tuboSpeed));
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
  
  UI interfaz = new UI(); 

  Bird(float rad) {
    super(100, 800 / 2);
    //rb = new RigidBody();
    radio = rad;
    gravity = 0;
    colorBird = #FF0000;
    vidas = 100;
  }

  void BirdDraw() {
    // Aqui se actualiza la vida y se muestra la interfaz
    interfaz.SetVida(vidas);
    interfaz.UI_Vida();
    interfaz.UI_Score();
    
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
    top *= 2;
    float bottom = y + radio/2;
  
    float[] wallLeft = new float[2];
    float[] wallRight = new float[2];
    float[] wallTop = new float[2];
    float[] wallBottom = new float[2];
    
    // Calcula los bordes del muro superior
    wallLeft[0] = wall.x;
    wallRight[0] = wall.x + wall.scaleX;
    wallTop[0] = wall.y;
    wallBottom[0] = wallTop[0] + wall.topHeight;
    
    // Calcula los bordes del muro inferior
    wallLeft[1] = wall.x;
    wallRight[1] = wall.x + wall.scaleX;
    wallTop[1] = 800 - wall.bottomHeight;
    wallBottom[1] = wall.bottomHeight;
  
    // Verifica la colisión con el muro de arriba
    if (right > wallLeft[0] && left < wallRight[0] && bottom > wallTop[0] && top < wallBottom[0]) {
      // Colisión detectada
      
      if(vivo){
        vidas--;
      }
    }
    
    // Verifica la colisión con el muro inferior
    if (right > wallLeft[1] && left < wallRight[1] && bottom > wallTop[1] && top < wallBottom[1]) {
      // Colisión detectada
      
      if(vivo){
        vidas--;
      }
    }
    
    println("Vidas: "+vidas);
    
    // Provisional
    if(vidas <= 0){
      vivo = false;
      vidas = 100;
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
