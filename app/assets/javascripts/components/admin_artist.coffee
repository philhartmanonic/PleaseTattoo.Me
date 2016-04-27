@AdminArtist = React.createClass
	getInitialState: ->
		edit: false
		image_file: ''
	handleToggle: (e) ->
		e.preventDefault()
		@setState edit: !@state.edit
	handleChange: (e) ->
		name = e.target.name
		@setState "#{ name }": e.target.value
	handleEdit: (e) ->
		e.preventDefault()
		data = 
			id: @props.artist.id,
			first_name: React.findDOMNode(@refs.first_name).value,
			last_name: React.findDOMNode(@refs.last_name).value,
			parlor_id: React.findDOMNode(@refs.parlor_id).value
		
		picture =
			image: @state.image_file,
			imageable_id: @props.artist.id,
			image_file_name: @props.artist.first_name + '_' + @props.artist.last_name + '_' + @props.artist.parlor.name + '.jpg',
			image_content_type: 'image/jpg',
			imageable_type: 'Artist'
		$.when(
			$.ajax(
				method: 'PUT'
				url: "/artists/#{ @props.artist.id }"
				dataType: 'application/json'
				data:
					artist: data
				success: (data) =>
					@setState edit: false
			),
			$.ajax(
				method: 'POST'
				url: '/pictures/'
				dataType: 'application/json'
				data:
					picture: picture
				success: (picture) =>
					@setState edit: false
			)
		)
		@setState edit: false
	changeFile: (e) ->
		reader = new FileReader()
		file = e.target.files[0]
		reader.onload = (upload) =>
			@setState image_file: upload.target.result
		reader.readAsDataURL(file)
	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/artists/#{ @props.artist.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteArtist @props.artist
	imageName: (artist) ->
		if 'image_file_name' in @props.artist
			artist.picture.image_file_name
		else
			''
	artistRow: ->
		React.DOM.tr null,
			React.DOM.td null,
				React.DOM.img
					src: @props.artist.image
			React.DOM.td null, @props.artist.first_name
			React.DOM.td null, @props.artist.last_name
			React.DOM.td null, @props.artist.parlor.name
			React.DOM.td null, @props.artist.parlor.full_address
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleToggle
					'Edit'
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Delete'
	artistForm: ->
		React.DOM.tr null,
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'file'
					defaultValue: @props.artist.image_name
					ref: 'picture'
					onChange: @changeFile
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.artist.first_name
					ref: 'first_name'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.artist.last_name
					ref: 'last_name'
			React.DOM.td null,
				React.DOM.select
					className: 'form-control'
					defaultValue: @props.artist.parlor_id
					ref: 'parlor_id'
					for parlor in @props.parlors
						React.createElement ParlorOptions, key: parlor.id, id: parlor.id, label: parlor.name, parlor: parlor
			React.DOM.td null
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleEdit
					'Update'
				React.DOM.a
					className: 'btn-danger'
					onClick: @handleToggle
					'Cancel'
	render: ->
		if @state.edit
			@artistForm()
		else
			@artistRow()