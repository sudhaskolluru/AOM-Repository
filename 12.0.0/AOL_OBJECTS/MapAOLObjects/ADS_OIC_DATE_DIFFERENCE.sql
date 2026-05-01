  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_OIC_DATE_DIFFERENCE" (i_date_1 date
						,i_date_2 date
						,i_period_type varchar2 -- Day, Week, Month, Qtr
						) return number
is
v_dummy		number;
begin
	if i_date_1 >= i_date_2
	then
		return 0;
	else
		if upper(i_period_type) = 'D' -- day
		then
			return (to_char(i_date_2,'J') - to_char(i_date_1,'J'));
		elsif upper(i_period_type) = 'W' -- Week
		then
			return ((to_char(i_date_2,'J') - to_char(i_date_1,'J'))/7);
		elsif upper(i_period_type) = 'M' -- Month
		then
			return (to_char(i_date_2,'MM') - to_char(i_date_1,'MM') +
				12*(to_char(i_date_2,'RRRR') - to_char(i_date_1,'RRRR')));
		elsif upper(i_period_type) = 'Q' -- Qtr
		then
			return (to_char(i_date_2,'Q') - to_char(i_date_1,'Q') +
				4*(to_char(i_date_2,'RRRR') - to_char(i_date_1,'RRRR')));
		else
			return 0;
		end if;
	end if;
end;
/
