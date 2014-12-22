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
      MegaHAL.chat($("input#name").val() || "Anon");
      return false;
    });
    $("form#user").on("submit", function(){
      $("#input").hide();
      MegaHAL.user($("#input").val());
      return false;
    });
  };
  MegaHAL.chat = function(name) {
    _gaq.push(['_trackPageview', "api/chats"])
    request = $.ajax({
      url: "api/chats",
      type: "POST",
      data: { user: name },
      accepts: "json",
      dataType: "json"
    });
    request.done(function(data) {
      MegaHAL.key = data.chat.key;
      MegaHAL.name = name;
      $("#log").append('<div class="utterance alert alert-success role="alert"><span class="name">' + name + ':</span> Started a new chat.</div>');
      window.onbeforeunload = function(e) {
        return 'Your chat with MegaHAL will end.';
      };
      $('body').scrollTop($('body')[0].scrollHeight);
      setTimeout("MegaHAL.ping();", 800);
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
    request = $.ajax({
      url: "api/replies",
      type: "POST",
      data: { key: MegaHAL.key },
      accepts: "json",
      dataType: "json"
    });
    request.done(function(data) {
      _gaq.push(['_trackPageview', "api/replies"])
      reply = data.reply.text;
      $("#log").append('<p class="mh10 utterance"><span class="name">MegaHAL:</span> ' + reply + '</p>');
      $("#input").val("");
      $("#input").show();
      $("#input").focus();
      $('body').scrollTop($('body')[0].scrollHeight);
    });
    request.fail(function(jqXHR, textStatus, errorThrown) {
      setTimeout("MegaHAL.ping();", 800)
    });
  };
  MegaHAL.user = function(text) {
    _gaq.push(['_trackPageview', "api/inputs"])
    request = $.ajax({
      url: "api/inputs",
      type: "POST",
      data: { key: MegaHAL.key, text: text },
      accepts: "json",
      dataType: "json"
    });
    request.done(function(data) {
      $("#log").append('<p class="user utterance"><span class="name">' + MegaHAL.name + ':</span> ' + text + '</p>');
      setTimeout("MegaHAL.ping();", 800);
      $('body').scrollTop($('body')[0].scrollHeight);
    });
    request.fail(function(jqXHR, textStatus, errorThrown) {
      data = jqXHR.responseJSON;
      for (i = 0; i < data.length; i++) {
        $("#log").append('<div class="utterance alert alert-danger role="alert"><span class="name">Error:</span> ' + data[i] + '</div>');
      }
      $('body').scrollTop($('body')[0].scrollHeight);
    });
  };
}(jQuery))
