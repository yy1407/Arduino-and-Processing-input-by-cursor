// 文字列を表示
void displayText() {

  //文章を描画（改行を考慮）
  String[] lines = splitByLength(inputString, maxCharsPerLine);  // 文字列を分割

  for (int i = 0; i < lines.length; i++) {
    text(lines[i], 10, 10 + i * 40);  // 各行を表示（行ごとに40ピクセル下に表示）
  }

  // カーソルの描画を関数で行う
  drawCursor(lines, 10, 10, 40);  // 10, 10 はテキスト開始座標、40 は行間の高さ
}
