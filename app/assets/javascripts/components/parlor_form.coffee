@ParlorForm = React.createClass
	getInitialState: ->
		name: ''
		street_number: ''
		street_direction: ''
		street_name: ''
		street_type: 'St'
		unit: ''
		city: ''
		state: ''
		zip: ''
	handleChange: (e) ->
		name = e.target.name
		@setState "#{ name }": e.target.value
	valid: ->
		@state.name && @state.street_number && @state.street_name && @state.street_type && @state.city && @state.state && @state.zip
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '/parlors/', { parlor: @state }, (data) =>
			@props.handleNewParlor data
			@setState @getInitialState()
		, 'JSON'
	render: ->
		React.DOM.form
			className: 'form-inline'
			onSubmit: @handleSubmit
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Name'
					name: 'name'
					value: @state.name
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'number'
					className: 'form-control'
					placeholder: 'Street Number'
					name: 'street_number'
					value: @state.street_number
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.select
					className: 'form-control'
					placeholder: 'Street Direction'
					name: 'street_direction'
					value: @state.street_direction
					onChange: @handleChange
					React.DOM.option
						value: ''
						label: ''
					React.DOM.option
						value: 'E'
						label: 'E'
					React.DOM.option
						value: 'W'
						label: 'W'
					React.DOM.option
						value: 'N'
						label: 'N'
					React.DOM.option
						value: 'S'
						label: 'S'
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Street Name'
					name: 'street_name'
					value: @state.street_name
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.select
					className: 'form-control'
					placeholder: 'Street Type'
					name: 'street_type'
					value: @state.street_type
					onChange: @handleChange
					React.DOM.option
						value: 'St'
						label: 'St'
					React.DOM.option
						value: 'Ave'
						label: 'Ave'
					React.DOM.option
						value: 'Rd'
						label: 'Rd'
					React.DOM.option
						value: 'Blvd'
						label: 'Blvd'
					React.DOM.option
						value: 'Ct'
						label: 'Ct'
					React.DOM.option
						value: 'Dr'
					React.DOM.option
						value: 'Hwy'
						label: 'Hwy'
					React.DOM.option
						value: 'Lane'
						label: 'Lane'
					React.DOM.option
						value: 'Way'
						label: 'Way'
					React.DOM.option
						value: 'Gdns'
					React.DOM.option
						value: 'Pkwy'
					React.DOM.option
						value: 'Pl'
					React.DOM.option
						value: 'Row'
					React.DOM.option
						value: 'Sq'
					React.DOM.option
						value: 'Strp'
					React.DOM.option
						value: 'Yard'
					React.DOM.option
						value: 'Ally'
						label: 'Ally'
					React.DOM.option
						value: 'App'
						label: 'App'
					React.DOM.option
						value: 'Arc'
						label: 'Arc'
					React.DOM.option
						value: 'Brow'
						label: 'Brow'
					React.DOM.option
						value: 'Bypa'
						label: 'Bypa'
					React.DOM.option
						value: 'Cway'
						label: 'Cway'
					React.DOM.option
						value: 'Cct'
						label: 'Cct'
					React.DOM.option
						value: 'Circ'
						label: 'Circ'
					React.DOM.option
						value: 'Cl'
					React.DOM.option
						value: 'Cpse'
					React.DOM.option
						value: 'Cnr'
					React.DOM.option
						value: 'Cove'
					React.DOM.option
						value: 'Cres'
					React.DOM.option
						value: 'End'
					React.DOM.option
						value: 'Esp'
					React.DOM.option
						value: 'Flat'
					React.DOM.option
						value: 'Fway'
					React.DOM.option
						value: 'Frnt'
					React.DOM.option
						value: 'Gld'
					React.DOM.option
						value: 'Glen'
					React.DOM.option
						value: 'Grn'
					React.DOM.option
						value: 'Gr'
					React.DOM.option
						value: 'Hts'
					React.DOM.option
						value: 'Link'
					React.DOM.option
						value: 'Loop'
					React.DOM.option
						value: 'Mall'
					React.DOM.option
						value: 'Mews'
					React.DOM.option
						value: 'Pckt'
					React.DOM.option
						value: 'Pde'
					React.DOM.option
						value: 'Park'
					React.DOM.option
						value: 'Prom'
					React.DOM.option
						value: 'Res'
					React.DOM.option
						value: 'Rdge'
					React.DOM.option
						value: 'Rise'
					React.DOM.option
						value: 'Tarn'
					React.DOM.option
						value: 'Tfre'
					React.DOM.option
						value: 'Trac'
					React.DOM.option
						value: 'Tway'
					React.DOM.option
						value: 'View'
					React.DOM.option
						value: 'Vsta'
					React.DOM.option
						value: 'Walk'
					React.DOM.option
						value: 'Wway'
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Unit'
					name: 'unit'
					value: @state.unit
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'City'
					name: 'city'
					value: @state.city
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'State'
					name: 'state'
					value: @state.state
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Zip'
					name: 'zip'
					value: @state.zip
					onChange: @handleChange
			React.DOM.button
				type: 'submit'
				className: 'btn btn-primary'
				disabled: !@valid()
				'Create Parlor'