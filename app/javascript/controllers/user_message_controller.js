import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect () {
    StimulusReflexm.register(this)
  }

  beforeUpdate(anchorElement) {
    anchorElement.innerText = 'Updating...'
  }
}