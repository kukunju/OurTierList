$(function() {
  // 保持するデータ
  var selected_elements = [];



  // ドラッグ
  $(".element").draggable({
    revert: function(dropped) {
      return !dropped;
    },
    opacity: 0.5,
  });

  //ドロップ
  $(".tier_elements").droppable({
    accept: ".element",
    drop: function(event, ui) {
      var element = ui.draggable;
      var tier = $(this).attr("id");
      element.appendTo(this);
      element.css({top: '', left: ''});

      var tierNumber = tier.replace('tier', '');

      var selected_element = selected_elements.find(function(se) {
        return se.element_id == element.attr('id');
      });

      if (selected_element) {
        selected_element.tier = tierNumber;
      } else {
        selected_elements.push({
          tier_list_id: null,
          element_id: element.attr('id'),
          tier: tierNumber,
        });
      }
    }
  });

  // フォームの送信イベントで配列を送信
  $('form').on('submit', function(e) {
    e.preventDefault();

    // selected_elementsをJSON形式に変換
    var jsonData = JSON.stringify(selected_elements);

    var hiddenField = $('<input type="hidden" name="selected_elements">');
    hiddenField.val(jsonData);

    $(this).append(hiddenField);

    this.submit();
  });
});