@ParlorOptions = React.createClass
	getInitialState: ->
		id: @props.parlor.id
		name: @props.parlor.name
	render: ->
		React.DOM.option
			value: @state.id
			label: @state.name