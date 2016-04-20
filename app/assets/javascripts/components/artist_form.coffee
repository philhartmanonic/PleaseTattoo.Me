@ArtistForm = React.createClass
	getInitialState: ->
		first_name: ''
		last_name: ''
		parlor_id: 1
		addingParlor: false
	handleChange: (e) ->
		name = e.target.name
		@setState "#{ name }": e.target.value
		if e.target.value == 'newparlor' and e.target.name == 'parlor_id'
			@setState addingParlor: true
			newState = !@state.addingParlor
			@props.callbackParent(newState)
		else if @state.parlor_id == 'newparlor'
			@setState addingParlor: false
			newState = !@state.addingParlor
			@props.callbackParent(newState)
	valid: ->
		@state.first_name && @state.last_name && @state.parlor_id
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '/artists/', { artist: @state }, (data) =>
			@props.handleNewArtist data
			@setState @getInitialState()
		, 'JSON'
	render: ->
		React.DOM.div
			className: 'artist_form'
			React.DOM.form
				className: 'form-inline'
				onSubmit: @handleSubmit
				React.DOM.div
					className: 'form-group'
					React.DOM.input
						type: 'text'
						className: 'form-control'
						placeholder: 'First Name'
						name: 'first_name'
						value: @state.first_name
						onChange: @handleChange
				React.DOM.div
					className: 'form-group'
					React.DOM.input
						type: 'text'
						className: 'form-control'
						placeholder: 'Last Name'
						name: 'last_name'
						value: @state.last_name
						onChange: @handleChange
				React.DOM.div
					className: 'form-group'
					React.DOM.select
						name: 'parlor_id'
						className: 'form-control'
						value: @state.parlor_id
						onChange: @handleChange
						for parlor in @props.parlors
							React.createElement ParlorOptions, key: parlor.id, id: parlor.id, label: parlor.name, parlor: parlor, value: @state.parlor_id
						React.DOM.option
							value: 'newparlor'
							label: 'Add new parlor...'
				React.DOM.button
					type: 'submit'
					className: 'btn btn-primary'
					disabled: !@valid()
					'Create Artist'