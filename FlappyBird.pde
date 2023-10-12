
class Transform {
  float x, y;
  float scaleX, scaleY;
  float radio;

  Transform() {
    this(0, 0, 1, 1, 0); // Llama al constructor con argumentos con valores predeterminados
  }

  Transform(float x, float y) {
    this(x, y, 1, 1, 0); // Llama al constructor con argumentos con x, y y valores predeterminados para scaleX, scaleY y radio
  }

  Transform(float x, float y, float scaleX, float scaleY, float radio) {
    this.x = x;
    this.y = y;
    this.scaleX = scaleX;
    this.scaleY = scaleY;
    this.radio = radio;
  }
}



class RigidBody {
  float gravity;
  float mass;
  float force;
  float velocity;
  float position;

  RigidBody() {
    gravity = 9.8;
    mass = 1;
    force = mass * gravity;
    velocity = 0;
    position = 0;
  }

  void applyForce(float f) {
    force = f;
  }

  void update() {
    float acceleration = force / mass;
    velocity += acceleration;
    position += velocity;
  }
}


class Bird extends Transform {
  RigidBody rb;
  int score;
  int colorBird;
  float salto = -10;  
  boolean saltando = false, vivo = true;

  Bird(float rad) {
    super(100, height / 2);
    rb = new RigidBody();
    radio = rad;
    rb.gravity = 0;
    colorBird = #FF0000;
  }

  void BirdDraw() {
    fill(colorBird);
    circle(x, y, radio);
    //print(" << "+y+" >>");
  }

  void PControl() {
    if (saltando) {
      rb.gravity = salto; // Establece la velocidad vertical en lugar de aplicar una fuerza
      saltando = false;
    }
    rb.gravity += 0.5; // Gravedad
    y += rb.gravity;
  }

  void Golpe(Transform otro) {
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

  void Golpe() {
    if (y >= height || y <= 0) {
      vivo = false;
      //print("  Valio :c  ");
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


Bird player = new Bird(50);
//Tube tubo = new Tube(1280,800/2,0,100,10);

ArrayList<Tube> tubos;
float tuboWidth = 100;
float tuboSpeed = 5;
int distanciaEntreTubos = 200; // Distancia entre tubos en píxeles

void setup() {
  size(1280, 800);
  frameRate(60);
  player = new Bird(50);
  tubos = new ArrayList<Tube>();
  tubos.add(new Tube(width, random(100, height - distanciaEntreTubos - 100), random(100, 300), tuboWidth, tuboSpeed));
}

void draw() {
  background(250);
  player.BirdDraw();
  player.PControl();
  player.Golpe();

  for (int i = tubos.size() - 1; i >= 0; i--) {
    Tube tubo = tubos.get(i);
    tubo.Draw();
    tubo.Update();
    if (tubo.IsOffScreen()) {
      tubos.remove(i);
    }
  }

  if (frameCount % 120 == 0) { // Agrega un nuevo tubo cada 2 segundos (60 fotogramas por segundo)
    float topHeight = random(100, height - distanciaEntreTubos - 100);
    float bottomHeight = random(100, 300);
    tubos.add(new Tube(width, topHeight, bottomHeight, tuboWidth, tuboSpeed));
  }
}

// Evento para el jugador
void keyPressed() {
  if (key == ' ') {
    player.saltando = true;
  }
}
