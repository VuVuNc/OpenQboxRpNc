return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
            {
                ped = `a_f_y_hipster_02`,
                scenario = 'WORLD_HUMAN_AA_COFFEE',
                loc = vec3(24.49, -1345.59, 28.5),
                heading = 266.09,
            },
			            {
                ped = `a_f_m_soucentmc_01`,
                scenario = 'WORLD_HUMAN_CLIPBOARD',
                loc = vec3(-3040.52, 584.05, 6.91),
                heading = 16.97,
            },
			{
                ped = `a_m_m_afriamer_01`,
                scenario = 'WORLD_HUMAN_SMOKING',
                loc = vec3(-3243.91, 1000.13, 11.83),
                heading = 353.51,
            },
			{
                ped = `a_m_m_malibu_01`,
                scenario = 'WORLD_HUMAN_SMOKING_POT',
                loc = vec3(1728.59, 6416.67, 34.04),
                heading = 244.36,
            },
			{
                ped = `a_m_m_skidrow_01`,
                scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
                loc = vec3(1697.36, 4923.41, 41.06),
                heading = 323.96,
            },
			{
                ped = `a_m_y_soucent_04`,
                scenario = 'WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT',
                loc = vec3(1959.33, 3741.4, 31.34),
                heading = 300.17,
            },
			{
                ped = `a_m_y_business_02`,
                scenario = 'WORLD_HUMAN_STAND_MOBILE',
                loc = vec3(549.24, 2669.75, 41.16),
                heading = 99.9,
            },
			{
                ped = `a_m_y_genstreet_0`,
                scenario = 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT',
                loc = vec3(2676.54, 3280.26, 54.24),
                heading = 326.95,
            },
			{
                ped = `a_m_y_eastsa_02`,
                scenario = 'WORLD_HUMAN_STRIP_WATCH_STAND',
                loc = vec3(2555.57, 380.82, 107.62),
                heading = 355.76,
            },
			{
                ped = `a_m_y_epsilon_01`,
                scenario = 'WORLD_HUMAN_JANITOR',
                loc = vec3(372.98, 328.01, 102.57),
                heading = 253.64,
            },
		}
	},

	Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'burger', price = 15 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'WEAPON_KNIFE', price = 200 },
			{ name = 'WEAPON_BAT', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 1000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{
                ped = `csb_mweather`,
                scenario = 'WORLD_HUMAN_SMOKING',
                loc = vec3(-662.21, -933.6, 20.83),
                heading = 179.52,
            },
			{
                ped = `mp_m_exarmy_01`,
                scenario = 'WORLD_HUMAN_SMOKING_POT',
                loc = vec3(810.27, -2159.05, 28.62),
                heading = 357.67,
            },
			{
                ped = `mp_m_weapexp_01`,
                scenario = 'WORLD_HUMAN_SMOKING',
                loc = vec3(vec3(1692.12, 3760.79, 33.71)),
                heading = 222.72,
            },
			{
                ped = `mp_m_avongoon`,
                scenario = 'WORLD_HUMAN_SMOKING_POT',
                loc = vec3(-331.71, 6084.97, 30.45),
                heading = 231.82,
            },
			{
                ped = `mp_f_chbar_01`,
                scenario = 'WORLD_HUMAN_STRIP_WATCH_STAND',
                loc = vec3(253.89, -50.24, 68.94),
                heading = 67.21,
            },
			{
                ped = `mp_m_exarmy_01`,
                scenario = 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT',
                loc = vec3(22.54, -1105.53, 28.8),
                heading = 159.49,
            },
			{
                ped = `mp_m_forgery_01`,
                scenario = 'WORLD_HUMAN_STRIP_WATCH_STAND',
                loc = vec3(2568.09, 292.64, 107.73),
                heading = 358.94,
            },
			{
                ped = `mp_m_waremech_01`,
                scenario = 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT',
                loc = vec3(-1119.07, 2699.63, 17.55),
                heading = 224.9,
            },
			{
                ped = `mp_m_weapwork_01`,
                scenario = 'WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT',
                loc = vec3(842.59, -1035.33, 27.19),
                heading = 359.3,
            }
		}
	},

	PoliceArmoury = {
		name = 'Police Armoury',
		groups = shared.police,
		blip = {
			id = 110, colour = 84, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'ammo-rifle', price = 5, },
			{ name = 'WEAPON_FLASHLIGHT', price = 200 },
			{ name = 'WEAPON_NIGHTSTICK', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 500, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
			{ name = 'WEAPON_CARBINERIFLE', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 3 },
			{ name = 'WEAPON_STUNGUN', price = 500, metadata = { registered = true, serial = 'POL'} }
		}, locations = {
			vec3(451.51, -979.44, 30.68)
		}, targets = {
			{ loc = vec3(453.21, -980.03, 30.68), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }
		}
	},

	Medicine = {
		name = 'Medicine Cabinet',
		groups = {
			['ambulance'] = 0
		},
		blip = {
			id = 403, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(306.3687, -601.5139, 43.28406)
		}, targets = {

		}
	},

	BlackMarketArms = {
		name = 'Black Market (Arms)',
		groups = {
			['ballas'] = 0
		},
		inventory = {
			{ name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
			{ name = 'ammo-rifle', price = 1000, currency = 'black_money' },
			{ name = 'ammo-rifle2', price = 1000, currency = 'black_money' }
		}, locations = {
			vec3(309.09, -913.75, 56.46)
		}, targets = {
			{
                ped = `g_m_y_ballaorig_01`,
                scenario = 'WORLD_HUMAN_COP_IDLES',
                loc = vec3(100.93, -1958.82, 19.79),
                heading = 350.68,
            },

		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	}
}
