import axios from 'axios'
import { csrfToken } from 'rails-ujs'

// ajaxでする場合はrailsのヘルパーとは違って咳キュリティトークンの自動生成機能がつかないので、
// こちら側で用意してあげないといけない。
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default axios