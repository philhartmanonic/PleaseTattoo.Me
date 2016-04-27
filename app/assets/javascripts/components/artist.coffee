@Artist = React.createClass
	getInitialState: ->
		divStyle: {
			backgroundImage: 'url(' + @props.artist.image + ')',
			backgroundSize: 'cover'
		}
	render: ->
		React.DOM.div
			className: 'card'
			style: @state.divStyle
			React.DOM.div
				className: 'infoholder'
				React.DOM.div
					className: 'infocontainer'
					React.DOM.div
						className: 'info card-block'
						React.DOM.h4
							className: 'title'
							"#{@props.artist.first_name} #{@props.artist.last_name}"
						@props.artist.parlor.name