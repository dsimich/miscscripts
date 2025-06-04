void main()
{
    int hat_multiplier = 1;
    int pant_multiplier = 1;
    if(have_skill($skill[Tao of the Terrapin]))
    {
        hat_multiplier += 1;
        pant_multiplier += 1;
    }
    if(have_effect($effect[Hammertime]) > 0)
    {
        pant_multiplier += 3;
    }
    int hat_power;
    boolean hatrack_fam = false;
    if(my_familiar() == $familiar[mad hatrack])
    {
        hatrack_fam = true;
    }
    if(hatrack_fam)
    {
        use_familiar($familiar[none]);
    }
    foreach h in $items[]
    {
        if((to_slot(h) == $slot[hat]) && (equipped_amount(h) >= 1))
        {
            hat_power += get_power(h);
        }
    }
    if(hatrack_fam)
    {
        use_familiar($familiar[mad hatrack]); //re-equip hatrack
    }
    hat_power = hat_power * hat_multiplier;
    int pant_power = get_power(equipped_item($slot[pants]));
    pant_power = pant_power * pant_multiplier;
    int shirt_power = get_power(equipped_item($slot[shirt]));
    int total_power = hat_power + pant_power + shirt_power;
    int expected_da = total_power / 5;
    if(total_power > 1126)
    {
        expected_da = (1126 + (total_power - 1126) ** 0.8) / 5;
    }
    if(hatrack_fam)
    {
        print("Hat Power does not include what's on the Hatrack");
    }
    print("Hat Power: " + hat_power);
    print("Pant Power: " + pant_power);
    print("Shirt Power: " + shirt_power);
    print("Total Power: " + total_power);
    print("Expected DA: " + expected_da);
}