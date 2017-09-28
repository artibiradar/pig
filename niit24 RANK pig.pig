emp = LOAD '/home/hduser/emp.csv' USING PigStorage(',') as (id:int,name:chararray,age:int,gender:chararray,salary:long);

emp_rank = RANK emp by $4 DESC;

emp_dense = RANK emp by $4 DESC DENSE;

store emp_rank into '/home/hduser/niit/pig/rank' USING PigStorage(',');

store emp_dense into '/home/hduser/niit/pig/dense' USING PigStorage(',');

