  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_OIC_PRO_RATE" (i_item_date date
					,i_period_start_date date
					,i_period_end_date date
					,i_period_type varchar2 -- Day, Week, Month, Qtr
					) return number
is
v_dummy		number;
begin
	if i_item_date <= i_period_start_date
	then
		return 0;
	elsif i_item_date >= i_period_end_date
	then
		return 1;
	else
		if upper(i_period_type) = 'D' -- day
		then
			return (to_char(i_item_date,'J') - to_char(i_period_start_date,'J'))
				/ (to_char(i_period_end_date,'J') - to_char(i_period_start_date,'J'));
		elsif upper(i_period_type) = 'W' -- Week
		then
			return trunc((to_char(i_item_date,'J') - to_char(i_period_start_date,'J'))/7)
				/ trunc((to_char(i_period_end_date,'J') - to_char(i_period_start_date,'J'))/7);
		elsif upper(i_period_type) = 'M' -- Month
		then
			return (to_char(i_item_date,'MM') - to_char(i_period_start_date,'MM') +
				12*(to_char(i_item_date,'RRRR') - to_char(i_period_start_date,'RRRR')))
				/ (to_char(i_period_end_date,'MM') - to_char(i_period_start_date,'MM') +
				12*(to_char(i_period_end_date,'RRRR') - to_char(i_period_start_date,'RRRR')));
		elsif upper(i_period_type) = 'Q' -- Qtr
		then
			return (to_char(i_item_date,'Q') - to_char(i_period_start_date,'Q') +
				4*(to_char(i_item_date,'RRRR') - to_char(i_period_start_date,'RRRR')))
				/ (to_char(i_period_end_date,'Q') - to_char(i_period_start_date,'Q') +
				4*(to_char(i_period_end_date,'RRRR') - to_char(i_period_start_date,'RRRR')));
		else
			return 0;
		end if;
	end if;
end;
/
