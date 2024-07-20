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
			"Why hello there, young traveler! As you can see, I'm tending to my very small garden. There's lots of work to do!",
			"Trouble is, those pesky goblins to the West have been raiding my crops at night! I can't stop them on my own. My bones are just too brittle...",
			"Would you care to aid this old man and DESTROY THOSE NASTY CRITTERS FOR ME!!!!? I would be eternally gratefull...",
		],
		[
			// stage 2: quest = active, tasks = incomplete
			"Did you take care of the those little devils yet?",
			"Head west to the plains and slay them all! Come back to me once you've done that and I'll reward you!",
		],
		[
			// stage 3: quest = active, teasks = complete
			"You exterminated all of the golbins in the plains?! MAGNIFICANT I SAYYYY!!!!",
			"I bet you gave 'em the ol' one-two-three! Back in my hay-day I would have taken care of them myself.",
			"Anyhoo, Thank you so much for aiding this old feller. Here, have this!",
		],
		[
			// stage 4: quest = complete
			"Thanks again for helping me out with those goblins! Now my crops are looking better than ever!",
		]
	]
}