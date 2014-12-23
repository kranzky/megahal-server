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
      $("#spinner").show();
      MegaHAL.chat($("input#name").val() || "Anon");
      return false;
    });
    $("form#user").on("submit", function(){
      $("#input").hide();
      $("#spinner").show();
      MegaHAL.user($("#input").val());
      return false;
    });
    $(window).resize(function() {
      MegaHAL.scroll();
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
      $("#log").append('<div class="utterance alert alert-success role="alert"><span class="name"></span> started a new chat.</div>');
      $("#log").children().last().find(".name").text(name + ":");
      window.onbeforeunload = function(e) {
        return 'Your chat with MegaHAL will end.';
      };
      MegaHAL.scroll();
      setTimeout("MegaHAL.ping();", 800);
    });
    request.fail(function(jqXHR, textStatus, errorThrown) {
      data = jqXHR.responseJSON;
      for (i = 0; i < data.length; i++) {
        $("#log").append('<div class="utterance alert alert-danger role="alert"><span class="name">Error:</span> <span class="message"></span></div>');
        $("#log").children().last().find(".message").text(data[i]);
      }
      MegaHAL.scroll();
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
      $("#log").append('<p class="mh10 utterance"><span class="name">MegaHAL:</span> <span class="message"></span></p>');
      $("#log").children().last().find(".message").text(reply);
      $("#input").val("");
      $("#spinner").hide();
      $("#input").show();
      $("#input").focus();
      MegaHAL.scroll();
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
      $("#log").append('<p class="user utterance"><span class="name"></span> <span class="message"></span></p>');
      $("#log").children().last().find(".name").text(MegaHAL.name + ":");
      $("#log").children().last().find(".message").text(text);
      setTimeout("MegaHAL.ping();", 800);
      MegaHAL.scroll();
    });
    request.fail(function(jqXHR, textStatus, errorThrown) {
      data = jqXHR.responseJSON;
      for (i = 0; i < data.length; i++) {
        $("#log").append('<div class="utterance alert alert-danger role="alert"><span class="name">Error:</span> <span class="message"></span></div>');
        $("#log").children().last().find(".message").text(data[i]);
      }
      MegaHAL.scroll();
    });
  };
  MegaHAL.scroll = function() {
    setTimeout(function() {
      $('body').animate({"scrollTop": $('body')[0].scrollHeight}, 'fast');
    }, 200);
  };
}(jQuery))
