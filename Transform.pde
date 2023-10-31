class Transform extends RigidBody{
  float x, y;
  float scaleX, scaleY;
  float radio;
  
  // Parametros especiales para los tubos
  float topHeight = 0, bottomHeight = 0;

  Transform() {
    this(0, 0, 0, 0, 0); // Llama al constructor con argumentos con valores predeterminados
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
