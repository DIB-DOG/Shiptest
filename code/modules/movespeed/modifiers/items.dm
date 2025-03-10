/datum/movespeed_modifier/jetpack
	conflicts_with = MOVE_CONFLICT_JETPACK
	movetypes = FLOATING

/datum/movespeed_modifier/jetpack/cybernetic
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/jetpack/fullspeed
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/die_of_fate
	multiplicative_slowdown = 1

/datum/movespeed_modifier/gun
	multiplicative_slowdown = 1
	variable = TRUE

/datum/movespeed_modifier/aiming
	multiplicative_slowdown = 0
	variable = TRUE

/datum/movespeed_modifier/berserk
	multiplicative_slowdown = -0.2

/datum/movespeed_modifier/sphere
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/equipping
	multiplicative_slowdown = 1.5
