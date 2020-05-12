import { Controller } from "stimulus";

export default class extends Controller {
  closeModal(event) {
    console.log('lol')
    let modal = document.getElementById('imageModal');
    if(modal != undefined){
      modal.style.display = 'none';
    }
  }
}