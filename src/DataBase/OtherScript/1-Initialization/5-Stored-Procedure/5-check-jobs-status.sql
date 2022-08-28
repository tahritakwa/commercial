
DECLARE @dataBaseName varchar(250)
SET @dataBaseName = $(db)
create table #temp
(
    id int,
    job_name varchar(50)
)

insert into #temp values (1, 'DeleteLOG_'+@dataBaseName)
insert into #temp values (2, 'FeedParameter_'+@dataBaseName)
insert into #temp values (3, 'Staging-Stark_'+@dataBaseName)
insert into #temp values (4, 'Reporting-Stark_'+@dataBaseName)


	select j.name
	, (case tsh.run_status
			when 0 then 'Failed'
			when 1 then 'Succeeded'
			when 2 then 'Retry'
			when 3 then 'Canceled'
			when 4 then 'In progress'
	end) as RunStatus
from msdb.dbo.sysjobs j
	outer apply (
			select
				top (1)
				sh.run_status as run_status
			from msdb.dbo.sysjobhistory sh
			where sh.job_id = j.job_id
				
			order by sh.instance_id desc
	) tsh 
	outer apply (

	   SELECT job_name
	   from #temp 
	) job
	where name = job.job_name
