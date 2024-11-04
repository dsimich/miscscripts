cli_execute("pull all");
cli_execute("refresh all");
if(!(get_campground() contains $item[model train set]))
{
	use(1, $item[model train set]);
}
set_property("valueOfAdventure", 6000);
if(inebrity_limit() - my_inebriety() < 5 || fullness_limit() - my_fullness() < 5)
{
	abort("Figure out what you want to do yourself, you have limited organs left.");
}
int warning_time = 180 * 60;
int remaining_time = rollover() - (now_to_int()/1000);
boolean quick = remaining_time < warning_time;
//get some tattoos
string tattoos = visit_url("account_tattoos.php");
string monorail = visit_url("place.php?whichplace=monorail");
int startPriceLimit = get_property("autoBuyPriceLimit").to_int();
if(!contains_text(tattoos,"redrogertat") && !quick)
{
	if(!contains_text(monorail, "PirateRealm"))
	{
		if(item_amount($item[PirateRealm guest pass]) == 0)
		{
			if(mall_price($item[PirateRealm guest pass]) > startPriceLimit)
			{
				set_property("autoBuyPriceLimit", mall_price($item[PirateRealm guest pass]) + 1);
				retrieve_item(1, $item[PirateRealm guest pass]);
				set_property("autoBuyPriceLimit", startPriceLimit);
			}
			else
			{
				retrieve_item(1, $item[PirateRealm guest pass]);
			}
		}
		use($item[PirateRealm guest pass]);
	}
	cli_execute(`piraterealm glass cemetary temple`);
}
if(!contains_text(tattoos,"ltttat") && !quick)
{
	if(!get_property("telegraphOfficeAvailable").to_boolean())
	{
		if(mall_price($item[inflatable LT&T telegraph office]) > startPriceLimit)
		{
			set_property("autoBuyPriceLimit", mall_price($item[inflatable LT&T telegraph office]) + 1);
			retrieve_item(1, $item[inflatable LT&T telegraph office]);
			set_property("autoBuyPriceLimit", startPriceLimit);
		}
		else
		{
			retrieve_item(1, $item[inflatable LT&T telegraph office]);
		}
		use($item[inflatable LT&T telegraph office]);
	}
	cli_execute(`telegram`);
}
//Time-Twitching Tower is available
if(can_adventure($location[The Primordial Stew]))
{
	set_property("valueOfAdventure", 12000);
	if(quick)
	{
		cli_execute(`garbo nobarf candydish quick`);
	}
	else
	{
		cli_execute(`garbo nobarf candydish ascend`);
	}
	cli_execute("chrono mode=soup");
}
else if(holiday() == "Halloween") //Today is Halloween
{
	set_property("valueOfAdventure", 12000);
	if(quick)
	{
		cli_execute(`garbo nobarf candydish quick`);
	}
	else
	{
		cli_execute("garbo nobarf candydish ascend");
	}
	cli_execute("freecandy");
}
else //Nothing special
{
	if(quick)
	{
		cli_execute(`garbo nobarf candydish quick`);
	}
	else
	{
		cli_execute("garbo candydish ascend");
	}
}
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