
class UI extends Transform{
  int vida;
  int score;
  int textX,textY;
  
  UI(){
    textX = (int)x;
    textY = (int)y;
  }
  
  
  void UI_Vida(){
    
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
