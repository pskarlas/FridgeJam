import { Controller }      from "stimulus";
import { enter, leave}     from 'el-transition';
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ["modal", "button"]

  initialize() {
    useClickOutside(this)
  }

  toggleModal() {
    if(this.modalTarget.classList.contains('hidden')) {
      enter(this.modalTarget)
      document.body.classList.add('overflow-y-hidden')
    } else {
      leave(this.modalTarget)
      document.body.classList.remove('overflow-y-hidden')
    }
  }

  closeModal(){
    leave(this.modalTarget)
    document.body.classList.remove('overflow-y-hidden')
  }


}
