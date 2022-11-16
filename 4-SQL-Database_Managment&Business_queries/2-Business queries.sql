------------------------------------- Business Queries -----------------------------

--1-- Churn percent from all clients 

with cte 
as 
(
	 select count(s.customer_id) as churned
from status as s
where s.customer_status ='Churned'
group by s.customer_status
)
select (cast(cte.churned as decimal)/c.Tcustomers)as churned_precent
from cte 
,(select count(*) as Tcustomers
from status as ss) as c

--2--most frequent reasons of churn in order 

select ch.churn_reason,count(s.churn_id) as reason_frequency
from  status as s ,churn as ch
where ch.churn_id = s.churn_id
group by ch.churn_reason
order by reason_frequency desc

--3--number of clients per location in order
--for targeting with ads with new updates

--for zip

select c.[zip code],count(c.[customer id]) as number_of_clients
from customer as c 
group by c.[zip code]
order by number_of_clients desc

--for city

select l.city ,count(c.[customer id]) as number_of_clients
from location as l ,customer as c 
where c.[zip code] = l.zip_code
group by l.city
order by number_of_clients desc

--4--the population of location in order for targeting potenail clients with ads

--for zip

with cte 
as 
(select l.zip_code ,l.population ,cur.current_Clients
,(cast(cur.current_Clients as decimal)/l.population)as customer_precent
from location as l ,
(select c.[zip code] ,count(c.[customer id]) as current_Clients
from customer as c group by c.[zip code]) as cur
where cur.[zip code] =l.zip_code

)
select cte.*, ROW_NUMBER() OVER(ORDER BY customer_precent desc) AS rn
from cte 


--for city

with cte 
as 
(
	 select l.city ,sum(l.population)  as Tpopulation
	 from location as l
	 group by l.city
)

select cte.* ,cur.current_Clients
,(cast(cur.current_Clients as decimal)/cte.Tpopulation)as customer_precent
from cte  ,
(select Ltemp.city ,count(c.[customer id]) as current_Clients
from customer as c ,location as Ltemp  
where Ltemp.zip_code=c.[zip code] group by Ltemp.city ) as cur 
where cur.city =cte.city
order by cte.Tpopulation desc


--5--targeting the specail clients(most paying) 
--to target them with offers and gifts and turn them into loyal clients

declare @t int
select @t=count(c.[customer id])*0.25
from customer as c


select top (@t) c.* , s.total_charges
from customer as c , status as s
where s.customer_id =c.[customer id]
order by s.total_charges desc