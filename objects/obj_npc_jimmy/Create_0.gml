event_inherited();

dialogue = {
	textbox_id: noone,
	title: "~ Lil' Jimmay ~",
	quest_id: 2,
	stage: global.quest_tracker.quests[2].stage,
	text: [
		[
			// stage 0: quest = inactive, prerequisites = incomplete
			"",
		],
		[
			// stage 1: - quest = inactive, prerequisites = complete || 0
			"Hey there duuuuuude.",
			"I could really use your help right now. You see, my awesome cat Mittons ran off a little while ago, and I can't find him anywhere!",
			"I know he didn't go far. He likes to hide in the tall grass. Can you help me find him? PLEEEAAAAAASE!",
			
		],
		[
			// stage 2: quest = active, tasks = incomplete
			"Did you find Mittons yet?!",
			"He's gotta be around here somewhere hiding in the tall grass.",
		],
		[
			// stage 3: quest = active, teasks = complete
			"You found him! Thanks duuuuuuude!",
			"I found this while I was snooping around. My mom won't let me keep it, so you can have it!",
		],
		[
			// stage 4: quest = complete
			"Mittons really likes to chase bugs!",
		]
	]
}