@Parlors = React.createClass
	getInitialState: ->
		parlors: @props.parlors
	getDefaultProps: ->
		parlors : []
	render: ->
		React.DOM.div
			className: 'container'
			for parlor in @state.parlors
				React.createElement Parlor, key: parlor.id, id: parlor.id, parlor: parlor