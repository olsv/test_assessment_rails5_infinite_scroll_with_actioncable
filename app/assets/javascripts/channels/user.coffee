App.user = App.cable.subscriptions.create "UserChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)

    users_table = $('.users')
    row = $("*[data-user-id=#{ data.id }]")

    switch data.action
      when 'created'
        # do nothing
        ''
      when 'updated'
        # update if row presents
        if row.length
          for attribute, value of data.attributes
            row.find("*[data-attribute-#{ attribute }]").text(value)
      when 'deleted'
        # remove if row exists and row in the table
        if users_table.length && row.length
          row.remove()
