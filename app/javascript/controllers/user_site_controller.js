import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';
import { debounce } from 'lodash-es';
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['params']
  connect () {
    StimulusReflex.register(this)
    this.scroll = debounce(this.scroll, 100)
  }

  scroll () {
    this.stimulate('UserSite::Reflex::Index#scroll', window.scrollY, this.paramsTarget.value)
  }
}