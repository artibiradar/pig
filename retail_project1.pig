--Load the monthly data from local into three bags

sales2000 = load '/home/hduser/2000.txt' using PigStorage(',') as (prod_id:long , product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double) ;

sales2001 = load '/home/hduser/2001.txt' using PigStorage(',') as (prod_id:long , product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double) ;

sales2002 = load '/home/hduser/2002.txt' using PigStorage(',') as (prod_id:long , product:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double) ;

--calculate annual sales by adding monthly sales of each year

totsales2000= foreach sales2000 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2000;
totsales2001= foreach sales2001 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2001;
totsales2002= foreach sales2002 generate prod_id, product, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2002;

 --dump totsales2000;
 --dump totsales2001;
 --dump totsales2002;


--combined data by joining bags of annnual sales of 2000,2001 and 2002

salescomb = join totsales2000 by $0, totsales2001 by $0, totsales2002 by $0;
salescomb_net = foreach salescomb generate $0,$1,$2,$5,$8;

--dump salescomb_net;

--calculate percentage changes in sales and average growth rate of sales

avgsales = foreach salescomb generate $0,$1,$2,$3,$4,((($3-$2)*100)/$2) as firstgrow,((($4-$3)*100)/$3) as secondgrow;

avgsales1 = foreach avgsales generate $0,$1,ROUND_TO((($2+$3)/2),2) as avgperc;

final = FILTER avgsales1 BY $2>=10.0;

--Following is the logic for avg drop

final1 = FILTER avgsales1 BY $2<=-5.00;


store final into '/home/hduser/folder5';
store final1 into '/home/hduser/folder6';




grandtotsales = foreach salescomb_net generate $0,$1,($2+$3+$4);

top5order = order grandtotsales by $2 desc;

finaltop5 = limit top5order 5;

--dump finaltop5;


bottom5order = order grandtotsales by $2;


finalbottom5 = limit bottom5order 5;

--dump finalbottom5;





