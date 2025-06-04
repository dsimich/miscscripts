void main()
{
    int hat_multiplier = 1;
    int pant_multiplier = 2;
    if(have_skill($skill[Tao of the Terrapin]))
    {
        hat_multiplier += 1;
        pant_multiplier += 1;
    }
    if(have_effect($effect[Hammertime]) > 0)
    {
        pant_multiplier += 4;
    }
    int hat_power = cli_execute(`js Item.all().filter(x => toSlot(x) == Slot.get("hat")).filter(x => equippedAmount(x) == 1).map(x => getPower(x)).reduce((a, b) => a + b, 0)`).to_int();
    hat_power = hat_power * hat_multiplier;
    int pant_power = cli_execute(`js Item.all().filter(x => toSlot(x) == Slot.get("pants")).filter(x => equippedAmount(x) == 1).map(x => getPower(x)).reduce((a, b) => a + b, 0)`).to_int();
    pant_power = pant_power * pant_multiplier;
    int shirt_power = cli_execute(`Item.all().filter(x => toSlot(x) == Slot.get("shirt")).filter(x => equippedAmount(x) == 1).map(x => getPower(x)).reduce((a, b) => a + b, 0)`).to_int();
    print("Total Power: " hat_power + pant_power + shirt_power);
}