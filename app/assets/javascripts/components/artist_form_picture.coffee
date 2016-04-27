@ArtistFormPicture = React.createClass
	render: ->
		$.ajax
			method: 'POST'
			url: '/pictures/'
			data: @props.image_file
			content_type: 'image/jpg'
			filename: @props.first_name + '_' + @props.last_name + '_' + @props.parlor_name + '.jpg'
			artist_id: @props.artist.id