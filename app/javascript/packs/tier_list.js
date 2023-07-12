import $ from 'jquery';
import 'jquery-ui/ui/widgets/draggable';
import 'jquery-ui/ui/widgets/droppable';

$(document).ready(function() {
  $(".element").draggable();
  $(".tier").droppable({
    drop: function(event, ui) {
      var tier_id = $(this).attr('id');
      var element_id = ui.draggable.attr('id');
      // Add your AJAX code here to send `tier_id` and `element_id` to the server
    }
  });
});

console.log("JavaScript is working!");