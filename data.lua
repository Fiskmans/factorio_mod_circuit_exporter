
local signalExporterItem = table.deepcopy(data.raw["item"]["constant-combinator"])
local signalExporterEntity = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])

local exporterTint = {r=0.5,g=1,b=0.7,a=1}

signalExporterItem.name = "signal-exporter"
signalExporterItem.place_result = "signal-exporter"
signalExporterItem.icons = {
  {
    icon = signalExporterItem.icon,
    icon_size = signalExporterItem.icon_size,
    tint = exporterTint
  }
}

signalExporterEntity.name = "signal-exporter"
signalExporterEntity.minable.result = "signal-exporter"
signalExporterEntity.item_slot_count = 1
signalExporterEntity.sprites.sheets = {
										{
											frames = 4,
											size = { 57, 52 },
											filename = "__base__/graphics/entity/combinator/constant-combinator.png",
											tint = exporterTint,
											hr_version = {
												frames = 4,
												size = { 114, 102 },
												shift = { 0, 0.125 },
												filename = "__base__/graphics/entity/combinator/hr-constant-combinator.png",
												tint = exporterTint,
												scale = 0.5
											}
										},
										{
											frames = 4,
											size = { 50, 34 },
											filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
											draw_as_shadow = true,
											hr_version = {
												frames = 4,
												size = { 98, 66 },
												shift = { 0.234375, 0.109375 },
												filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
												scale = 0.5,
												draw_as_shadow = true
											}
										}
									}
      

-- create the recipe prototype from scratch
local signalExporterRecipe = {
  type = "recipe",
  name = "signal-exporter",
  enabled = false,
  energy_required = 0.5, -- time to craft in seconds (at crafting speed 1)
  ingredients = {{"constant-combinator", 1}, {"electronic-circuit", 2}},
  result = "signal-exporter"
}

table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe",recipe = "signal-exporter"})
data:extend{signalExporterItem, signalExporterRecipe, signalExporterEntity}