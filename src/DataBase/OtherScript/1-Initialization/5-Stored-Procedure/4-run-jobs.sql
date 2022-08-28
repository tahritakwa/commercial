USE [msdb]
GO

/****** Object:  Job [DeleteLOG_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

DECLARE @dataBaseName varchar(250)
SET @dataBaseName = $(db)

DECLARE @stagingStark varchar(250)
SET @stagingStark = CONCAT( N'Staging-Stark_',@dataBaseName)

DECLARE @reportingStark varchar(250)
SET @reportingStark = CONCAT( N'Reporting-Stark_',@dataBaseName)

DECLARE @feedParameter varchar(250)
SET @feedParameter = CONCAT( N'FeedParameter_',@dataBaseName)

DECLARE @deleteLOG varchar(250)
SET @deleteLOG = CONCAT( N'DeleteLOG_',@dataBaseName)

/****** Object:  Job [Staging-Stark_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 AM ******/
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @stagingStark)
EXEC msdb.dbo.sp_delete_job @job_name=@stagingStark, @delete_unused_schedule=1


/****** Object:  Job [Reporting-Stark_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 AM ******/
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @reportingStark)
EXEC msdb.dbo.sp_delete_job @job_name=@reportingStark, @delete_unused_schedule=1


/****** Object:  Job [FeedParameter_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 AM ******/
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @feedParameter)
EXEC msdb.dbo.sp_delete_job @job_name=@feedParameter, @delete_unused_schedule=1

/****** Object:  Job [DeleteLOG_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 AM ******/
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @deleteLOG)
EXEC msdb.dbo.sp_delete_job @job_name=@deleteLOG, @delete_unused_schedule=1

/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 06/09/2021 11:34:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId1 BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@deleteLOG, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId1 OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Delete Log]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId1, @step_name=N'Delete Log', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DELETE FROM [Reporting].[FeedLOG]
 WHERE [Date]< GETDATE()-60', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId1, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId1, @name=N'Delete Log Planification', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200918, 
		@active_end_date=99991231, 
		@active_start_time=100, 
		@active_end_time=235959, 
		@schedule_uid=N'88289f55-aba3-4c08-9965-453fbf31a8a1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId1, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Job [FeedParameterPeriod_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 ******/

/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 06/09/2021 11:34:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId2 BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@feedParameter, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId2 OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedParameterPeriod_MasterGuidTN]    Script Date: 01/10/2021 16:58:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId2, @step_name=N'FeedParameterPeriod', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC  [Reporting].[FeedParameterPeriod]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedParameterReference]    Script Date: 01/10/2021 16:58:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId2, @step_name=N'FeedParameterReference', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedParameterReference]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId2, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId2, @name=@feedParameter, 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200918, 
		@active_end_date=99991231, 
		@active_start_time=100, 
		@active_end_time=235959, 
		@schedule_uid=N'a8648aa0-7f16-4957-b04b-78792fbd326b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId2, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback


/****** Object:  Job [Staging-Stark_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 ******/

/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 06/09/2021 11:34:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId3 BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@stagingStark, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId3 OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimCountry]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimCountry', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Reporting].[FeedDimCountry]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimCurrency]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimCurrency', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC  [Reporting].[FeedDimCurrency]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimDate]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimDate', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC  [Reporting].[FeedDimDate]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimItem]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimItem', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedDimItem]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimPayment]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimPayment', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedDimPayment]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimTiers]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimTiers', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedDimTiers]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedDimWarehouse]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedDimWarehouse', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedDimWarehouse]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedFctPurchases]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedFctPurchases', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedFctPurchases]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedFctSales]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedFctSales', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedFctSales]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedCartes]    Script Date: 01/10/2021 16:58:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId3, @step_name=N'FeedCartes', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedCartes]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId3, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId3, @name=N'Staging-Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20200911, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'9cfe5c8c-1ed6-427f-943b-aa279903425f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId3, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Job [Reporting-Stark_MasterGuidTN]    Script Date: 06/09/2021 11:34:48 ******/

/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 06/09/2021 11:34:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId4 BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@reportingStark, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId4 OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPIConversionRate]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPIConversionRate', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedKPIConversionRate]', 
		@database_name=@dataBaseName,
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPIConversionRateDetails]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPIConversionRateDetails', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedKPIConversionRateDetails]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPIOrderStatus]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPIOrderStatus', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedKPIOrderStatus]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPIPaymentMethodPerClient]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPIPaymentMethodPerClient', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedKPIPaymentMethodPerClient] ', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPISalesPerItem]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPISalesPerItem', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedKPISalesPerItem]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPISalesPerItemFamily]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPISalesPerItemFamily', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [Reporting].[FeedKPISalesPerItemFamily]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPISalesPurchaseState]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPISalesPurchaseState', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec  [Reporting].[FeedKPISalesPurchaseState]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPISearchItems]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPISearchItems', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Reporting].[FeedKPISearchItems]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPITopTiers]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPITopTiers', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Reporting].[FeedKPITopTiers]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPITotalGrossPayroll]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPITotalGrossPayroll', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N' EXEC [Reporting].[FeedKPITotalGrossPayroll]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPITotalPremium]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPITotalPremium', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Reporting].[FeedKPITotalPremium]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [FeedKPIDeliveryRate]    Script Date: 06/09/2021 11:34:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId4, @step_name=N'FeedKPIDeliveryRate', 
		@step_id=12, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Reporting].[FeedKPIDeliveryRate]', 
		@database_name=@dataBaseName, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId4, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId4, @name=N'Reporting-Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20200911, 
		@active_end_date=99991231, 
		@active_start_time=23000, 
		@active_end_time=235959, 
		@schedule_uid=N'f518e51f-a6f2-4215-86f0-c0b275949b7e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId4, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback


COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
	BEGIN
		
		DECLARE @job NVARCHAR(255)
		Begin Try
			SELECT @job = @deleteLOG
			EXEC msdb.dbo.sp_start_job @job_name=@job
			WHILE EXISTS(SELECT 1 
			  FROM msdb.dbo.sysjobs J 
			  JOIN msdb.dbo.sysjobactivity A 
				  ON A.job_id=J.job_id 
			  WHERE J.name=@job 
			  AND A.run_requested_date IS NOT NULL 
			  AND A.stop_execution_date IS NULL
			 )
				continue

			PRINT @job+' is finished.'
			SELECT @job = @feedParameter
			EXEC msdb.dbo.sp_start_job @job_name=@job
			WHILE EXISTS(SELECT 1 
			  FROM msdb.dbo.sysjobs J 
			  JOIN msdb.dbo.sysjobactivity A 
				  ON A.job_id=J.job_id 
			  WHERE J.name=@job 
			  AND A.run_requested_date IS NOT NULL 
			  AND A.stop_execution_date IS NULL
			 )
				continue

			PRINT @job+' is finished.'
			SELECT @job = @stagingStark
			EXEC msdb.dbo.sp_start_job @job_name=@job
			WHILE EXISTS(SELECT 1 
			  FROM msdb.dbo.sysjobs J 
			  JOIN msdb.dbo.sysjobactivity A 
				  ON A.job_id=J.job_id 
			  WHERE J.name=@job 
			  AND A.run_requested_date IS NOT NULL 
			  AND A.stop_execution_date IS NULL
			 )
				continue

			PRINT @job+' is finished.'
			SELECT @job = @reportingStark
			EXEC msdb.dbo.sp_start_job @job_name=@job
			WHILE EXISTS(SELECT 1 
			  FROM msdb.dbo.sysjobs J 
			  JOIN msdb.dbo.sysjobactivity A 
				  ON A.job_id=J.job_id 
			  WHERE J.name=@job 
			  AND A.run_requested_date IS NOT NULL 
			  AND A.stop_execution_date IS NULL
			 )
				continue

			PRINT @job+' is finished.'
		End  Try
		Begin Catch
			Select 1 Is_Failed, @job As job_name, ERROR_MESSAGE() Error_MSg, ERROR_NUMBER() As Err_Number
			Return
		End CAtch
		

	END;
GO
