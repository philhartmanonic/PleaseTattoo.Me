# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Artists = React.createClass
	getInitialState: ->
		artists: @props.artists
		parlors: @props.parlors
		addingParlor: false
		data: ''
		parlorFocus: ''
	getDefaultProps: ->
		artists: []
		parlors: []
	addArtist: (artist) ->
		artists = @state.artists.slice()
		for parlor in @state.parlors
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
	createParlor: (newState) ->
		@setState addingParlor: newState
	addParlor: (parlor) ->
		parlors = @state.parlors.slice()
		$.ajax
			url: '/api/v1/parlors/' + parlor.id
			type: 'GET'
			data: parlor
			dataType: 'json'
			success: (data) =>
				@setState data: data
				parlors.push {
					key: data.parlor.id
					id: data.parlor.id,
					name: data.parlor.name,
					full_address: data.parlor.full_address
				}
				@setState parlors: parlors
				@setState parlorFocus: data.parlor.id
				@setState addingParlor: false

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
			React.createElement ArtistForm, handleNewArtist: @addArtist, callbackParent: @createParlor, parlors: @state.parlors, parlorFocus: @state.parlorFocus
			if @state.addingParlor
				React.createElement ParlorForm, handleNewParlor: @addParlor
			else
				''
			React.DOM.hr null
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
							