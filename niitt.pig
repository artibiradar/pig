txn = load 'txns1.txt' using PigStorage(',') as (txnid,txndate,custno:chararray,amount:double,cat,prod,city,state,type);
dump txn;
