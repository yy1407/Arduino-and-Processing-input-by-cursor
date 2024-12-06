import processing.serial.*;

PFont font;

Serial myPort; // Arduinoとの通信

int cursorX = 0; // カーソルのX位置（列）
int cursorY = 0; // カーソルのY位置（行）

// 入力文字表示用
String inputString = "";  // 現在入力されている文章
int maxCharsPerLine = 45;  // 1行あたりの最大文字数(改行する文字数)

// カーソルの点滅用
boolean showCursor = true;
int lastCursorBlinkTime = 0;
int cursorBlinkInterval = 500;  // カーソルの点滅間隔(ミリ秒)

// 五十音表データ
String[][] kanaTable = {
  {"あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ"},
  {"い", "き", "し", "ち", "に", "ひ", "み", "　", "り", "　"},
  {"う", "く", "す", "つ", "ぬ", "ふ", "む", "ゆ", "る", "を"},
  {"え", "け", "せ", "て", "ね", "へ", "め", "　", "れ", "　"},
  {"お", "こ", "そ", "と", "の", "ほ", "も", "よ", "ろ", "ん"}
};

// レイアウト設定用変数
int tableXOffset = 1100; // 五十音表のX方向の開始位置
int tableYOffset = 400;  // 五十音表のY方向の開始位置
int cellWidth = 80;      // 各文字セルの幅
int cellHeight = 80;     // 各文字セルの高さ
int fontSize = 32;       // 文字サイズ

String selectedText = ""; // 入力された文字列

void setup() {
  size(1500, 800); // 画面サイズ

  // 日本語フォントを設定
  font = createFont("Meiryo", fontSize, true);
  textFont(font);

  myPort = new Serial(this, "COM3", 9600); // Arduinoのポート設定
  myPort.bufferUntil('\n'); // 改行まで受信
}

void draw() {
  background(255); // 背景色を白
  fill(0);
  textSize(fontSize);
  textAlign(CENTER, CENTER);

  // 五十音表を右から左に縦書きで描画
  for (int col = 0; col < kanaTable[0].length; col++) { // 列（横方向）
    for (int row = 0; row < kanaTable.length; row++) { // 行（縦方向）
      int x = tableXOffset - col * cellWidth; // 右端から左に移動
      int y = tableYOffset + row * cellHeight;

      // カーソル位置の背景を強調
      if (cursorX == col && cursorY == row) {
        fill(0, 0, 0); // 背景を黒
        rect(x - cellWidth / 2, y - cellHeight / 2, cellWidth, cellHeight); // 四角形を描画
        fill(255); // 文字色を白に
      } else {
        fill(0); // 通常の文字色
      }

      // 文字を描画
      if (kanaTable[row][col] != null && !kanaTable[row][col].equals("　")) {
        text(kanaTable[row][col], x, y);
      }
    }
  }

  textSize(32);  // 日本語文字が見やすいようにサイズを設定
  fill(0);
  textAlign(LEFT, TOP);  // 文章を左上から表示
  
  displayText();
}
