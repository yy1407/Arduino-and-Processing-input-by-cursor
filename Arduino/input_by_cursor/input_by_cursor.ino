// ジョイスティックのピン設定
const int rightXPin = A2, rightYPin = A3, rightSwPin = 3;

const int CENTER_MIN = 450, CENTER_MAX = 550;  // 中央付近の範囲

const int notClick = -1;  // 初期状態を表す値

int result;               // 入力結果を格納する変数
bool hasPrinted = false;  // 数字が表示されたかのフラグ

unsigned long lastDebounceTime = 0; // デバウンス処理のためのタイムスタンプ
const unsigned long debounceDelay = 150; // デバウンス処理の遅延（ミリ秒）

void setup() {
  Serial.begin(9600);  // Processingと通信するためにシリアル通信を開始
  pinMode(rightSwPin, INPUT_PULLUP);
}

void loop() {
  // 右ジョイスティックの値を読み取る
  int rightXValue = analogRead(rightXPin);
  int rightYValue = analogRead(rightYPin);
  int rightSwState = digitalRead(rightSwPin);

  // 入力結果に基づいて結果を取得
  result = numberReturn(rightXValue, rightYValue, rightSwState);

  // 現在の時間を取得
  unsigned long currentTime = millis();

  // スイッチが押された場合（デバウンスを考慮）
  if (result == 1 && !hasPrinted) {
    if (currentTime - lastDebounceTime > debounceDelay) {
      Serial.println(result);
      hasPrinted = true;
      lastDebounceTime = currentTime; // デバウンス用タイムスタンプを更新
    }
  }

  // スイッチが押されていない場合、フラグをリセット
  if (result == notClick) {
    hasPrinted = false;
  }

  // 他の入力処理（2～5の範囲）
  if (2 <= result && result <= 5) {
    if (currentTime - lastDebounceTime > debounceDelay) {
      Serial.println(result);
      lastDebounceTime = currentTime; // デバウンス用タイムスタンプを更新
    }
  }
}

// 中央判定
bool isCenter(int x, int y, int sw) {
  return ((CENTER_MIN <= x && x <= CENTER_MAX) && (CENTER_MIN <= y && y <= CENTER_MAX) && (sw == HIGH));
}

// スイッチ押下判定
bool isPressed(int x, int y, int sw) {
  return (CENTER_MIN <= x && x <= CENTER_MAX && CENTER_MIN <= y && y <= CENTER_MAX && sw == LOW);
}

// ジョイスティックの方向判定と数値取得
int numberReturn(int rX, int rY, int rS) {
  // 右ジョイスティックの各方向の条件
  bool rO = isCenter(rX, rY, rS);                                                     // 初期状態
  bool rC = isPressed(rX, rY, rS);                                                    // スイッチ押下
  bool ru = ((0 <= rX && rX <= 100) && (450 <= rY && rY <= 550) && (rS == HIGH));     // 上
  bool rl = ((450 <= rX && rX <= 550) && (923 <= rY && rY <= 1023) && (rS == HIGH));  // 左
  bool rr = ((450 <= rX && rX <= 550) && (0 <= rY && rY <= 100) && (rS == HIGH));     // 右
  bool rd = ((923 <= rX && rX <= 1023) && (450 <= rY && rY <= 550) && (rS == HIGH));  // 下

  // 条件判定
  if (rC) return 1;
  if (rl) return 2;
  if (ru) return 3;
  if (rr) return 4;
  if (rd) return 5;
  if (!rC) return notClick;
}
