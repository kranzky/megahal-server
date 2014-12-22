(function ($) {
  if (window.MegaHAL === undefined || window.MegaHAL === null) {
    MegaHAL = window.Agworld = {};
  }
  MegaHAL.init = function() {
    $("#username").on("shown.bs.modal", function(){
      $("input#name").focus();
    });
    $("#username").modal({
      keyboard: false,
      backdrop: "static"
    });
    $("form#name").on("submit", function(){
      $("#username").modal('hide');
      MegaHAL.chat($("input#name").val());
      return false;
    });
  };
  MegaHAL.chat = function(name) {
    _gaq.push(['_trackPageview', "api/chats?name="+name])

    request = $.ajax({
      url: "api/chats",
      type: "POST",
      data: { user: name },
      accepts: "json",
      dataType: "json"
    });
     
    request.done(function(data) {
      MegaHAL.key = data.chat.key;
      $("#log").append('<div class="utterance alert alert-success role="alert"><span class="name">' + name + ':</span> Started a new chat.</div>');
      $('body').scrollTop($('body')[0].scrollHeight);
      MegaHAL.ping();
    });
      
    request.fail(function(jqXHR, textStatus, errorThrown) {
      data = jqXHR.responseJSON;
      for (i = 0; i < data.length; i++) {
        $("#log").append('<div class="utterance alert alert-danger role="alert"><span class="name">Error:</span> ' + data[i] + '</div>');
      }
      $('body').scrollTop($('body')[0].scrollHeight);
    });
  };
  MegaHAL.ping = function() {
    // TODO: keep pinging until we receive it
    // TODO: show spinner while pinging
    // TODO: enable input after pinging
  };
  MegaHAL.user = function(input) {
    // TODO: send input
    MegaHAL.ping();
  };
}(jQuery))
