import <CONSUME.ash>
import <Rollover Management>

cli_execute("pull all");
cli_execute("refresh all");
use(1, $item[model train set]);
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
CONSUME("NIGHTCAP VALUE 3000 ALLOWLIFETIMELIMITED");
Rollover_Management();
int adv = my_adventures();
cli_execute("combo {adv}");