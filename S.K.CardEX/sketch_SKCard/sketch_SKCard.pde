//sketch_S.K.Card

PrintWriter file; 
int exCount = 1;//実験する回数
int exTime []= {
  1,2,3
  ,4, 5 
};
int currentNum = 0;
Scene scenes[] = new Scene[exTime.length * exCount ];

float startTime;
int countdown;
int start;
void setup() {
  size(1000, 500);
  //配列シャッフル
  //ファイル保存
  file = createWriter("SKCards.csv");

  //sceneの初期化
  for (int i = 0; i < exCount; i ++) {
    for (int x = 0; x < exTime.length; x ++) {
      scenes[i * exTime.length + x] =  new Scene(exTime[x]);
    }
  }
  scenes = shuffle(scenes);
  //countdown
  background(255);
  startTime = millis();
  countdown = 3;
  start = countdown;
  count[start] = millis();
}
float count[] = {
  1, 2, 3, 4
};

void draw() {
  if (scenes[currentNum]._startflag) {
    if (countdown >=0)count[countdown] = millis();
    if (countdown == start) {
      background(255);
      fill(0);
      textSize(15);
      text(countdown, width/2, height/2);
      count[countdown] = millis();
      countdown --;
    } else if (countdown > 0) {
      if (count[countdown + 1 ] - count[countdown] < -1000) {
        background(255);
        fill(0);
        textSize(15);
        text(countdown, width/2, height/2);
        countdown --;
      }
    } else if (countdown == 0 && count[countdown + 1 ] - count[countdown] < -1000) {
      background(0);
      scenes[currentNum].flag();

      count[countdown] = millis();
    }
  }
  if (!scenes[currentNum]._startflag) {
    println( millis() + "-" + count[countdown] + "=" + (millis() - count[countdown]));
    if (millis() - count[countdown]> 1000 * scenes[currentNum]._delayTime) {
      scenes[currentNum].display();
    }
  }
}




void mousePressed() { 
  if (dist(width/2, (height/2), mouseX, mouseY) <= scenes[currentNum]._r && !scenes[currentNum]._startflag) {
    //表示された円をクリックでタイマーストップ、記録
    float passedTime = millis() - count[countdown] -1000 * scenes[currentNum]._delayTime;
    file.print(currentNum+1 + ",");
    file.print(scenes[currentNum]._delayTime + ",");
    file.println(passedTime);
    scenes[currentNum].flag();
    for (int i = 0; i < count . length; i ++) {
      count[i] = 0;
    }
    countdown = start;
    background(255);
    if (currentNum < scenes.length-1)currentNum ++;
    else {
      file.flush();
      file.close();
      exit();
    }
  }
  //count down開始
}



//配列シャッフル
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
