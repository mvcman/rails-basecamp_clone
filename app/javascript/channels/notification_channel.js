import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connecterd to notification channel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // displayNotification(data.content);
    // playNotificationSound()
    this.displayNotification(data);
  },

  displayNotification(data) {
    console.log("got the data ", data);
    if (!("Notification" in window)) {
      console.log("Browser does not support notification!");
    } else if(Notification.permission == 'granted') {
      console.log("Notification granted!");
      new Notification(data.title, { body: data.body });
    } else if(Notification.permission !== "denied") {
      console.log("notification permission need to be requested!");
    } else {
      console.log("permission denied!");
    }
  },
});

// function displayNotification(content) {
//   const container = document.getElementById('notification-container');

//   // Create a new notification element
//   const notificationElement = document.createElement('div');
//   notificationElement.className = 'notification';
//   notificationElement.textContent = content;

//   // Append the notification to the container
//   container.appendChild(notificationElement);
// }

// function playNotificationSound() {
//   const audioElement = document.getElementById('notificationSound');

//   // Check if the audio element is supported and not null
//   if (audioElement && typeof audioElement.play === 'function') {
//     // Play the notification sound
//     audioElement.play();
//   }
// }
