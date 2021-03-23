import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'


axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

// railsではturbolinksという機能を使ってページ遷移を行っている。
// DOMContentLoadedにするとrailsではJsの読み込みが遅れる
document.addEventListener('turbolinks:load', () => {
  // $('.article_title').on('click', () => {
  //   axios.get('/')
  //     .then((response) => {
  //       console.log(response)
  //     })
  // })
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      // jsonデータから値を持ってくる。
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })


  // like create
  $('.inactive-heart').on('click', () => {
    // ルーティングに合わせたパスを作るだけ
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').removeClass('hidden')
          $('.inactive-heart').addClass('hidden')
        }
      })
      // 失敗した時　eはerror
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
  $('.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
})