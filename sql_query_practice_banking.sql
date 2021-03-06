CREATE DATABASE finance_db;
USE finance_db;

CREATE TABLE customer
   (
       custid VARCHAR(6),
       fname VARCHAR(30),
       mname VARCHAR(30),
       ltname VARCHAR(30),
       city VARCHAR(15),
       mobileno VARCHAR(10),
       occupation VARCHAR(10),
       dob DATE,
      CONSTRAINT customer_custid_pk PRIMARY KEY(custid)   
   );   

CREATE TABLE branch(
bid VARCHAR(6),
bname VARCHAR(30),
bcity VARCHAR(30),
CONSTRAINT branch_bid_pk PRIMARY KEY(bid)
);


CREATE TABLE account
   (
      acnumber VARCHAR(6),
      custid  VARCHAR(6),
      bid VARCHAR(6),
      opening_balance INT(7),
      aod DATE,
      atype VARCHAR(10),
      astatus VARCHAR(10),
      CONSTRAINT account_acnumber_pk PRIMARY KEY(acnumber),
      CONSTRAINT account_custid_fk FOREIGN KEY(custid) REFERENCES customer(custid),
      CONSTRAINT account_bid_fk FOREIGN KEY(bid) REFERENCES branch(bid) 
    );

CREATE TABLE trandetails
    (   
     tnumber VARCHAR(6),
     acnumber VARCHAR(6),
     dot DATE,
     medium_of_transaction VARCHAR(20),
     transaction_type VARCHAR(20),
     transaction_amount INT(7),    
     CONSTRAINT trandetails_tnumber_pk PRIMARY KEY(tnumber),
     CONSTRAINT trandetails_acnumber_fk FOREIGN KEY(acnumber) REFERENCES account(acnumber)  
    );
 
CREATE TABLE loan
   (
   
    custid VARCHAR(6),
    bid VARCHAR(6),
    loan_amount INT(7),
    CONSTRAINT loan_customer_custid_bid_pk PRIMARY KEY(custid,bid),
    CONSTRAINT loan_custid_fk FOREIGN KEY(custid) REFERENCES  customer(custid),
    CONSTRAINT loan_bid_fk FOREIGN KEY(bid) REFERENCES  branch(bid)
   );

INSERT INTO customer VALUES('C00001','Ramesh','Chandra','Sharma','Delhi','9543198345','Service','1976-12-06');
INSERT INTO customer VALUES('C00002','Avinash','Sunder','Minha','Delhi','9876532109','Service','1974-10-16');
INSERT INTO customer VALUES('C00003','Rahul',null,'Rastogi','Delhi','9765178901','Student','1981-09-26');
INSERT INTO customer VALUES('C00004','Parul',null,'Gandhi','Delhi','9876532109','Housewife','1976-11-03');
INSERT INTO customer VALUES('C00005','Naveen','Chandra','Aedekar','Mumbai','8976523190','Service','1976-09-19');
INSERT INTO customer VALUES('C00006','Chitresh',null,'Barwe','Mumbai','7651298321','Student','1992-11-06');
INSERT INTO customer VALUES('C00007','Amit','Kumar','Borkar','Mumbai','9875189761','Student','1981-09-06');
INSERT INTO customer VALUES('C00008','Nisha',null,'Damle','Mumbai','7954198761','Service','1975-12-03');
INSERT INTO customer VALUES('C00009','Abhishek',null,'Dutta','Kolkata','9856198761','Service','1973-05-22');
INSERT INTO customer  VALUES('C00010','Shankar',null,'Nair','Chennai','8765489076','Service','1976-07-12');

INSERT INTO branch VALUES('B00001','Asaf ali road','Delhi');
INSERT INTO branch VALUES('B00002','New delhi main branch','Delhi');
INSERT INTO branch VALUES('B00003','Delhi cantt','Delhi');
INSERT INTO branch VALUES('B00004','Jasola','Delhi');
INSERT INTO branch VALUES('B00005','Mahim','Mumbai');
INSERT INTO branch VALUES('B00006','Vile parle','Mumbai');
INSERT INTO branch VALUES('B00007','Mandvi','Mumbai');
INSERT INTO branch VALUES('B00008','Jadavpur','Kolkata');
INSERT INTO branch VALUES('B00009','Kodambakkam','Chennai');

INSERT INTO account VALUES('A00001','C00001','B00001',1000,'2012-12-15','Saving','Active');
INSERT INTO account VALUES('A00002','C00002','B00001',1000,'2012-06-12','Saving','Active');
INSERT INTO account VALUES('A00003','C00003','B00002',1000,'2012-05-17','Saving','Active');
INSERT INTO account VALUES('A00004','C00002','B00005',1000,'2013-01-27','Saving','Active');
INSERT INTO account VALUES('A00005','C00006','B00006',1000,'2012-12-17','Saving','Active');
INSERT INTO account VALUES('A00006','C00007','B00007',1000,'2010-08-12','Saving','Suspended');
INSERT INTO account VALUES('A00007','C00007','B00001',1000,'2012-10-02','Saving','Active');
INSERT INTO account VALUES('A00008','C00001','B00003',1000,'2009-11-09','Saving','Terminated');
INSERT INTO account VALUES('A00009','C00003','B00007',1000,'2008-11-30','Saving','Terminated');
INSERT INTO account VALUES('A00010','C00004','B00002',1000,'2013-03-01','Saving','Active');

INSERT INTO trandetails VALUES('T00001','A00001','2013-01-01','Cheque','Deposit',2000);
INSERT INTO trandetails VALUES('T00002','A00001','2013-02-01','Cash','Withdrawal',1000);
INSERT INTO trandetails VALUES('T00003','A00002','2013-01-01','Cash','Deposit',2000);
INSERT INTO trandetails VALUES('T00004','A00002','2013-02-01','Cash','Deposit',3000);
INSERT INTO trandetails VALUES('T00005','A00007','2013-01-11','Cash','Deposit',7000);
INSERT INTO trandetails VALUES('T00006','A00007','2013-01-13','Cash','Deposit',9000);
INSERT INTO trandetails VALUES('T00007','A00001','2013-03-13','Cash','Deposit',4000);
INSERT INTO trandetails VALUES('T00008','A00001','2013-03-14','Cheque','Deposit',3000);
INSERT INTO trandetails VALUES('T00009','A00001','2013-03-21','Cash','Withdrawal',9000);
INSERT INTO trandetails VALUES('T00010','A00001','2013-03-22','Cash','Withdrawal',2000);
INSERT INTO trandetails VALUES('T00011','A00002','2013-03-25','Cash','Withdrawal',7000);
INSERT INTO trandetails VALUES('T00012','A00007','2013-03-26','Cash','Withdrawal',2000);
    
INSERT INTO loan VALUES('C00001','B00001',100000);
INSERT INTO loan VALUES('C00002','B00002',200000);
INSERT INTO loan VALUES('C00009','B00008',400000);
INSERT INTO loan VALUES('C00010','B00009',500000);
INSERT INTO loan VALUES('C00001','B00003',600000);
INSERT INTO loan VALUES('C00002','B00001',600000);

/*Problem #1:
Write a query to display the customer number , firstname, customer’s date of birth . Display in a sorted order of date of birth year 
and within that sort by firstname.*/
SELECT custid, fname, dob FROM customer ORDER BY dob, fname;


/*Problem #2:
Write a query to display customer’s number, first name and middle name. The customer’s who don’t have middle name, 
for them display the last name. Give the alias name as Cust_Name.*/
SELECT custid, concat(concat(fname, ' '),coalesce(mname, ltname)) as Cust_Name
FROM customer;


/*Problem #3:
Write a query to display account number, customer’s number, customer’s firstname,lastname,account opening date.*/
SELECT a.acnumber, a.custid, c.fname,a.aod
FROM account a, customer c
WHERE a.custid = c.custid;

/*Problem # 4:
Write a query to display the number of customer’s from Delhi. Give the count an alias name of Cust_Count.*/

SELECT count(*) as Cust_Count
FROM customer
WHERE city = 'delhi';

/*Problem # 5:
Write a query to display  the customer number, customer firstname,account number for the customer’s whose accounts 
were created after 15th of any month.*/
SELECT c.custid,c.fname, a.acnumber FROM account a, customer c 
WHERE a.custid = c.custid
AND day(aod)>15;


/*Problem # 6:
#Write a query to display the customer number, firstname, lastname for those client where total loan amount taken is 
#maximum and at least taken from 2 banks. */

SELECT custid, fname, ltname
FROM customer 
WHERE custid = 
	(SELECT custid 
	 FROM loan
	 GROUP BY custid
	 HAVING sum(loan_amount) = 
		(
		SELECT max(loan_sum) 
		FROM
			(SELECT custid, sum(loan_amount) loan_sum
			FROM loan
			GROUP BY custid 
			HAVING count(*) >1) l
		)
	);
    

/*Problem # 7:
Write a query to display all those account number, deposit, withdrawal where withdrawal is more than deposit amount. 

For example A00011 deposited 2000 rupees on 2012-12-01 and 3000 rupees on 2012-12-02. The same account i.e A00011 withdrawn
 3000 rupees on 2013-01-01 and 7000 rupees on 2013-01-03. So the total deposited amount is 5000 and total withdrawal amount 
is 10000. So withdrawal amount is more then deposited for account number A00011.*/

SELECT DISTINCT t.acnumber,d.tr_amt as deposit,w.tr_amt AS withdrawal FROM trandetails t,
(SELECT acnumber,sum(transaction_amount) AS tr_amt FROM trandetails WHERE transaction_type="withdrawal" GROUP BY acnumber)w,
(SELECT acnumber,sum(transaction_amount) AS tr_amt from trandetails WHERE  transaction_type="deposit" GROUP BY acnumber)d
WHERE w.tr_amt > d.tr_amt AND w.acnumber = t.acnumber AND t.acnumber = d.acnumber;


/* Problem 8:Write a query to show the balance amount for account number A00001. 
Note: Balance amount includes account opening balance also.For example A00015 is having an opening balance of 1000. 
A00015 has deposited 2000 on 2012-06-12 and deposited 3000 on 2012-07-13. 
The same account has drawn money of 500 on 2012-08-12 , 500 on 2012-09-15, 1000 on 2012-12-17. 
So balance amount is 4000 i.e (1000 (opening balance)+2000+3000 ) – (500+500+1000).*/

SELECT a.acnumber, (d.tr_amt + a.opening_balance - w.tr_amt) AS balance_amount 
FROM account a,
	(SELECT sum(transaction_amount) AS tr_amt FROM trandetails WHERE acnumber="A00001" AND transaction_type="withdrawal" GROUP BY acnumber)w,
	(SELECT sum(transaction_amount) AS tr_amt from trandetails WHERE  acnumber="A00001" AND transaction_type="deposit" GROUP BY acnumber)d
WHERE a.acnumber = "A00001";

/* Problem 9: Write a query to show the branch name,branch city where we have the maximum customers.
For example the branch B00019 has 3 customers, B00020 has 7 and B00021 has 10. 
So branch id B00021 is having maximum customers. B00021 is suppose for Koramangla branch Bangalore.  
So Koramangla branch should be displayed along with city name Bangalore.*/

SELECT bname, bcity, num_branch
FROM ( 
		SELECT b.bid, b.bname, b.bcity, count(*) num_branch FROM branch b, account a, customer c
        WHERE a.custid = c.custid AND a.bid = b.bid
        GROUP BY b.bid
	  )a
WHERE num_branch = 
	(
	SELECT max(num_branch) 
	FROM 
		(SELECT b.bid, b.bname, b.bcity, count(*) num_branch FROM branch b, account a, customer c
		WHERE a.custid = c.custid AND a.bid = b.bid
        GROUP BY b.bid
		)b
	);







