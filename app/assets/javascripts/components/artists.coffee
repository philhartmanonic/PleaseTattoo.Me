# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Artists = React.createClass
	getInitialState: ->
		artists: @props.artists
		parlors: @props.parlors
	getDefaultProps: ->
		artists: []
		parlors: []
	addArtist: (artist) ->
		artists = @state.artists.slice()
		for parlor in @props.parlors
			if parlor.id == artist.parlor_id
				newArtist = {
					id: artist.id,
					first_name: artist.first_name,
					last_name: artist.last_name,
					parlor: {
						name: parlor.name,
						full_address: parlor.full_address
					}
				}
		artists.push newArtist
		@setState artists: artists
	deleteArtist: (artist) ->
		index = @state.artists.indexOf artist
		artists = React.addons.update(@state.artists, { $splice: [[index, 1]] })
		@replaceState artists: artists, parlors: @props.parlors
	render: ->
		React.DOM.div
			className: 'artists'
			React.DOM.h2
				className: 'title'
				'Tattoo Artists'
			React.createElement ArtistForm, handleNewArtist: @addArtist, parlors: @props.parlors
			React.DOM.hr
				React.DOM.table
					className: 'table table-bordered'
					React.DOM.thead null,
						React.DOM.tr null,
							React.DOM.th null, 'First Name'
							React.DOM.th null, 'Last Name'
							React.DOM.th null, 'Parlor'
							React.DOM.th null, 'Address'
							React.DOM.th null, 'Actions'
					React.DOM.tbody null,
						for artist in @state.artists
							React.createElement Artist, key: artist.id, artist: artist, handleDeleteArtist: @deleteArtist
								