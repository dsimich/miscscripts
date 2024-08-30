cli_execute("pull all");
cli_execute("refresh all");
if(!(get_campground() contains $item[model train set]))
{
	use(1, $item[model train set]);
}
set_property("valueOfAdventure", 6000);
//Time-Twitching Tower is available
if(can_adventure($location[The Primordial Stew]))
{
	set_property("valueOfAdventure", 12000);
	cli_execute("garbo nobarf candydish ascend");
	cli_execute("chrono mode=soup");
}
else if(holiday() == "Halloween") //Today is Halloween
{
	set_property("valueOfAdventure", 12000);
	cli_execute("garbo nobarf candydish ascend");
	cli_execute("freecandy");
}
else //Nothing special
{
	cli_execute("garbo candydish ascend");
}
set_property("valueOfAdventure", 6000);
cli_execute("PVP_MAB.js");
cli_execute("drink stillsuit distillate");
cli_execute("CONSUME NIGHTCAP VALUE 3000 ALLOWLIFETIMELIMITED");
cli_execute("Rollover Management");
int adv = my_adventures();
if(adv > 0)
{
	cli_execute(`combo {adv}`);
}
if(item_amount($item[raffle ticket]) == 0)
{
	cli_execute(`raffle 100`);
}