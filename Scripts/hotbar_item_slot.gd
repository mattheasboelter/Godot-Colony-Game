extends PanelContainer

func update(type, selected):
	var texture = $"Item/Vertical Layout/Item Texture"
	var amount = $"Item/Vertical Layout/Amount"
	var selection_indicator = $"Item/Vertical Layout/Selected"
	
	var texture_sprite = load(str("res://Sprites/", type, ".png"))

	if type == null:
		texture_sprite = null
		selected = false

	texture.texture = texture_sprite
	selection_indicator.visible = selected
	amount.text = "1"
		
