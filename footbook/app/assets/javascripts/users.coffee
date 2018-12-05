# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Login =
  bind: () ->
    $ '.create-button'
    .click (e) ->
      e.preventDefault()
      account = $('#username').val()
      password = $('#password').val()
      match = account.match /[^a-zA-Z0-9_\.]/
      return window.show_error 'Invalid account' if account.length == 0 or account.length > 32 or match?
      return window.show_error 'Invalid password' if password.length == 0 or password.length > 60
      $.post '/users/sign_in', { account, password }, (resp) =>
        return window.show_error(resp.data) if resp.status == 'ERROR'
        location.href = '/'

@ChangeSetting =
  bind: () ->
    $ '.change-setting-button'
      .click (e) ->
        password = $('#password').val()
        confirm = $('#_password').val()
        return window.show_error 'Invalid password' if password.length == 0 or password.length > 60 or password != confirm
        $.post '/settings', { password }, (resp) =>
          return window.show_error(resp.data) if resp.status == 'ERROR'
          window.show_success('OK!')
