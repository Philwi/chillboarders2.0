import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["description", "commentList"]

  onPostSuccess(event) {
    let [data, status, xhr] = event.detail;
    this.commentListTarget.innerHTML += xhr.response;
    this.descriptionTarget.value = "";
  }
}