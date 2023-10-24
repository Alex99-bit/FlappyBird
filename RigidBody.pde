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
