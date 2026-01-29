extends Node

enum types_of_masks {
	beijaflor,
	tartaruga,
	garca,
	arara,
	macaco,
	onca,
	peixe,
	lobo
}

func get_mask_color(type_of_mask):
	match type_of_mask:
		types_of_masks.beijaflor:
			return '#008D03'
		types_of_masks.tartaruga:
			return '#0007EB'
		types_of_masks.garca:
			return '#C740B8'
		types_of_masks.arara:
			return '#FC0301'
		types_of_masks.macaco:
			return '#FFBE00'
		types_of_masks.onca:
			return '#FF640A'
		types_of_masks.peixe:
			return '#01D5FF'
		types_of_masks.lobo:
			return '#6b2000'
