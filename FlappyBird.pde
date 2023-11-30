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

PImage fondo, bg_game, cloud, bird;

float topHeight = random(100, 800 - distanciaEntreTubos - 100);
float bottomHeight = random(100, 300);

void setup() {
  size(1280, 800);
  fondo = loadImage("background.png");
  bg_game = loadImage("bg_game.jpg");
  cloud = loadImage("cloud.png");
  bird = loadImage("bird.png");
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
    interfaz.SetScore(score); // Actualiza el score en la interfaz
    interfaz.UI_Score();
    
    fill(colorBird);
    circle(x, y, radio);
    //print(" << "+y+" >>");
    image(bird, x-50, y-50, radio+70, radio+35);  // Dibuja la imagen en la posición del pájaro
    
    println("Score: "+score);
  }

  void PControl() {
    if (saltando) {
      score++; // Incrementa el score cada vez que el pájaro salta
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
  void GolpeMuro(Tube tubo){
    // Calcula los bordes del objeto
    float left = x;
    float right = x + radio*2;
    float top = y;
    float bottom = y + radio*2;
  
    // Calcula los bordes del muro superior
    float wallLeftTop = tubo.x;
    float wallRightTop = tubo.x + tubo.scaleX;
    float wallTopTop = tubo.y;
    float wallBottomTop = tubo.topHeight;
  
    // Calcula los bordes del muro inferior
    float wallLeftBottom = tubo.x;
    float wallRightBottom = tubo.x + tubo.scaleX;
    float wallTopBottom = 800 - tubo.bottomHeight;
    float wallBottomBottom = 800;
  
    // Verifica la colisión con el muro de arriba
    if (right > wallLeftTop && left < wallRightTop && bottom > wallTopTop && top < wallBottomTop) {
      // Colisión detectada
      if(vivo){
        vidas--;
      }
    }
  
    // Verifica la colisión con el muro inferior
    if (right > wallLeftBottom && left < wallRightBottom && bottom > wallTopBottom && top < wallBottomBottom) {
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
