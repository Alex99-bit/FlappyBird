
class UI extends Transform{
  int vida;
  int score;
  // Cords para los txt que se muestran
  int vidaX,vidaY,scoreX,scoreY;
  
  UI(){
    x = 0;
    y = 0;
    
    vidaX = (int)x +100;
    vidaY = (int)y +50;
    
    scoreX = (int)x +100;
    scoreY = (int)y +100;
  }
  
  
  void UI_Vida(){
    textSize(40);
    fill(250);
    text("Vida: "+vida+"%",vidaX,vidaY);
  }
  
  void UI_Score(){
    textSize(40);
    fill(250);
    text("Score: "+score,scoreX,scoreY);
  }
  
  void SetX(int x){
    this.x = x;
  }
  
  void SetY(int y){
    this.y = y;
  }
  
  void Vector2(int x,int y){
    this.x = x;
    this.y = y;
  }
  
  int GetX(){
    return (int)x;
  }
  
  int GetY(){
    return (int)y;
  }
  
  void SetVida(int vida){
    this.vida = vida;
  }
  
  int GetVida(){
    return vida;
  }
  
  void SetScore(int score){
    this.score = score;
  }
  
  int GetScore(){
    return score;
  }
}
