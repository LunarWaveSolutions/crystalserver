-- AvernusOT Progressive Stages Configuration
-- XP / Skills / Magic balanced for fast midgame and smooth high level curve

-- EXP STAGES
experienceStages = {
	-- Early game super boost
	{
		minlevel = 1,
		maxlevel = 7,
		multiplier = 5000,
	},
	-- Requested 20.000x between 8–100
	{
		minlevel = 8,
		maxlevel = 100,
		multiplier = 2000,
	},
	-- Soft decline as levels grow
	{
		minlevel = 101,
		maxlevel = 150,
		multiplier = 1000,
	},
	{
		minlevel = 151,
		maxlevel = 200,
		multiplier = 800,
	},
	{
		minlevel = 201,
		maxlevel = 300,
		multiplier = 600,
	},
	{
		minlevel = 301,
		maxlevel = 400,
		multiplier = 500,
	},
	{
		minlevel = 401,
		maxlevel = 500,
		multiplier = 200,
	},
	{
		minlevel = 501,
		multiplier = 100,
	},
}

-- SKILL STAGES
skillsStages = {
    {
        minlevel = 10,
        maxlevel = 60,
        multiplier = 40,    -- levemente maior que o teu, para acompanhar 2000x XP
    },
    {
        minlevel = 61,
        maxlevel = 100,
        multiplier = 30,    -- XP ainda turbo, skill precisa acompanhar
    },
    {
        minlevel = 101,
        maxlevel = 150,
        multiplier = 12,    -- bem mais coerente que 6
    },
    {
        minlevel = 151,
        maxlevel = 200,
        multiplier = 8,     -- em sintonia com XP 800–600x
    },
    {
        minlevel = 201,
        multiplier = 4,     -- queda suave, não machuca o late game
    },
}

-- MAGIC LEVEL STAGES
magicLevelStages = {
    {
        minlevel = 0,
        maxlevel = 50,
        multiplier = 40,     -- antes era 30, XP tá MUITO rápido
    },
    {
        minlevel = 51,
        maxlevel = 80,
        multiplier = 25,
    },
    {
        minlevel = 81,
        maxlevel = 100,
        multiplier = 15,     -- mais coerente com XP 1000x
    },
    {
        minlevel = 101,
        maxlevel = 130,
        multiplier = 8,      -- antes era 4, ficava muito baixo
    },
    {
        minlevel = 131,
        maxlevel = 170,
        multiplier = 5,
    },
    {
        minlevel = 171,
        multiplier = 3,      -- mesma decaída suave do skill
    },
}
