class window.BankRollView extends Backbone.View
  className: 'bankroll'

  template: _.template '
    Bank roll: $<%= chips %>
    Bet: $<%= bet %>
    <button class="add-button">+</button>
    <button class="subtract-button">-</button>
    <button class="set-button">Set</button>'

  events:
    'click .add-button': ->
      @model.changeBet(100) if not @model.get('betSet')
      @render()

    'click .subtract-button': ->
      @model.changeBet(-100) if not @model.get('betSet')
      @render()

    'click .set-button': ->
      @model.setBet()

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes

