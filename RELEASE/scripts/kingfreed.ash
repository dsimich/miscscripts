//buy and use daily passes
boolean buyPasses(string tattoo, boolean quick)
{
	if(quick)
	{
		return false;
	}
	int startPriceLimit = get_property("autoBuyPriceLimit").to_int();
	item[string] tattoopass = {
		"redrogertat": $item[PirateRealm guest pass],
		"ltttat": $item[inflatable LT&T telegraph office],
		"sbreaktat": $item[One-day ticket to Spring Break Beach],
		"walmarttat": $item[One-day ticket to The Glaciest],
		"merctat": $item[One-day ticket to Conspiracy Island],
		"frpass": $item[FantasyRealm guest pass],
		"gingercitytat": $item[Counterfeit city],
		"debbietat": $item[One-day ticket to That 70s Volcano]
	};
	boolean[string] passUsed = {
		"redrogertat": get_property("_prToday").to_boolean(),
		"ltttat": get_property("_telegraphOfficeToday").to_boolean(),
		"sbreaktat": get_property("_sleazeAirportToday").to_boolean(),
		"walmarttat": get_property("_coldAirportToday").to_boolean(),
		"merctat": get_property("_spookyAirportToday").to_boolean(),
		"frpass": get_property("_frToday").to_boolean(),
		"gingercitytat": get_property("gingerbreadCityAvailable").to_boolean(),
		"debbietat": get_property("_hotAirportToday").to_boolean()
	};
	if(passUsed[tattoo])
	{
		print("Don't need to buy a " + tattoopass[tattoo] + " to get " + tattoo + " because it was already used");
		return false;
	}
	if(item_amount(tattoopass[tattoo]) == 0)
	{
		if(mall_price(tattoopass[tattoo]) > startPriceLimit)
		{
			set_property("autoBuyPriceLimit", mall_price(tattoopass[tattoo]) + 1);
			buy(1, tattoopass[tattoo]);
			set_property("autoBuyPriceLimit", startPriceLimit);
		}
		else
		{
			print("Trying to buy a " + tattoopass[tattoo] + " to get " + tattoo);
			buy(1, tattoopass[tattoo]);
		}
	}
	return use(tattoopass[tattoo]);
}

void get_tattoos(string[int] tattoos, boolean quick)
{
	if(!quick)
	{
		return;
	}

	foreach i, tat in tattoos
	{
		if(contains_text(tat, "redrogertat"))
		{
			cli_execute(`PirateRealm skull cemetary fortress`);
		}
		if(contains_text(tat,"ltttat"))
		{
			set_property("telegraphOfficeAvailable", true);
			cli_execute(`telegram`);
		}
	}
	return;
}

void farm(int turns, boolean quick, string target)
{
	turns = -turns;
	//Turns is turns remaining
	//Time-Twitching Tower is available
	if(can_adventure($location[The Primordial Stew]))
	{
		set_property("valueOfAdventure", 12000);
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick {turns} target={target}`);
		}
		else
		{
			cli_execute(`garbo nobarf candydish ascend {turns} target={target}`);
		}
		cli_execute(`chrono mode=soup`);
	}
	else if(holiday() == "Halloween") //Today is Halloween
	{
		set_property("valueOfAdventure", 12000);
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick {turns} target={target}`);
		}
		else
		{
			cli_execute(`garbo nobarf candydish ascend {turns} target={target}`);
		}
		cli_execute(`freecandy`);
	}
	else //Nothing special
	{
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick {turns} target={target}`);
		}
		else
		{
			cli_execute(`garbo candydish ascend {turns} target="cockroach"`);
		}
	}
	return;
}

void main()
{
	cli_execute("pull all");
	cli_execute("refresh all");
	if(!(get_campground() contains $item[model train set]))
	{
		use(1, $item[model train set]);
	}
	set_property("valueOfAdventure", 7000);
	int warning_time = 180 * 60;
	int remaining_time = rollover() - (now_to_int()/1000);
	boolean quick = remaining_time < warning_time;

	string target = "cockroach";
	//get some tattoos
	string tats = "redrogertat"; //Dynamic this eventually
	string[int] gettats = split_string(tats, ",");
	if(count(gettats) > 0)
	{
		foreach i, tat in gettats
		{
			buyPasses(gettats[i], quick);
		}
	}
	if(my_adventures() < count(gettats)*40)
	{
		farm(count(gettats)*40, quick, target);
	}
	get_tattoos(gettats, quick);
	farm(0, quick, target);

	set_property("valueOfAdventure", 7000);
	cli_execute("pvp_mab.js");
	cli_execute("drink stillsuit distillate");
	if(quick)
	{
		cli_execute("CONSUME NIGHTCAP");
	}
	else
	{
		cli_execute("CONSUME NIGHTCAP VALUE 3000 ALLOWLIFETIMELIMITED");
	}
	cli_execute("Rollover Management");
	int adv = my_adventures();
	int borrowedTime = 0;
	if(get_property("_borrowedTimeUsed").to_boolean())
	{
		borrowedTime = 20;
	}
	if(adv > 0)
	{
		int comboadv;
		if(40 - borrowedTime + numeric_modifier( "adventures" ) + adv > 200)
		{
			comboadv = 40 - borrowedTime + numeric_modifier( "adventures" ) + adv - 200;
		}
		else
		{
			comboadv = adv;
		}
		cli_execute(`combo {comboadv}`);
	}
	if(item_amount($item[raffle ticket]) == 0)
	{
		cli_execute(`raffle 100`);
	}
}