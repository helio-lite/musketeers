// ここから入力値クリア
  function InputClear(ele1, ele2){
    // 引数が1つだけの場合
    if (!ele2){
      // 変数展開したいので``で囲む
      clearTargetId = document.getElementById(`character_${ele1}`);
      targetButton = document.getElementById(`${ele1}-clear`);
    } else if (ele1 == 0 || ele1 == 1) {
    // 自己紹介・趣味・好きなもの用
      clearTargetId = document.getElementById(`character_information_attributes_${ele1}_${ele2}`);
      targetButton = document.getElementById(`${ele2}-${ele1}-clear`);
    } else {
      clearTargetId = document.getElementById(`character_${ele1}_${ele2}`);
      targetButton = document.getElementById(`${ele1}-${ele2}-clear`);
    }
    this.clearTargetId.value="";
    this.clearTargetId.focus(); // クリアボタン押下でフォーカス
    this.clearTargetId.style.width = "170px"; // クリアボタン押下時に幅を元のサイズに戻す
    targetButton.style.visibility = "hidden"; // 内容クリアでクリアボタンも非表示にする
  }
  // 入力時のみクリアボタン表示
  function KeyDown(ele1, ele2){
    if (!ele2) {
      clearTargetId = document.getElementById(`character_${ele1}`);
      targetButton = document.getElementById(`${ele1}-clear`);
    } else if (ele1 == 0 || ele1 == 1) {
    // 自己紹介・趣味・好きなもの用
      clearTargetId = document.getElementById(`character_information_attributes_${ele1}_${ele2}`);
      targetButton = document.getElementById(`${ele2}-${ele1}-clear`);
    } else {
      clearTargetId = document.getElementById(`character_${ele1}_${ele2}`);
      targetButton = document.getElementById(`${ele1}-${ele2}-clear`);
    }
    if (this.clearTargetId.value.length > 0) {
      targetButton.style.visibility = "visible";
    }
  }
// ここまで入力値クリア

// ここからフィールドクリック時に入力値ありならクリアボタン表示
  function ClearButtonDisplay(ele1, ele2){
    // 引数が1つだけの場合
    if (!ele2){
      clearTargetId = document.getElementById(`character_${ele1}`);
      if (this.clearTargetId.value.length > 0){
        targetButton = document.getElementById(`${ele1}-clear`);
        targetButton.style.visibility = "visible";
      }
    } else if (ele1 == 0 || ele1 == 1) {
      clearTargetId = document.getElementById(`character_information_attributes_${ele1}_${ele2}`);
      if (this.clearTargetId.value.length > 0){
        targetButton = document.getElementById(`${ele2}-${ele1}-clear`);
        targetButton.style.visibility = "visible";
      }
    } else {
      clearTargetId = document.getElementById(`character_${ele1}_${ele2}`);
      if (this.clearTargetId.value.length > 0){
        targetButton = document.getElementById(`${ele1}-${ele2}-clear`);
        targetButton.style.visibility = "visible";
      }
    }
  }
// ここまでフィールドクリック時に入力値ありならクリアボタン表示

// ここからコピーペースト検知でクリアボタン表示
  function PasteCheck(ele1, ele2){
    if (!ele2){
      pasteTarget = document.getElementById(`character_${ele1}`);
      clearButton = document.getElementById(`${ele1}-clear`);
    } else if (ele1 == 0 || ele1 == 1) {
      pasteTarget = document.getElementById(`character_information_attributes_${ele1}_${ele2}`);
      clearButton = document.getElementById(`${ele2}-${ele1}-clear`);
    } else {
      pasteTarget = document.getElementById(`character_${ele1}_${ele2}`);
      clearButton = document.getElementById(`${ele1}-${ele2}-clear`);
    }
    pasteTarget.addEventListener("paste", function(){
      clearButton.style.visibility = "visible";
    });
  }
// ここまでコピーペースト検知でクリアボタン表示

// ここからテキストエリアリサイズ
  $(function(){
    var motif = $("#character_motif")
    var introduction1 = $("#character_information_attributes_0_introduction")
    var introduction2 = $("#character_information_attributes_1_introduction")
    motif.autosize();
    introduction1.autosize();
    introduction2.autosize();
    // コピーペースト検知でリサイズ
    motif.trigger("autosize.resize");
    introduction1.trigger("autosize.resize");
    introduction2.trigger("autosize.resize");
    // クリアボタン押下でもリサイズ
    $("#motif-clear").on("click", function(){
      motif.trigger("autosize.resize");
    })
    $("#introduction-0-clear").on("click", function(){
      introduction1.trigger("autosize.resize");
    })
    $("#introduction-1-clear").on("click", function(){
      introduction2.trigger("autosize.resize");
    })
  });
// ここまでテキストエリアリサイズ

// ここからテキストフィールド幅リサイズ
  $(document).ready(function() {
    var $inputText = $(".js-width-resize");
    var $dummyInputText = $(".js-dummy-width-resize");

    function updateValue(e) {
      var value = $(e.target).val();
      $(e.target).prev($dummyInputText).text(value);
    }

    $inputText.on("keyup", updateValue);
    $inputText.on("compositionend", updateValue);
  });
// ここまでテキストフィールド幅リサイズ

// ここから画像プレビュー
$(document).on("turbolinks:load", function () {
  // file_fieldのIDを入れる
  $("#character_images").on("change", function (e) {
    var files = e.target.files;
    var d = new $.Deferred().resolve();
    $.each(files, function (i, file) {
      d = d.then(function () {
        return previewImage(file);
      });
    });
  });

  var previewImage = function (imageFile) {
    var reader = new FileReader();
    var img = new Image();
    var def = $.Deferred();
    reader.onload = function (e) {
      // 画像を表示
//      $("#image_preview").empty(); // これがあると最後の画像のみのプレビューになる
      $("#image_preview").append(img);
      img.src = e.target.result;
      def.resolve(img);
    };
    reader.readAsDataURL(imageFile);
    return def.promise();
  };
});
// ここまで画像プレビュー
