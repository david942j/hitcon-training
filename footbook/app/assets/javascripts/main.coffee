# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Main =
  bind: () ->
    $ '.newpost'
    .click (e) ->
      content = $('input.post').val()
      return window.show_error('Write something') if content.length == 0
      return window.show_error('Too long..') if content.length > 511
      $.post '/post', { content }, (resp) ->
        return window.show_error(resp.data) if resp.status == 'ERROR'
    $ '.account'
    .click (e) ->
      e.preventDefault()
      id = $(this).attr 'data-user-id'
      location.assign("/profile/#{id}")

    $ '.foot'
      .click (e) ->
        id = $(this).attr 'data-post-id'
        return if $(this).hasClass('footed')
        $.post "/foots/#{id}", {}, (resp) =>
          return if resp.status == 'ERROR'
          $(this).addClass('footed')
          msg = if resp.data == 0 then 'no body footed' else "#{resp.data} #{if resp.data > 1 then 'feet' else 'foot'}"
          $(this).siblings '.counter'
          .text msg

    $ '.reply'
      .click (e) ->
        account = $(this).attr 'data-user-account'
        $ '#message-modal'
        .foundation 'open'
        .find 'input'
        .val account
        $ '#message-modal'
        .find 'textarea'
        .val('')
        .focus()

    $ '.send'
      .click (e) =>
        account = $('input[name="account"]').val()
        content = $('textarea[name="content"]').val()
        return window.show_error('Write something!') if content.length == 0
        return window.show_error('Too much..') if content.length >= 1024
        $.post '/messages/send', {account, content}, (resp) ->
          return window.show_error(resp.data) if resp.status == 'ERROR'
          $ '#message-modal'
          .foundation 'close'

