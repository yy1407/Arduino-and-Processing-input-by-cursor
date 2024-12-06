// 文字を追加する関数
void addCharacter(String character) {
  inputString += character;
}

// 指定された文字数で文字列を分割して配列を返す関数
String[] splitByLength(String input, int length) {
  int numLines = ceil(float(input.length()) / length);  // 必要な行数を計算
  String[] result = new String[numLines];

  for (int i = 0; i < numLines; i++) {
    int start = i * length;
    int end = min(start + length, input.length());
    result[i] = input.substring(start, end);  // 指定した長さで分割
  }

  return result;
}
