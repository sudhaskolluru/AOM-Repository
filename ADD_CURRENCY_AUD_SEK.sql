update  FND_CURRENCIES_VL 
set enabled_flag = 'Y' where currency_code in ('AUD','SEK');
delete from XXTPI.XXTPI_IMPORTED_DAILY_RATES where cur = 'EUR';
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, MONTHEND, 
    XML_POS, INSERT_DAY)
 Values
   ('EUR', 'AUD', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'Y', 
    'A2', 1);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, XML_POS, 
    INSERT_DAY)
 Values
   ('EUR', 'CHF', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'A3', 
    0);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, XML_POS, 
    INSERT_DAY)
 Values
   ('EUR', 'DKK', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'A4', 
    0);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, XML_POS, 
    INSERT_DAY)
 Values
   ('EUR', 'GBP', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'A5', 
    0);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, XML_POS, 
    INSERT_DAY)
 Values
   ('EUR', 'MXN', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'A6', 
    0);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, MONTHEND, 
    XML_POS, INSERT_DAY)
 Values
   ('EUR', 'PLN', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'Y', 
    'A6', 1);
Insert into XXTPI.XXTPI_IMPORTED_DAILY_RATES
   (CUR, FROM_CUR, EMAIL, SOURCE, MONTHEND, 
    XML_POS, INSERT_DAY)
 Values
   ('EUR', 'SEK', 'TPI_US_Rate_Import@tpicomposites.com; iunak@tpicomposites.com', 'OANDA', 'Y', 
    'A7', 1);    
COMMIT;
