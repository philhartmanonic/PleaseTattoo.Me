@Artist = React.createClass
	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/artists/#{ @props.artist.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteArtist @props.artist
	artistRow: ->
		React.DOM.tr null,
			React.DOM.td null, @props.artist.first_name
			React.DOM.td null, @props.artist.last_name
			React.DOM.td null, @props.artist.parlor.name
			React.DOM.td null, @props.artist.parlor.full_address
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleDelete
					'Delete'
	render: ->
		@artistRow()
