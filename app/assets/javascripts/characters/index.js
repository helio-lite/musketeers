// onclick 検索フィールドクリアボタン
function KeywordClearButton(){
  this.keyword.value="";
  this.keyword.focus(); // クリアボタン押下でフォーカス
  target = document.getElementById("search-field-clear");
  target.style.visibility = "hidden"; // キーワードクリアでクリアボタンも非表示にする
}

// onkeydown 入力時のみクリアボタン表示
function SearchFieldKeyDown(){
  if (this.keyword.value.length > 0){
    target = document.getElementById("search-field-clear");
    target.style.visibility = "visible";
  }
}

// Search後入力フィールドクリックでクリアボタン表示
function KeywordClearDisplay(){
  if (this.keyword.value.length > 0){
    target = document.getElementById("search-field-clear");
    target.style.visibility = "visible";
  }
}
