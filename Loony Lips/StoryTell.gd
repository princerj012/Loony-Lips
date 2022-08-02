extends Control

var player_answer = []
var story = "%s ate a/an %s flavored sandwich. %s had a %s day."
var story_told = false
var stories = [
	{
	"prompts": ["a name"],
	"story": "In a decade the gods created a hero to save humanity from the darkness, the hero is named %s."
	},
	{
	"prompts": ["a name", "a noun"],
	"story": "Heres a child named %s, the child likes %s."
	},
	{
	"prompts": ["a name", "another name", "a verb"],
	"story": "Somebody named %s could'nt open the door! Luckily the person named %s %s the door for the person."
	},
	{
	"prompts": ["a name", "a noun", "a gender", "an adjective"],
	"story": "%s ate a %s flavored sandwich. %s had a %s day."
	},
	{
	"prompts": ["a name", "a family member", "a place", "a noun", "an adjective"],
	"story": "June 16 2022\nDear %s,\nHey it's me your %s. I'm currently on %s to research %s for my new book. I had a %s day.\nSincerely,\nBonnie"
	},
	{
	"prompts": ["a name", "a game", "a verb", "a family member", "a place", "a noun"],
	"story": "A child named %s wants the game %s that he would even %s a person. One day his %s let him buy the game, but it's in %s they go there and %s the game."
	},
	{
	"prompts": ["a name", "an emothion", "another name", "a verb", "a place", "an adjective (that describes a place)", "another emotion"],
	"story": "A person called %s feels $s today. The person's friend %s wanted to %s him, so they go to the %s. So far the person describes the place as '%s'. After the visit the person and the friend felt %s."
	},
	{
	"prompts": ["a name", "another name", "a place", "an adjective (that describes a place)", "an emotion", "an object", "an adjectives (that describes an object)", "an adjective"],
	"story": "Two people called %s and %s went to the place called %s. They described it as $s, after leaving they brought a/an %s they described the object as %s. They had a %s day."
	}
	]
var current_story

func _ready():
	set_current_story()
	$VBoxContainer/Label.text = "Welcome to StoryTell, here you have to type a specific thing that this program wants, after that it prints a random story with those words. "
	prompt()

func set_current_story():
	randomize()
	current_story = stories[randi() % stories.size()]

func _on_LineEdit_text_entered(_new_text):
	player_answer.append($VBoxContainer/HBoxContainer/LineEdit.text)
	$VBoxContainer/Label.text = ""
	$VBoxContainer/HBoxContainer/LineEdit.clear()
	prompt()
	
func _on_TextureButton_pressed():
	if story_told == true:
		get_tree().reload_current_scene()
	else:
		var text = ""
		_on_LineEdit_text_entered(text)

func tell_story():
	story_told = true
	$VBoxContainer/HBoxContainer/Label2.text = "Again!"
	$VBoxContainer/Label.text = current_story.story % player_answer
	$VBoxContainer/HBoxContainer/LineEdit.queue_free()

func prompt():
	if len(player_answer) == len(current_story.prompts):
		tell_story()
	else:
		$VBoxContainer/Label.text += "Can i have " + current_story.prompts[player_answer.size()] + " please?"
