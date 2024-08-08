event_inherited();

nest_state = nest_state_patrol;

//quest = {
//	quest_id: 3,
//	stage: QUEST_STAGE.AVAILABLE,
//	update_script: noone,
//	start_object: noone,
//	end_object: noone,
//	follow_target: noone,
//}

dialogue = {
	textbox_id: noone,
	title: "~ Peach ~",
	//quest_id: 3,
	//stage: global.quest_tracker.quests[3].stage,
	text: [
		[
			// stage 0: quest = inactive, prerequisites = incomplete
			"",
		],
		[
			// stage 1: - quest = inactive, prerequisites = complete || 0
			"I just love flowers! the smell, the colors, the thrill of finding rare and unique flowers. Its my favorite!",
			"My collection is quite large, but there is one flower in particular that I just can't get on my own.",
			"There's a are flower that grows deep in the Shady Woods, just North East of here. It's called a Glowing Lutos.",
			"The Shady Woods is full of dangerous blob-like creatures. Poppa said that I am forbidden from entering the Shady Woods.",
			"If you go find the Glowing Lotus for me, I'll give you something nice! I promise!",
		],
		[
			// stage 2: quest = active, tasks = incomplete
			"Have you had a chance to search for the Glowing Lotus yet? You'll find it deep in the Shady Woods to the North East of here.",
		],
		[
			// stage 3: quest = active, teasks = complete
			"You found it! WOW!!! It's even brighter and more beautiful than I thought. I cannot thank you enough.",
			"Here have this thing.",
		],
		[
			// stage 4: quest = complete
			"The Glowing Lotus is the prize of my entire collection! you can come see the whole collection if you want.",
		]
	],
}	
