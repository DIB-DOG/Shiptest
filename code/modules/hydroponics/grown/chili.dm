// Chili
/obj/item/seeds/chili
	name = "pack of chili seeds"
	desc = "These seeds grow into chili plants. HOT! HOT! HOT!"
	icon_state = "seed-chili"
	species = "chili"
	plantname = "Chili Plants"
	product = /obj/item/food/grown/chili
	lifespan = 20
	maturation = 5
	production = 5
	yield = 4
	potency = 45
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "chili-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "chili-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/chili/ice, /obj/item/seeds/chili/ghost)
	reagents_add = list(/datum/reagent/consumable/capsaicin = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/chili
	seed = /obj/item/seeds/chili
	name = "chili"
	desc = "It's spicy! Wait... IT'S BURNING ME!!"
	icon_state = "chilipepper"
	filling_color = "#FF0000"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	wine_power = 20
	wine_flavor = "a lake of fire" //WS edit: new wine flavors

// Ice Chili
/obj/item/seeds/chili/ice
	name = "pack of chilly pepper seeds"
	desc = "These seeds grow into chilly pepper plants."
	icon_state = "seed-icepepper"
	species = "chiliice"
	plantname = "Chilly Pepper Plants"
	product = /obj/item/food/grown/icepepper
	lifespan = 25
	maturation = 4
	production = 4
	rarity = 20
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/frostoil = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/consumable/nutriment = 0.02)
	research = PLANT_RESEARCH_TIER_2

/obj/item/food/grown/icepepper
	seed = /obj/item/seeds/chili/ice
	name = "chilly pepper"
	desc = "It's a mutant strain of chili."
	icon_state = "icepepper"
	bite_consumption_mod = 5
	foodtypes = FRUIT
	wine_power = 30
	wine_flavor = "the 8th circle of hell" //WS edit: new wine flavors

// Ghost Chili
/obj/item/seeds/chili/ghost
	name = "pack of ghost chili seeds"
	desc = "These seeds grow into a chili said to be the hottest in the galaxy."
	icon_state = "seed-chilighost"
	species = "chilighost"
	plantname = "Ghost Chili Plants"
	product = /obj/item/food/grown/ghost_chili
	endurance = 10
	maturation = 10
	production = 10
	yield = 3
	rarity = 20
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/condensedcapsaicin = 0.3, /datum/reagent/consumable/capsaicin = 0.55, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/sodium = 0.10)
	research = PLANT_RESEARCH_TIER_2

/obj/item/food/grown/ghost_chili
	seed = /obj/item/seeds/chili/ghost
	name = "ghost chili"
	desc = "It seems to be vibrating gently."
	icon_state = "ghostchilipepper"
	var/mob/living/carbon/human/held_mob
	bite_consumption_mod = 5
	foodtypes = FRUIT
	wine_power = 50
	wine_flavor = "burning regret and the veil growing thinner" //WS edit: new wine flavors

/obj/item/food/grown/ghost_chili/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(ismob(loc))
		held_mob = loc
		START_PROCESSING(SSobj, src)

/obj/item/food/grown/ghost_chili/process()
	if(held_mob && loc == held_mob)
		if(held_mob.is_holding(src))
			if(istype(held_mob) && held_mob.gloves)
				return
			held_mob.adjust_bodytemperature(1 * TEMPERATURE_DAMAGE_COEFFICIENT)
			if(prob(10))
				to_chat(held_mob, span_warning("Your hand holding [src] burns!"))
	else
		held_mob = null
		..()
