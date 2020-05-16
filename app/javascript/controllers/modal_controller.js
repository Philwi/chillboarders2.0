import { Controller } from "stimulus";

export default class extends Controller {
  closeModal(event) {
    let modal = document.getElementById('imageModal');
    if(modal != undefined){
      modal.style.display = 'none';
    }
  }
}