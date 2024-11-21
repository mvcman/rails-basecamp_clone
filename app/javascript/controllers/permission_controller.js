import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    
  }

  requestPermission() {
    console.log("request for permission!");
    Notification.requestPermission().then((permission) => {
      if (permission === 'granted') {
        new Notification("Hi, there!");
      }
    });
  }
}
