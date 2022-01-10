function rename(train_stop)
    local backer_name = train_stop.backer_name

      backer_name = backer_name:gsub("%[item="           , "[img=item/")
      backer_name = backer_name:gsub("%[entity="         , "[img=entity/")
      backer_name = backer_name:gsub("%[recipe="         , "[img=recipe/")
      backer_name = backer_name:gsub("%[item%-group="    , "[img=item-group/")
      backer_name = backer_name:gsub("%[fluid="          , "[img=fluid/")
      backer_name = backer_name:gsub("%[tile="           , "[img=tile/")
      backer_name = backer_name:gsub("%[virtual%-signal=", "[img=virtual-signal/")

    if(train_stop.backer_name ~= backer_name) then
        train_stop.backer_name = backer_name
        train_stop.surface.create_entity{name = "flying-text", position = train_stop.position, text = "Rich text converted: " .. backer_name}
    end
end

script.on_init(function(event)
  for _, train_stop in pairs(game.get_train_stops{}) do
      rename(train_stop)
  end
end)

function dirty(entity)
    if (entity.type == "train-stop") then
        rename(entity)
    end
end

script.on_event(defines.events.on_built_entity, function(event)
    dirty(event.created_entity)
end)

script.on_event(defines.events.on_entity_renamed, function(event)
    dirty(event.entity)
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
    dirty(event.created_entity)
end)
