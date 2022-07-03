import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-notification"
export default class extends Controller {
  connect() {
    // code borrowed from https://stackoverflow.com/questions/29017379/how-to-make-fadeout-effect-with-pure-javascript
    const flashElement = this.element;

    setTimeout(function (){
      flashElement.style.transition = "opacity 1s ease-in-out"
      flashElement.style.opacity = '1';
      flashElement.style.opacity = '0';

      setTimeout(function(){
        flashElement.remove()
      }, 1500)

    }, 5000)

  }
}
