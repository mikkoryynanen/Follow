extends Sprite

export var rounds = 10

var sequences = []
var player_quesses = []
var current_sequence_index = 0

enum GameState {
	SHOW,
	GUESS,
	END
}
var state = GameState.SHOW

onready var animationPlayer = $AnimationPlayer
onready var audioPlayer: AudioStreamPlayer = $AudioStreamPlayer

var button_audio_0 = preload("res://Assets/sfx/Coin.wav")
var button_audio_1 = preload("res://Assets/sfx/Coin_2.wav")
var button_audio_2 = preload("res://Assets/sfx/Coin_3.wav")
var button_audio_3 = preload("res://Assets/sfx/Coin_4.wav")


func _ready():
	play_button_animation(0)

	# Create sequence
	for _i in range(1, rounds):
		var rng = RandomNumberGenerator.new()
		var numbers = []
		rng.randomize()
		numbers.append(rng.randi_range(1, 4))

		# Add previous sequences numbers in front of this ome
		# and then append new numbers back of those
		var previous_sequence = []
		if sequences.back() != null:
			previous_sequence.append_array(sequences.back())

		previous_sequence.append_array(numbers)
		sequences.append(previous_sequence)
			
	yield(show_sequence(), "completed")


func show_sequence():
	var speed = 1.0

	yield(get_tree().create_timer(speed), "timeout")

	print(sequences)
	while state != GameState.END:
		var sequence = sequences[current_sequence_index]
		print("sequence : ", sequence)
		for number in sequence:
			play_button_animation(number)

			yield(get_tree().create_timer(speed), "timeout")

			play_button_animation(0)

		play_button_animation(0)
		state = GameState.GUESS
		print("waiting for user quess")
		while state == GameState.GUESS:
			yield(get_tree().create_timer(1), "timeout")
				
		# TOOD Show succesfull text here
		# TODO Add to the score from here
		Stats.emit_signal("update_score", sequence.size() + 1)

		yield(get_tree().create_timer(1), "timeout")
		current_sequence_index += 1

		# Increase speed every sequence
		# speed -= .25


func _input(event):
	if event is InputEventKey and event.pressed and state == GameState.GUESS:
		match event.scancode:
			KEY_1:
				player_quesses.append(1)
				process_guesses()
				play_button_animation(1)
			KEY_2:
				player_quesses.append(2)
				process_guesses()
				play_button_animation(2)
			KEY_3:
				player_quesses.append(3)
				process_guesses()
				play_button_animation(3)
			KEY_4:
				player_quesses.append(4)
				process_guesses()
				play_button_animation(4)


func process_guesses():
	if player_quesses.size() >= sequences[current_sequence_index].size():
		if check_player_guesses():
			print("Player guessed correctly. moving to next one...")
			state = GameState.SHOW
			player_quesses.clear()
		else:
			print("player failed. Game over state")
			state = GameState.END
	else:
		print("more numbers still to guess")

func check_player_guesses() -> bool:
	# Technically this should never happen
	if player_quesses.size() != sequences[current_sequence_index].size():
		return false
		
	for index in player_quesses.size():
		if player_quesses[index] != sequences[current_sequence_index][index]:
			return false
		# if !sequences[current_sequence_index].has(item):
		# 	print("item not found ion sequences")
		# 	return false

	return true

func play_button_animation(index: int):
	audioPlayer.stream = null
	match index:
		0:
			animationPlayer.play("Idle")
			# audioPlayer.stream = button_audio_idle
		1:
			animationPlayer.play("ShowGreen")
			audioPlayer.stream = button_audio_0
		2:
			animationPlayer.play("ShowRed")
			audioPlayer.stream = button_audio_1
		3:
			animationPlayer.play("ShowBlue")
			audioPlayer.stream = button_audio_2
		4:
			animationPlayer.play("ShowYellow")
			audioPlayer.stream = button_audio_3
		
	audioPlayer.play()
