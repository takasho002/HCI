//ステアリングの法則

PrintWriter file; 
float startTime = 0;
float endTime = 0;
int linesLength []={
  200,300, 400, 500,600,700, 800,
};
int roadWidth[] = {
  10, 20, 30, 40, 50, 60,70,80,90,100
};


int currentNum = 0;

Scene scenes[] = new Scene[linesLength.length * roadWidth.length];



void setup() {
  size(1000, 500);
  //配列シャッフル
  //ファイル保存
  file = createWriter("steering.csv");

  //sceneの初期化
  for (int x = 0; x < linesLength.length; x ++) {
    for (int y = 0; y < roadWidth.length; y ++) {
      scenes[y + roadWidth.length*x] =new Scene(linesLength[x], roadWidth[y]);
    }
  }
  scenes = shuffle(scenes);
}


void draw() {
  background(255);
  scenes[currentNum].display();
  //scenes[currentNum].move();//動きを入れない場合はコメントアウト
  scenes[currentNum].edge();
}




void mousePressed() {
  if (dist((width-scenes[currentNum].x)/2 , height/2, mouseX, mouseY) < scenes[currentNum].r) {
    //左側の円をクリックでタイマースタート、円に色を付けてクリックしたことを視覚的にとらえやすくした
    startTime = millis();
   scenes[currentNum].newValue();
   scenes[currentNum].edge();
  }
  if (dist((width+scenes[currentNum].x )/2 +scenes[currentNum].speadx, (height/2) + scenes[currentNum].speady, mouseX, mouseY) <= scenes[currentNum].r) {
    //右側の円をクリックでタイマーストップ、記録、次のページへ
    endTime = millis();
    file.print(currentNum+1 + ",");
    file.print(scenes[currentNum].x + ",");
    file.print(scenes[currentNum].y+ ",");
    file.println(endTime -startTime);
    scenes[currentNum].startflag = false;
    if(currentNum < scenes.length-1)currentNum ++;
    else {
      file.flush();
      file.close();
      exit();
    }
  }
}



//
Scene []shuffle(Scene base_arr[]) {
  Scene[] rand_arr = new Scene[base_arr.length];
  Scene[] temp_arr;
  int num = 0;

  for (int i = 0; i < rand_arr.length; i++) {

    //要素1個の仮配列を作成
    temp_arr = new Scene[1];
    //ベース配列のサイズから乱数を作成
    num = int (random (base_arr.length));
    temp_arr[0] = base_arr[num];
    rand_arr[i] = temp_arr[0];
    temp_arr = new Scene[base_arr.length - 1];
    int count = 0;
    for (int j = 0; j < base_arr.length; j++) {
      if (j != num) {
        temp_arr[count] = base_arr[j];
        count += 1;
      }
    }
    base_arr = temp_arr;
  }
  return rand_arr;
}
