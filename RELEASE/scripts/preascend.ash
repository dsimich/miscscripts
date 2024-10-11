if(item_amount($item[toast]) > 0)
{
  cli_execute(`acquire ` + item_amount($item[toast]) + ` toast`);
  cli_execute(`csend `  + item_amount($item[toast]) + ` toast to gausie`);
}

if(item_amount($item[stuffed cocoabo]) > 0)
{
  cli_execute(`acquire ` + item_amount($item[stuffed cocoabo]) + ` stuffed cocoabo`);
  cli_execute(`csend ` + item_amount($item[stuffed cocoabo]) + ` stuffed cocoabo to holatuwol`);
}

foreach it in $items[Deep Dish of Legend, Calzone of Legend, Pizza of Legend] {
  if(item_amount(it) == 0)  retrieve_item(1, it);
}
foreach it in $items[Baked Veggie Ricotta Casserole, Plain Calzone, Roasted Vegetable Focaccia, Pete's Rich Ricotta, Roasted Vegetable of Jarlsberg, Boris's Bread] {
  if(item_amount(it) < 3)  retrieve_item(3 - item_amount(it), it);
}

if(item_amount($item[Instant Karma]) > 0)
{
  while (item_amount($item[Instant Karma]) > 0)
  {
    visit_url("inventory.php?which=1&action=discard&pwd&whichitem=4448");
  }
}
