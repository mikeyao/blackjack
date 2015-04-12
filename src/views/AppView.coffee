class window.AppView extends Backbone.View
  template: _.template '
    <div class="bankroll-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      if (not @model.get('result') and @model.get('bankRoll').get('betSet'))
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if (not @model.get('result') and @model.get('bankRoll').get('betSet'))
        @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'chipsUpdated', =>
      @finish(@model.get 'result')
      @renderAll()
    @model.on 'handsDealt', =>
      @renderAll()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.bankroll-container').html new BankRollView(model: @model.get 'bankRoll').el

  renderAll: =>
    @render()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  finish: (result)->
    if alert("You #{result}! Set a new bet to continue.")

