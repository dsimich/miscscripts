cli_execute("pull all");
cli_execute("refresh all");
if(!(get_campground() contains $item[model train set]))
{
	use(1, $item[model train set]);
}
set_property("valueOfAdventure", 6000);
if(inebriety_limit() - my_inebriety() < 5 || fullness_limit() - my_fullness() < 5)
{
	abort("Figure out what you want to do yourself, you have limited organs left.");
}
int warning_time = 180 * 60;
int remaining_time = rollover() - (now_to_int()/1000);
boolean quick = remaining_time < warning_time;

//get some tattoos
string gettats; //Dynamic this eventually
gettats = $strings["redrogertat", "ltttat"];
if(gettats != "")
{
	foreach tat in gettats
	{
		buyPasses(tat, quick);
	}
}
if(my_adventures() < count(gettats)*40)
{
	farm(count(gettats)*40, quick);
}
get_tattoos(gettats, quick);
farm(0, quick);

set_property("valueOfAdventure", 6000);
cli_execute("PVP_MAB.js");
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

//buy and use daily passes
boolean buyPasses(string tattoo, boolean quick)
{
	if(!quick)
	{
		return false;
	}
	int startPriceLimit = get_property("autoBuyPriceLimit").to_int();
	item[string] tattoopass;
	tattoopass["redrogertat"] = $item[PirateRealm guest pass];
	tattoopass["ltttat"] = $item[inflatable LT&T telegraph office];
	tattoopass["sbreaktat"] = $item[One-day ticket to Spring Break Beach];
	tattoopass["walmarttat"] = $item[One-day ticket to The Glaciest];
	tattoopass["merctat"] = $item[One-day ticket to Conspiracy Island];
	tattoopass["frpass"] = $item[FantasyRealm guest pass];
	tattoopass["gingercitytat"] = $item[Counterfeit city];
	tattoopass["debbietat"] = $item[One-day ticket to That 70s Volcano];
	if(item_amount(tattoopass[tattoo]) == 0)
	{
		if(mall_price(tattoopass[tattoo]) > startPriceLimit)
		{
			set_property("autoBuyPriceLimit", mall_price(tattoopass[tattoo]) + 1);
			retrieve_item(1, tattoopass[tattoo]);
			set_property("autoBuyPriceLimit", startPriceLimit);
		}
		else
		{
			retrieve_item(1, tattoopass[tattoo]);
		}
	}
	use(tattoopass[tattoo]);
}

boolean get_tattoos(string tattoos, boolean quick)
{
	if(!doit || !quick)
	{
		return false;
	}

	foreach tat in tattoos
	{
		if(!contains_text(tat,"redrogertat"))
		{
			cli_execute(`piraterealm glass cemetary temple`);
		}
		if(!contains_text(tat,"ltttat"))
		{
			cli_execute(`telegram`);
		}
	}
}

boolean farm(int turns, boolean quick)
{
	//Turns is turns remaining
	//Time-Twitching Tower is available
	if(can_adventure($location[The Primordial Stew]))
	{
		set_property("valueOfAdventure", 12000);
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick -{turns}`);
		}
		else
		{
			cli_execute(`garbo nobarf candydish ascend -{turns}`);
		}
		cli_execute("chrono mode=soup -{turns}");
	}
	else if(holiday() == "Halloween") //Today is Halloween
	{
		set_property("valueOfAdventure", 12000);
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick -{turns}`);
		}
		else
		{
			cli_execute("garbo nobarf candydish ascend -{turns}");
		}
		cli_execute("freecandy -{turns}");
	}
	else //Nothing special
	{
		if(quick)
		{
			cli_execute(`garbo nobarf candydish quick -{turns}`);
		}
		else
		{
			cli_execute("garbo candydish ascend -{turns}");
		}
	}
}