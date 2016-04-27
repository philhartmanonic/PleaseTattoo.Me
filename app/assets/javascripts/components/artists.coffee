@Artists = React.createClass
	getInitialState: ->
		artists: @props.artists
		parlors: @props.parlors
	getDefaultProps: ->
		artists: []
		parlors: []
	render: ->
		React.DOM.div
			className: 'container'
			React.DOM.span
				className: 'row'
				for artist in @props.artists
					React.createElement Artist, key: artist.id, id: artist.id, artist: artist