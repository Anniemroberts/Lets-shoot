//if ($("meta[name='current-user']").length> 0) {
  App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(data) {
      $("#notifications").prepend(data.html);
    }
  });
//}
