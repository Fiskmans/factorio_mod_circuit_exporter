script.on_event(defines.events.on_gui_opened, function (event)

	local player = game.players[event.player_index]
    if (event.gui_type == defines.gui_type.entity) and (event.entity.type == "constant-combinator") and (event.entity.name == "signal-exporter") then
	
		local custom_frame = player.gui.screen.add{type="frame", name="ce_signal_exporter_frame", caption="Signal Exporter"}
		custom_frame.auto_center = true
				
		local textBox = custom_frame.add{type="text-box", text=SignalsToJSON(event.entity.get_merged_signals())}
		textBox.read_only = true
		textBox.select_all()
		textBox.focus()
		
		player.opened = custom_frame
	end
end)

script.on_event(defines.events.on_gui_closed, function (event)
	
	if event.element and event.element.name == "ce_signal_exporter_frame" then
		event.element.destroy()
    end
end)

script.on_event(defines.events.on_entity_settings_pasted, function (event)
	
	if not (event.destination.type == "constant-combinator") then return end
	if not (event.destination.name == "signal-exporter") then return end

	local controlBehaviour = event.destination.get_control_behavior();
		
	if not controlBehaviour then return end
	if not (controlBehaviour.type == defines.control_behavior.type.constant_combinator) then return end
	
	-- Disable copying signals into the underlying combinator
	-- Its size is limited to 1 so we only have to remove that single signal
	controlBehaviour.set_signal(1, nil)
end)

function SignalsToJSON(mergedSignals)

	if not (type(mergedSignals) == "table") then return "{}" end
	
	local output = "{";
	local first = true
	
	for key, value in pairs(mergedSignals) do
	
		if not (type(value.signal) == "table") then return "{}" end
	
		if (value.signal.name) then
			if not first then
				output = output .. ","
			end
			first = false
			output = output .. "\n    \"" .. value.signal.name .. "\": " .. tostring(value.count)
		end
	end
	
	output = output .. "\n}"
	
	return output
end

