// カーソルの座標と描画処理用の関数
void drawCursor(String[] lines, int textX, int textY, int lineHeight) {
  // カーソルの座標を計算
  int cursorX, cursorY;

  if (lines.length > 0) {
    cursorX = int(textWidth(lines[lines.length - 1]) + textX);  // 最後の行の末尾にカーソル
    cursorY = textY + (lines.length - 1) * lineHeight;  // 最後の行のY座標を計算
  } else {
    cursorX = textX;  // 文字列がないときは左端
    cursorY = textY;  // Y座標も最初の行の位置に設定
  }

  // カーソルの点滅処理
  if (millis() - lastCursorBlinkTime > cursorBlinkInterval) {
    showCursor = !showCursor;
    lastCursorBlinkTime = millis();
  }

  // カーソルの描画
  if (showCursor) {
    stroke(0);  // カーソルの色
    line(cursorX, cursorY, cursorX, cursorY + 32);  // カーソルを縦棒として描画
  }
}
