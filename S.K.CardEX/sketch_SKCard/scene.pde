class Scene {
  int _delayTime;
  float _passedTime;
  float _r;
  boolean _startflag = true;
  Scene(int time) {
    _delayTime = time;
    _r = 100;
  }
  
  boolean flag(){
   return _startflag = !_startflag;
  }

  //シーンを表示する関数
  void display() {    
    fill(255, 0, 0);
    ellipse(width/2, height/2, _r, _r);
    _passedTime = millis();
    _startflag = false;
  }
}
