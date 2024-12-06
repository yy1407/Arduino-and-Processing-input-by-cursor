void serialEvent(Serial myPort) {
  String inData = trim(myPort.readStringUntil('\n')); // 改行まで読み込み
  int num = int(inData); // 受け取ったデータを数値に変換

  // ジョイスティックのX軸・Y軸からカーソル位置を更新
  if (num == 4) { // 右へ
    cursorX = max(cursorX - 1, 0);
    println("→")  ;
  }
  if (num == 2) { // 左へ
    cursorX = min(cursorX + 1, 9);
    println("←");
  }
  if (num == 5) { // 下へ
    cursorY = min(cursorY + 1, 4);
    println("↓");
  }
  if (num == 3) { // 上へ
    cursorY = max(cursorY - 1, 0);
    println("↑");
  }
  // センタースイッチが押されたら文字を追加
  if (num == 1) {
    inputString += kanaTable[cursorY][cursorX];
    println("click");
  }
}
