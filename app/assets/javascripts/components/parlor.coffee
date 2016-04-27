@Parlor = React.createClass
	getInitialState: ->
		edit: false
	makeArtist: (artist) ->
		first_name: artist.first_name
		last_name: artist.last_name
		image: artist.image
		parlor: {
			name: @props.parlor.name
			full_address: @props.parlor.full_address
		}
	render: ->
		React.DOM.div
			className: 'row'
			React.DOM.h2
				className: 'title'
				@props.parlor.name
			React.DOM.p
				className: 'address'
				@props.parlor.full_address
			React.DOM.div
				className: 'row'
				if @props.parlor.artists.length > 0
					for artist in @props.parlor.artists
						React.createElement Artist, key: artist.id, id: artist.id, artist: @makeArtist(artist)
			React.DOM.hr null
