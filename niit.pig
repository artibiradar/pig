cust = load '/home/hduser/custs' using PigStorage(',') as (custno:chararray,firstname,lastname,age:int,profession:chararray);
dump cust;
custcount = foreach custs generate group count(profession,tuple);
groupbyprofession = group cust by profession;
countbyprofession = foreach groupbyprofession generate group as profession,COUNT(cust) as headcount;
dump countbyprofession;
orderbycount = generate countbyprofession by headcount desc;
store orderbycount into 'niit/pig/part2' using pigstorage(',');
