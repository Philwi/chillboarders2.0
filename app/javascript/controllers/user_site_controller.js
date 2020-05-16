import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';
import { debounce } from 'lodash-es';

export default class extends Controller {
  static targets = ['params']
  connect () {
    StimulusReflex.register(this)
    this.scroll = debounce(this.scroll, 1000)
  }

  scroll () {
    this.stimulate('UserSite::Reflex::Index#scroll', window.scrollY, this.paramsTarget.value)
  }
}