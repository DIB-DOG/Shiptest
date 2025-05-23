/datum/round_event_control/easter
	name = "Easter Eggselence"
	holidayID = EASTER
	typepath = /datum/round_event/easter
	weight = -1
	max_occurrences = 1
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event/easter/announce(fake)
	priority_announce(pick("Hip-hop into Easter!","Find some Bunny's stash!","Today is National 'Hunt a Wabbit' Day.","Be kind, give Chocolate Eggs!"))

/*
/datum/round_event_control/rabbitrelease
	name = "Release the Rabbits!"
	holidayID = EASTER
	typepath = /datum/round_event/rabbitrelease
	weight = 5
	max_occurrences = 10
	category = EVENT_CATEGORY_HOLIDAY

/datum/round_event/rabbitrelease/announce(fake)
	priority_announce("Unidentified furry objects detected coming aboard [station_name()]. Beware of Adorable-ness.", "Fluffy Alert", 'sound/ai/aliens.ogg')

/datum/round_event/rabbitrelease/start()
	for(var/obj/effect/landmark/R in GLOB.landmarks_list)
		if(R.name != "blobspawn")
			if(prob(35))
				if(isspaceturf(R.loc))
					new /mob/living/simple_animal/chicken/rabbit/space(R.loc)
				else
					new /mob/living/simple_animal/chicken/rabbit(R.loc)
*/

/mob/living/simple_animal/chicken/rabbit
	name = "\improper rabbit"
	desc = "The hippiest hop around."
	icon = 'icons/mob/easter.dmi'
	icon_state = "rabbit_white"
	icon_living = "rabbit_white"
	icon_dead = "rabbit_white_dead"
	speak = list("Hop into Easter!","Come get your eggs!","Prizes for everyone!")
	speak_emote = list("sniffles","twitches")
	emote_hear = list("hops.")
	emote_see = list("hops around","bounces up and down")
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	egg_type = /obj/item/reagent_containers/food/snacks/egg/loaded
	food_type = /obj/item/reagent_containers/food/snacks/grown/carrot
	eggsleft = 10
	eggsFertile = FALSE
	icon_prefix = "rabbit"
	feedMessages = list("It nibbles happily.","It noms happily.")
	layMessage = list("hides an egg.","scampers around suspiciously.","begins making a huge racket.","begins shuffling.")

/mob/living/simple_animal/chicken/rabbit/space
	icon_prefix = "s_rabbit"
	icon_state = "s_rabbit_white"
	icon_living = "s_rabbit_white"
	icon_dead = "s_rabbit_white_dead"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1500
	unsuitable_atmos_damage = 0

//Easter Baskets
/obj/item/storage/bag/easterbasket
	name = "Easter Basket"
	icon = 'icons/mob/easter.dmi'
	icon_state = "basket"

/obj/item/storage/bag/easterbasket/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(/obj/item/reagent_containers/food/snacks/egg, /obj/item/reagent_containers/food/snacks/chocolateegg, /obj/item/reagent_containers/food/snacks/boiledegg))

/obj/item/storage/bag/easterbasket/proc/countEggs()
	cut_overlays()
	add_overlay("basket-grass")
	add_overlay("basket-egg[min(contents.len, 5)]")

/obj/item/storage/bag/easterbasket/Exited()
	. = ..()
	countEggs()

/obj/item/storage/bag/easterbasket/Entered()
	. = ..()
	countEggs()

//Bunny bag!
/obj/item/storage/backpack/satchel/bunnysatchel
	name = "Easter Bunny Satchel"
	desc = "Good for your eyes."
	icon_state = "satchel_carrot"
	item_state = "satchel_carrot"

//Egg prizes and egg spawns!
/obj/item/reagent_containers/food/snacks/egg
	var/containsPrize = FALSE

/obj/item/reagent_containers/food/snacks/egg/loaded
	containsPrize = TRUE

/obj/item/reagent_containers/food/snacks/egg/loaded/Initialize()
	. = ..()
	var/eggcolor = pick("blue","green","mime","orange","purple","rainbow","red","yellow")
	icon_state = "egg-[eggcolor]"

/obj/item/reagent_containers/food/snacks/egg/proc/dispensePrize(turf/where)
	var/won = pick(/obj/item/storage/backpack/satchel/bunnysatchel,
	/obj/item/reagent_containers/food/snacks/grown/carrot,
	/obj/item/toy/balloon,
	/obj/item/toy/gun,
	/obj/item/toy/sword,
	/obj/item/toy/talking/AI,
	/obj/item/toy/talking/owl,
	/obj/item/toy/talking/griffin,
	/obj/item/toy/minimeteor,
	/obj/item/toy/clockwork_watch,
	/obj/item/toy/toy_xeno,
	/obj/item/toy/foamblade,
	/obj/item/toy/prize/ripley,
	/obj/item/toy/prize/fireripley,
	/obj/item/toy/prize/deathripley,
	/obj/item/toy/prize/gygax,
	/obj/item/toy/prize/durand,
	/obj/item/toy/prize/marauder,
	/obj/item/toy/prize/seraph,
	/obj/item/toy/prize/touro,
	/obj/item/toy/prize/odysseus,
	/obj/item/toy/prize/phazon,
	/obj/item/toy/prize/reticence,
	/obj/item/toy/prize/honk,
	/obj/item/toy/plush/carpplushie,
	/obj/item/toy/plush/spider,
	/obj/item/toy/redbutton,
	/obj/item/toy/windupToolbox)
	new won(where)
	new/obj/item/reagent_containers/food/snacks/chocolateegg(where)

/obj/item/reagent_containers/food/snacks/egg/attack_self(mob/user)
	..()
	if(containsPrize)
		to_chat(user, span_notice("You unwrap [src] and find a prize inside!"))
		dispensePrize(get_turf(user))
		containsPrize = FALSE
		qdel(src)

//Easter Recipes + food
/obj/item/reagent_containers/food/snacks/hotcrossbun
	bitesize = 2
	name = "hot-cross bun"
	desc = "The Cross represents the Assistants that died for your sins."
	icon_state = "hotcrossbun"

/datum/crafting_recipe/food/hotcrossbun
	name = "Hot-Cross Bun"
	reqs = list(
		/obj/item/food/bread/plain = 1,
		/datum/reagent/consumable/sugar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/hotcrossbun
	subcategory = CAT_MISCFOOD

/obj/item/reagent_containers/food/snacks/scotchegg
	name = "scotch egg"
	desc = "A boiled egg wrapped in a delicious, seasoned meatball."
	icon_state = "scotchegg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 3
	filling_color = "#FFFFF0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)

/datum/crafting_recipe/food/scotchegg
	name = "Scotch egg"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/blackpepper = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1
	)
	result = /obj/item/reagent_containers/food/snacks/scotchegg
	subcategory = CAT_MISCFOOD

/obj/item/reagent_containers/food/snacks/soup/mammi
	name = "Mammi"
	desc = "A bowl of mushy bread and milk. It reminds you, not too fondly, of a bowel movement."
	icon_state = "mammi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)

/datum/crafting_recipe/food/mammi
	name = "Mammi"
	reqs = list(
		/obj/item/food/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/milk = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/mammi
	subcategory = CAT_MISCFOOD

/obj/item/reagent_containers/food/snacks/chocolatebunny
	name = "chocolate bunny"
	desc = "Contains less than 10% real rabbit!"
	icon_state = "chocolatebunny"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	filling_color = "#A0522D"

/datum/crafting_recipe/food/chocolatebunny
	name = "Chocolate bunny"
	reqs = list(
		/datum/reagent/consumable/sugar = 2,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chocolatebunny
	subcategory = CAT_MISCFOOD
