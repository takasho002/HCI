class Scene {
  int x;//位置
  int y;
  float speadx;//移動距離
  float speady;
  float vx;//速度
  float vy;
  float dx;//横移動方向(dx = 0 or 1)
  float dy;//縦移動方向(dy = 0 or 1)
  float r;
  boolean startflag = false;
  Scene(int widthNum, int heightNum) {
    x = widthNum;
    y = heightNum;
    r = y/2;
    vx = 0;
    vy = 0;
  }
  void newValue() {
    startflag = true;
    vx = random(0, 100)/100;
    vy = random(0, 100)/100;
    dx = int(random(2))*2-1;
    dy = int(random(2))*2-1;
  }
  //シーンを表示する関数
  void display() {
    if (startflag) fill(255, 0, 0);
    else fill(255);
    ellipse((width-x)/2  + speadx, (height/2) + speady, 2 * r, 2 * r);
    ellipse((width+x)/2 + speadx, (height/2) + speady, 2 * r, 2 * r);
    line((width-x)/2+ speadx, (height-y)/2+ speady, (width+x)/2+ speadx, (height-y)/2+ speady);
    line((width-x)/2+ speadx, (height+y)/2+ speady, (width+x)/2+ speadx, (height+y)/2+ speady);
  }
  void move() {
    speadx = speadx + vx * dx;
    speady = speady + vy * dy;
  }
  void edge(){
    if(((width-x)/2) -2* r + speadx<= 0 ||((width+x)/2)+ speadx + 2 * r >= width) dx = dx * (-1);
    if(((height-y)/2)+ speady <=  0 || ((height+y)/2)+ speady >= height) dy = dy *(-1);
  }
}
