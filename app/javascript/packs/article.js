import $ from 'jquery'
import axios from 'modules/axios'


import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent 
} from 'modules/handl_heart'


const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

const appendNewComment = (comment) => {
  // jsからDOMにコンテンツを加えていく.
  $('.comments-container').append(
    `<div class="article_comment"><p>${escape(comment.content)}</p></div>`
  )
}

// railsではturbolinksという機能を使ってページ遷移を行っている。
// DOMContentLoadedにするとrailsではJsの読み込みが遅れる
document.addEventListener('turbolinks:load', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  // ********************************
  // ********************************
  // comments
  // ********************************
  // ********************************
  // routeに沿ったURLを指定
  axios.get(`/api/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })

    handleCommentForm()

  $('.add-comment-button').on('click', () => {
    // 送信がクリックされた時にコンテンツのvalueを持ってくる
    const content = $('#comment_content').val()
    // 中身がからの時は送れないようにする
    if(!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/api/articles/${articleId}/comments`, {
        // axiosの第二引数にパラメーターを指定できる.
        // コントローラーのストロングパラメータに合わせる
        comment: {content: content}
      })
      .then((res) => {
        const comment = res.data
        appendNewComment(comment)
        // 初期化
        $('#comment_content').val('')
      })
    }
  })

  // ********************************
  // ********************************
  // like
  // ********************************
  // ********************************
  axios.get(`/api/articles/${articleId}/like`)
    .then((response) => {
      // jsonデータから値を持ってくる。
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })

    listenInactiveHeartEvent(articleId)
    listenActiveHeartEvent(articleId)
  
})