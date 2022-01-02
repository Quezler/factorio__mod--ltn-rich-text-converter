local classes = {"item", "entity", "technology", "recipe", "item-group", "fluid", "tile", "virtual-signal"}

function rename(train_stop)
    local backer_name = train_stop.backer_name

    for _,class in ipairs(classes) do
          backer_name = backer_name:gsub("%[" .. class .. "=", "[img=" .. class .. "/")
    end

    if(train_stop.backer_name ~= backer_name) then
        train_stop.backer_name = backer_name
    end
end

script.on_init(function(event)
  for _, train_stop in pairs(game.get_train_stops{}) do
      rename(train_stop)
  end
end)

function dirty(event)
    if (event.entity.type == "train-stop") then
        rename(event.entity)
    end
end

script.on_event(defines.events.on_built_entity, dirty)
script.on_event(defines.events.on_entity_renamed, dirty)
script.on_event(defines.events.on_robot_built_entity, dirty)