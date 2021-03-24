import $ from 'jquery'
import axios from 'modules/axios'


const listenInactiveHeartEvent = (articleId) => {
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
}

const listenActiveHeartEvent = (articleId) => {
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
}



export {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}