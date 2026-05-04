extends Node

var debug
var player
var weapon_manager

func round_to_digit(num, digit) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
