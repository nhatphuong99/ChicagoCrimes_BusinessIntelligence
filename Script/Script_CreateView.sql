create view vDM as
select f.[Case Number], f.Arrest, f.Theft, f.Domestic, fbi.Code, fbi.Categories, 
d.DayOfMonth, d.MonthNumber, d.WeekNumber, d.Year, 
c.[COMMUNITY AREA NAME], 
case when c.[HARDSHIP INDEX] < 30 then 'low'
	when c.[HARDSHIP INDEX] >= 30 and c.[HARDSHIP INDEX] <= 70 then 'medium'
	else 'high' end as [Hardship Index],
case when c.[PER CAPITA INCOME] < 30000 then 'low'
	when c.[PER CAPITA INCOME] >= 30000 and c.[PER CAPITA INCOME] <= 50000 then 'medium'
	else 'high' end as [Income],
case when c.[PERCENT AGED 16+ UNEMPLOYED] < 15 then 'low'
	when c.[PERCENT AGED 16+ UNEMPLOYED] >= 15 and c.[PERCENT AGED 16+ UNEMPLOYED] <= 25 then 'medium'
	else 'high' end as [16+ UNEMPLOYED],
case when c.[PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA] < 25 then 'low'
	else 'high' end as [25+ WITHOUT HIGH SCHOOL DIPLOMA],
case when c.[PERCENT AGED UNDER 18 OR OVER 64] < 30 then 'low'
	else 'high' end as [UNDER 18 OR OVER 64],
case when c.[PERCENT HOUSEHOLDS BELOW POVERTY] < 20 then 'low'
	when c.[PERCENT HOUSEHOLDS BELOW POVERTY] >= 20 and c.[PERCENT HOUSEHOLDS BELOW POVERTY] <= 35 then 'medium'
	else 'high' end as [HOUSEHOLDS BELOW POVERTY],
case when c.[PERCENT OF HOUSING CROWDED] < 6 then 'low'
	when c.[PERCENT OF HOUSING CROWDED] >= 6 and c.[PERCENT OF HOUSING CROWDED] <= 10 then 'medium'
	else 'high' end as [HOUSING CROWDED],
iucr.IUCR, iucr.[Primary Type], iucr.Description,
l.LocationDescriptionName
from Fact_Crime f inner join Dim_Date d on f.DateKey = d.DateKey
inner join Dim_CommunityArea c on c.CommunityAreaKey = f.CommunityAreaKey
inner join Dim_FBICode fbi on fbi.FBICodeKey = f.FBICodeKey
inner join Dim_IUCR iucr on iucr.IUCRKey = f.IUCRKey
inner join Dim_Location l on l.LocationDescriptionKey = f.LocationDescriptionKey;

select * from vDM;


create view vTestDM as
select f.[Case Number], f.Arrest, fbi.Code, fbi.Categories, 
d.DayOfMonth, d.MonthNumber, d.WeekNumber, d.Year, 
c.[COMMUNITY AREA NAME], 
case when c.[HARDSHIP INDEX] < 30 then 'low'
	when c.[HARDSHIP INDEX] >= 30 and c.[HARDSHIP INDEX] <= 70 then 'medium'
	else 'high' end as [Hardship Index],
case when c.[PER CAPITA INCOME] < 30000 then 'low'
	when c.[PER CAPITA INCOME] >= 30000 and c.[PER CAPITA INCOME] <= 50000 then 'medium'
	else 'high' end as [Income],
case when c.[PERCENT AGED 16+ UNEMPLOYED] < 15 then 'low'
	when c.[PERCENT AGED 16+ UNEMPLOYED] >= 15 and c.[PERCENT AGED 16+ UNEMPLOYED] <= 25 then 'medium'
	else 'high' end as [16+ UNEMPLOYED],
case when c.[PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA] < 25 then 'low'
	else 'high' end as [25+ WITHOUT HIGH SCHOOL DIPLOMA],
case when c.[PERCENT AGED UNDER 18 OR OVER 64] < 30 then 'low'
	else 'high' end as [UNDER 18 OR OVER 64],
case when c.[PERCENT HOUSEHOLDS BELOW POVERTY] < 20 then 'low'
	when c.[PERCENT HOUSEHOLDS BELOW POVERTY] >= 20 and c.[PERCENT HOUSEHOLDS BELOW POVERTY] <= 35 then 'medium'
	else 'high' end as [HOUSEHOLDS BELOW POVERTY],
case when c.[PERCENT OF HOUSING CROWDED] < 6 then 'low'
	when c.[PERCENT OF HOUSING CROWDED] >= 6 and c.[PERCENT OF HOUSING CROWDED] <= 10 then 'medium'
	else 'high' end as [HOUSING CROWDED],
iucr.IUCR, iucr.[Primary Type], iucr.Description,
l.LocationDescriptionName
from Fact_Crime f inner join Dim_Date d on f.DateKey = d.DateKey
inner join Dim_CommunityArea c on c.CommunityAreaKey = f.CommunityAreaKey
inner join Dim_FBICode fbi on fbi.FBICodeKey = f.FBICodeKey
inner join Dim_IUCR iucr on iucr.IUCRKey = f.IUCRKey
inner join Dim_Location l on l.LocationDescriptionKey = f.LocationDescriptionKey;