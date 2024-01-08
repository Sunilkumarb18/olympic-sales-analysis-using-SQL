select * from events
select * from regions

select count(distinct Games) [Total Games] from events

select distinct Games from events

select count(distinct Team) as [Total Teams] from events


select Year,count(Games) [Total Games] from events
group by Year
order by count(Games) desc


with cte as (
select Team,COUNT(distinct Games) [Total Games] from events
group by Team)

select * from cte where  [Total Games] = (select count(distinct Games) from events)

with cte as(
select Sport,
       COUNT(distinct Games) [Total Games] 
from events where Season='Summer'
group by Sport
)
select * from cte 
where [Total Games]=(select count(distinct Games) 
					 from events where Season='Summer')


with cte as(
select Sport,COUNT(Games)[Total Games] from events
group by Sport
)
select Sport from cte where [Total Games]=1

select distinct Games, 
                COUNT(distinct Sport)[Total Sports] 
from events
group by Games

select * from events where Medal='Gold' and Age!='NA'
order by Age desc

select cast((select cast(COUNT(Name)as decimal(18,2)) from events where Sex='M')/cast(COUNT(Games) as decimal(18,2)) *100
            as decimal(18,2))
from events

select cast((select cast(COUNT(Name)as decimal(18,2)) from events where Sex='F')/cast(COUNT(Games) as decimal(18,2)) *100
           as decimal(18,2))
from events

select top 5 name,count(Medal) [Total Medals] from events
group by name
order by COUNT(Medal) desc 

select top 5  Team, COUNT(Medal) [Total Medals] from events
group by Team
order by COUNT(Medal) desc

select top 5  Team,
SUM(case when Medal='Gold' then 1 else 0 end) as [Gold],
SUM(case when Medal='Silver' then 1 else 0 end) as [Silver],
SUM(case when Medal='Bronze' then 1 else 0 end) as [Bronze]
from events
group by Team
order by Gold desc,Silver desc,Bronze desc

select top 3  Team,
        Games,
		SUM(case when Medal='Gold' then 1 else 0 end) as [Gold],
		SUM(case when Medal='Silver' then 1 else 0 end) as [Silver],
		SUM(case when Medal='Bronze' then 1 else 0 end) as [Bronze],
		COUNT(Medal) [Total Medals]
from events
group by Team,Games
order by Gold desc,Silver desc,Bronze desc,COUNT(Medal) desc

select top 1  r.region,
              SUM(case when Medal='Gold' then 1 else 0 end) as [Gold],
              SUM(case when Medal='Silver' then 1 else 0 end) as [Silver],
              SUM(case when Medal='Bronze' then 1 else 0 end) as [Bronze]
from events e
left join regions r on e.NOC=r.NOC
group by r.region
order by Gold desc,Silver desc,Bronze desc

with cte as (
select    r.region,
          SUM(case when Medal='Gold' then 1 else 0 end) as [Gold],
          SUM(case when Medal='Silver' then 1 else 0 end) as [Silver],
          SUM(case when Medal='Bronze' then 1 else 0 end) as [Bronze]
from events e
left join regions r on e.NOC=r.NOC
group by r.region

)
select * from cte
where [Gold]=0

select top 1 Sport,
             COUNT(Medal) [Total Medals]
from events e
left join regions r on e.NOC=r.NOC
where r.region='India'
group by Sport
order by [Total Medals] desc

with cte as (
select Games,
       COUNT(Medal)[Total hockey Medals] 
from events e left join regions r on e.NOC=r.NOC
where r.region='India' and e.Sport='hockey'
group by Games
)
select c.Games,
       [Total hockey Medals],
	   count(e.Medal)[Total Medals] 
from cte c
inner join events e on e.Games= c.Games
where e.Games in (select Games from cte)
group by c.Games,[Total hockey Medals]
order by c.Games