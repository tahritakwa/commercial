SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[Axis](
	[Id] [int] IDENTITY(100000,1) NOT NULL,
	[Rank] [int] NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Label] [nvarchar](100) NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[FR] [nvarchar](255) NULL,
	[AR] [nvarchar](255) NULL,
	[EN] [nvarchar](255) NULL,
	[DE] [nvarchar](255) NULL,
	[CH] [nvarchar](255) NULL,
	[ES] [nvarchar](255) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Axis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeAxis] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[AxisEntity]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[AxisEntity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAxis] [int] NOT NULL,
	[IdTableEntity] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsRequired] [bit] NULL,
 CONSTRAINT [PK_AxisEntity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[AxisRelationShip]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[AxisRelationShip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAxis] [int] NULL,
	[IdAxisParent] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_AxisRelationShip_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[AxisValue]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[AxisValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Label] [nvarchar](100) NOT NULL,
	[IdAxis] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_AxisValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeAxisValue] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[AxisValueRelationShip]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[AxisValueRelationShip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAxisValue] [int] NOT NULL,
	[IdAxisValueParent] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_AxisRelationShip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[Currency]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[Currency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Symbole] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[CurrencyInLetter] [nvarchar](50) NULL,
	[FloatInLetter] [nvarchar](50) NULL,
	[Precision] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeCurrency] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Administration].[CurrencyRate]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[CurrencyRate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Coefficient] [float] NOT NULL,
	[Rate] [float] NOT NULL,
	[IdCurrency] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_CurrencyRate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Administration].[EntityAxisValues]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Administration].[EntityAxisValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAxisValue] [int] NULL,
	[IdEntityItem] [int] NULL,
	[Entity] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_EntityAxisValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [dbo].[ClientDetails]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[ClientDetails](
	[appId] [varchar](255) NOT NULL,
	[resourceIds] [varchar](255) NULL,
	[appSecret] [varchar](255) NULL,
	[scope] [varchar](255) NULL,
	[grantTypes] [varchar](255) NULL,
	[redirectUrl] [varchar](255) NULL,
	[authorities] [varchar](255) NULL,
	[access_token_validity] [int] NULL,
	[refresh_token_validity] [int] NULL,
	[additionalInformation] [varchar](4096) NULL,
	[autoApproveScopes] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[appId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_access_token]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_access_token](
	[token_id] [varchar](255) NULL,
	[token] [image] NULL,
	[authentication_id] [varchar](255) NOT NULL,
	[user_name] [varchar](255) NULL,
	[client_id] [varchar](255) NULL,
	[authentication] [image] NULL,
	[refresh_token] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[authentication_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_approvals]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_approvals](
	[userId] [varchar](255) NULL,
	[clientId] [varchar](255) NULL,
	[scope] [varchar](255) NULL,
	[status] [varchar](10) NULL,
	[expiresAt] [date] NULL,
	[lastModifiedAt] [date] NULL
) ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_client_details]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_client_details](
	[client_id] [varchar](255) NOT NULL,
	[resource_ids] [varchar](255) NULL,
	[client_secret] [varchar](255) NULL,
	[scope] [varchar](255) NULL,
	[authorized_grant_types] [varchar](255) NULL,
	[web_server_redirect_uri] [varchar](255) NULL,
	[authorities] [varchar](255) NULL,
	[access_token_validity] [int] NULL,
	[refresh_token_validity] [int] NULL,
	[additional_information] [varchar](4096) NULL,
	[autoapprove] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[client_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_client_token]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_client_token](
	[token_id] [varchar](255) NULL,
	[token] [image] NULL,
	[authentication_id] [varchar](255) NOT NULL,
	[user_name] [varchar](255) NULL,
	[client_id] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[authentication_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_code]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_code](
	[code] [varchar](255) NULL,
	[authentication] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [dbo].[oauth_refresh_token]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [dbo].[oauth_refresh_token](
	[token_id] [varchar](255) NULL,
	[token] [image] NULL,
	[authentication] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Ecommerce].[Delivery]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Ecommerce].[Delivery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
 CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Ecommerce].[JobTable]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Ecommerce].[JobTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastExecuteDate] [datetime] NULL,
	[NextExecuteDate] [datetime] NULL,
 CONSTRAINT [PK_JobTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Ecommerce].[TriggerItemLog]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Ecommerce].[TriggerItemLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Message] [nvarchar](max) NULL,
	[DateLog] [datetime] NULL,
 CONSTRAINT [PK_TriggerItemlOG] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Codification]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Codification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Rank] [int] NULL,
	[Path] [nvarchar](500) NULL,
	[Format] [nvarchar](255) NULL,
	[InitValue] [nvarchar](255) NULL,
	[IdCodificationParent] [int] NULL,
	[IsCounter] [bit] NULL,
	[Step] [int] NULL,
	[LastCounterValue] [nvarchar](255) NULL,
	[CounterLength] [int] NULL,
 CONSTRAINT [PK_Codification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Comment]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEntityReference] [int] NULL,
	[IdEntityCreated] [int] NULL,
	[Message] [nvarchar](max) NULL,
	[CreationDate] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[EmailCreator] [nvarchar](255) NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Discussion]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Discussion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](250) NOT NULL,
	[NumberOfDiscussionMember] [int] NOT NULL,
	[DateLastNotif] [datetime] NOT NULL,
 CONSTRAINT [PK_DiscussionChat] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Entity]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Entity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableSchema] [nvarchar](100) NOT NULL,
	[EntityName] [nvarchar](100) NOT NULL,
	[TableName] [nvarchar](100) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Fr] [nvarchar](255) NULL,
	[Ar] [nvarchar](255) NULL,
	[En] [nvarchar](255) NULL,
	[De] [nvarchar](255) NULL,
	[Ch] [nvarchar](255) NULL,
	[Es] [nvarchar](255) NULL,
	[IsReference] [bit] NULL,
	[IdRelatedEntity] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TableEntity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[EntityCodification]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[EntityCodification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEntity] [int] NULL,
	[Property] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[IdCodification] [int] NULL,
 CONSTRAINT [PK_EntityCodification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Functionality]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Functionality](
	[IdFunctionality] [uniqueidentifier] NOT NULL,
	[FunctionalityName] [nvarchar](50) NOT NULL,
	[IdRequestType] [int] NULL,
	[FR] [nvarchar](500) NULL,
	[EN] [nvarchar](500) NULL,
	[AR] [nvarchar](500) NULL,
	[DE] [nvarchar](500) NULL,
	[CH] [nvarchar](500) NULL,
	[ES] [nvarchar](500) NULL,
	[DefaultRoute] [nvarchar](255) NULL,
	[isDefaultRoute] [bit] NULL,
	[ApiRole] [nvarchar](50) NULL,
 CONSTRAINT [PK_Functionality_1] PRIMARY KEY CLUSTERED 
(
	[IdFunctionality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_FunctionalityName_Unique] UNIQUE NONCLUSTERED 
(
	[FunctionalityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Information]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Information](
	[IdInfo] [int] IDENTITY(1,1) NOT NULL,
	[IdFunctionality] [uniqueidentifier] NOT NULL,
	[URL] [nvarchar](500) NOT NULL,
	[FR] [nvarchar](500) NULL,
	[EN] [nvarchar](500) NULL,
	[AR] [nvarchar](500) NULL,
	[DE] [nvarchar](500) NULL,
	[CH] [nvarchar](500) NULL,
	[ES] [nvarchar](500) NULL,
	[IsMail] [bit] NULL,
	[IsNotification] [bit] NULL,
	[MailSubject] [nvarchar](500) NULL,
	[IsAcceptedInfo] [bit] NULL,
	[IsToManager] [bit] NULL,
	[IdInfoParent] [int] NULL,
	[TranslationKey] [nvarchar](500) NULL,
	[Type] [nvarchar](500) NULL,
 CONSTRAINT [PK_Information] PRIMARY KEY CLUSTERED 
(
	[IdInfo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Log]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Log](
	[IdDBRequest] [int] IDENTITY(1,1) NOT NULL,
	[DateOfRequest] [datetime] NULL,
	[Object] [xml] NULL,
	[RequestName] [nvarchar](50) NULL,
	[TrasactionIdUser] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Log_int_1] [int] NULL,
	[Log_int_2] [int] NULL,
	[Log_int_3] [int] NULL,
	[Log_int_4] [int] NULL,
	[Log_int_5] [int] NULL,
	[Log_int_6] [int] NULL,
	[Log_int_7] [int] NULL,
	[Log_int_8] [int] NULL,
	[Log_int_9] [int] NULL,
	[Log_int_10] [int] NULL,
	[Log_bit_1] [bit] NULL,
	[Log_bit_2] [bit] NULL,
	[Log_bit_3] [bit] NULL,
	[Log_bit_4] [bit] NULL,
	[Log_bit_5] [bit] NULL,
	[Log_bit_6] [bit] NULL,
	[Log_bit_7] [bit] NULL,
	[Log_bit_8] [bit] NULL,
	[Log_bit_9] [bit] NULL,
	[Log_bit_10] [bit] NULL,
	[Log_float_1] [float] NULL,
	[Log_float_2] [float] NULL,
	[Log_float_3] [float] NULL,
	[Log_float_4] [float] NULL,
	[Log_float_5] [float] NULL,
	[Log_float_6] [float] NULL,
	[Log_float_7] [float] NULL,
	[Log_float_8] [float] NULL,
	[Log_float_9] [float] NULL,
	[Log_float_10] [float] NULL,
	[Log_varchar_1] [varchar](max) NULL,
	[Log_varchar_2] [varchar](max) NULL,
	[Log_varchar_3] [varchar](max) NULL,
	[Log_varchar_4] [varchar](max) NULL,
	[Log_varchar_5] [varchar](max) NULL,
	[Log_varchar_6] [varchar](max) NULL,
	[Log_varchar_7] [varchar](max) NULL,
	[Log_varchar_8] [varchar](max) NULL,
	[Log_varchar_9] [varchar](max) NULL,
	[Log_varchar_10] [varchar](max) NULL,
	[Log_date_1] [date] NULL,
	[Log_date_2] [date] NULL,
	[Log_date_3] [date] NULL,
	[Log_date_4] [date] NULL,
	[Log_date_5] [date] NULL,
	[Log_date_6] [date] NULL,
	[Log_date_7] [date] NULL,
	[Log_date_8] [date] NULL,
	[Log_date_9] [date] NULL,
	[Log_date_10] [date] NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[IdDBRequest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Logs]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageTemplate] [nvarchar](max) NULL,
	[Level] [nvarchar](128) NULL,
	[TimeStamp] [datetimeoffset](7) NULL,
	[Exception] [nvarchar](max) NULL,
	[Properties] [xml] NULL,
	[LogEvent] [nvarchar](max) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Message]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCreator] [int] NOT NULL,
	[IdInformation] [int] NOT NULL,
	[EntityReference] [int] NOT NULL,
	[CodeEntity] [varchar](max) NULL,
	[TypeMessage] [int] NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[MessageChat]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[MessageChat](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[text] [text] NOT NULL,
	[date] [datetime] NOT NULL,
	[attachedFilesLink] [varchar](250) NULL,
	[IdUserDiscussion] [int] NOT NULL,
 CONSTRAINT [PK_MessageChat] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[MsgNotification]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[MsgNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMsg] [int] NOT NULL,
	[IdTargetedUser] [int] NOT NULL,
	[Viewed] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_Notification_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_MsgNotification] UNIQUE NONCLUSTERED 
(
	[IdMsg] ASC,
	[IdTargetedUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Notification]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Notification](
	[IdNotification] [int] NOT NULL,
	[FR] [nvarchar](500) NULL,
	[EN] [nvarchar](500) NULL,
	[AR] [nvarchar](500) NULL,
	[DE] [nvarchar](500) NULL,
	[CH] [nvarchar](500) NULL,
	[ES] [nvarchar](500) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[IdNotification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[Privilege]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[Privilege](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Reference] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Privilege] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[ReportTemplate]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[ReportTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEntity] [int] NULL,
	[TemplateCode] [nvarchar](255) NULL,
	[TemplateNameFr] [nvarchar](255) NULL,
	[TemplateNameEn] [nvarchar](255) NULL,
	[ReportCode] [nvarchar](255) NULL,
	[ReportName] [nvarchar](255) NULL,
 CONSTRAINT [PK_ReportTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[RequestType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[RequestType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestName] [nvarchar](50) NULL,
	[RequestFile] [nvarchar](50) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_RequestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[User]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Login] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[Token] [nvarchar](max) NULL,
	[Phone] [nvarchar](20) NULL,
	[WorkPhone] [nvarchar](20) NULL,
	[MobilePhone] [nvarchar](20) NULL,
	[Email] [nvarchar](255) NULL,
	[Birthday] [date] NULL,
	[Picture] [image] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](150) NULL,
	[IdUserParent] [int] NULL,
	[Lang] [nvarchar](10) NULL,
	[IdEmployee] [int] NULL,
	[IsBToB] [bit] NULL,
	[IdTiers] [int] NULL,
	[Role] [nvarchar](255) NULL,
	[IsTecDoc] [bit] NULL,
	[IsActif] [bit] NOT NULL,
	[LastConnection] [datetime] NULL,
	[LastConnectedIpAdress] [nvarchar](100) NULL,
	[Twitter] [nvarchar](255) NULL,
	[Linkedin] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Facebook] [nvarchar](255) NULL,
	[IsWithEmailNotification] [bit] NOT NULL,
	[IdPhone] [int] NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
 CONSTRAINT [PK_dbo.t_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__User__A9D10534122247B2] UNIQUE NONCLUSTERED 
(
	[Email] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[UserDiscussionChat]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[UserDiscussionChat](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdDiscussion] [int] NOT NULL,
	[HasNotif] [bit] NOT NULL,
 CONSTRAINT [PK_UserDiscussionChat] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[UserInfo]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[UserInfo](
	[idUserInfo] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdInformation] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[idUserInfo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueConstraint] UNIQUE NONCLUSTERED 
(
	[IdUser] ASC,
	[IdInformation] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [ERPSettings].[UserPrivilege]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [ERPSettings].[UserPrivilege](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdPrivilege] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[SameLevelWithHierarchy] [bit] NULL,
	[SameLevelWithoutHierarchy] [bit] NULL,
	[SubLevel] [bit] NULL,
	[SuperiorLevelWithHierarchy] [bit] NULL,
	[SuperiorLevelWithoutHierarchy] [bit] NULL,
	[Management] [bit] NULL,
 CONSTRAINT [PK_UserPrivilege] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Helpdesk].[Claim]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Helpdesk].[Claim](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Reference] [nvarchar](255) NULL,
	[Informations] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsTreated] [bit] NOT NULL,
	[IdClaimStatus] [int] NULL,
	[ClaimType] [nvarchar](50) NULL,
	[IdWarehouse] [int] NULL,
	[IdItem] [int] NULL,
	[IdClient] [int] NULL,
	[IdContact] [int] NULL,
	[IdFournisseur] [int] NULL,
	[IdDocument] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[DocumentDate] [datetime] NULL,
	[ValidationDate] [datetime] NULL,
	[ClaimQty] [float] NULL,
	[IdPurchaseDocument] [int] NULL,
	[IdReceiptDocument] [int] NULL,
	[IdSalesDocument] [int] NULL,
	[IdDeliveryDocument] [int] NULL,
	[ClaimMaxQty] [float] NULL,
	[IdSalesAssetDocument] [int] NULL,
	[IdPurchaseAssetDocument] [int] NULL,
	[IsClaimQtyLocked] [bit] NOT NULL,
	[IdMovementIn] [int] NULL,
	[IdMovementOut] [int] NULL,
	[ReferenceOldDocument] [nvarchar](50) NULL,
 CONSTRAINT [PK_CLAIM] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeClaim] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Helpdesk].[ClaimInteraction]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Helpdesk].[ClaimInteraction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdClaim] [int] NOT NULL,
	[DocumentDate] [datetime] NULL,
	[TypeInteraction] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[TranslationCode] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ClaimInteraction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Helpdesk].[ClaimStatus]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Helpdesk].[ClaimStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdStatus] [int] NOT NULL,
	[CodeStatus] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[TranslationCode] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_IDSTATUS] PRIMARY KEY CLUSTERED 
(
	[IdStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeClaimStatus] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC,
	[CodeStatus] ASC,
	[IdStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Helpdesk].[ClaimType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Helpdesk].[ClaimType](
	[CodeType] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[StockOperation] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TranslationCode] [nvarchar](255) NULL,
 CONSTRAINT [PK_ClaimType] PRIMARY KEY CLUSTERED 
(
	[CodeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Helpdesk].[ClaimTypeRelation]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Helpdesk].[ClaimTypeRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CodeClaimType] [nvarchar](50) NOT NULL,
	[CodeClaimTypeAssociated] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ClaimTypeRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Immobilisation].[Active]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Immobilisation].[Active](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](50) NULL,
	[DepreciationPeriod] [int] NULL,
	[AcquisationDate] [date] NULL,
	[ServiceDate] [date] NULL,
	[Status] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[Value] [float] NULL,
	[IdCategory] [int] NULL,
	[Code] [nvarchar](255) NULL,
	[Deleted_Token] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[NumSerie] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[IdWarehouse] [int] NULL,
	[IPAddress] [nvarchar](500) NULL,
	[MACAddress] [nvarchar](500) NULL,
	[HostName] [nvarchar](500) NULL,
	[PhoneNumber] [nvarchar](500) NULL,
 CONSTRAINT [PK_Active] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Immobilisation].[Category]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Immobilisation].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MinPeriod] [int] NULL,
	[MaxPeriod] [int] NULL,
	[ImmobilisationType] [int] NULL,
	[Label] [nvarchar](50) NULL,
	[Deleted_Token] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Code] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeImmobilisationCategory] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueLabelImmobilisationCategory] UNIQUE NONCLUSTERED 
(
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Immobilisation].[History]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Immobilisation].[History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NULL,
	[IdActive] [int] NULL,
	[AcquisationDate] [date] NULL,
	[AbandonmentDate] [date] NULL,
	[Deleted_Token] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_History_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Family]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Family](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[IdCategoryEcommerce] [int] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Family] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Item]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Item](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Description] [nvarchar](300) NULL,
	[BarCode1D] [nvarchar](255) NULL,
	[BarCode2D] [nvarchar](max) NULL,
	[IdUnitStock] [int] NULL,
	[IdUnitSales] [int] NULL,
	[CoeffConversion] [float] NULL,
	[UnitHTPurchasePrice] [float] NULL,
	[UnitHTSalePrice] [float] NULL,
	[UnitTTCPurchasePrice] [float] NULL,
	[UnitTTCSalePrice] [float] NULL,
	[TVARate] [float] NULL,
	[FixedMargin] [float] NULL,
	[VariableMargin] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdNature] [int] NULL,
	[IdTiers] [int] NULL,
	[EquivalenceItem] [uniqueidentifier] NULL,
	[IdFamily] [int] NULL,
	[IdSubFamily] [int] NULL,
	[OnOrder] [bit] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[IdPolicyValorization] [int] NULL,
	[AverageSalesPerDay] [float] NULL,
	[IdAccountingAccountSales] [int] NULL,
	[IdAccountingAccountPurchase] [int] NULL,
	[TecDocId] [int] NULL,
	[TecDocRef] [nvarchar](50) NULL,
	[TecDocIdSupplier] [int] NULL,
	[IdEmployee] [int] NULL,
	[IsForPurchase] [bit] NOT NULL,
	[IsForSales] [bit] NOT NULL,
	[IsKit] [bit] NOT NULL,
	[IdItemReplacement] [int] NULL,
	[IdProductItem] [int] NULL,
	[HaveClaims] [bit] NOT NULL,
	[DefaultUnitHTPurchasePrice] [float] NULL,
	[IsEcommerce] [bit] NOT NULL,
	[ExistInEcommerce] [bit] NOT NULL,
	[OnlineSynchonizationStatus] [int] NULL,
	[SynchonizationStatus] [int] NULL,
	[LastUpdateEcommerce] [datetime] NULL,
	[TecDocImageUrl] [nvarchar](max) NULL,
	[TecDocBrandName] [nvarchar](max) NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[ProvInventory] [bit] NOT NULL,
	[IsFromGarage] [bit] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Item] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC,
	[IdTiers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemKit]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemKit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdKit] [int] NULL,
	[IdItem] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_ItemKit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemPrices]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemPrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdPrices] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ItemPrices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ItemPrices] UNIQUE NONCLUSTERED 
(
	[IdItem] ASC,
	[IdPrices] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemSalesPrice]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemSalesPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdSalesPrice] [int] NOT NULL,
	[Percentage] [float] NOT NULL,
	[DeletedToken] [nchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ItemSlaesPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemTiers]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemTiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdTiers] [int] NOT NULL,
	[DeletedToken] [nchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
	[PurchasePrice] [float] NULL,
	[ExchangeRate] [float] NULL,
	[Margin] [float] NULL,
	[Cost] [float] NULL,
 CONSTRAINT [PK_ItemTiers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemVehicleBrandModelSubModel]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemVehicleBrandModelSubModel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NULL,
	[IdVehicleBrand] [int] NULL,
	[IdModel] [int] NULL,
	[IdSubModel] [int] NULL,
 CONSTRAINT [PK_ItemVehicleBrandModelSubModel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ItemWarehouse]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ItemWarehouse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdWarehouse] [int] NOT NULL,
	[MinQuantity] [float] NULL,
	[MaxQuantity] [float] NULL,
	[AvailableQuantity] [float] NOT NULL,
	[ReservedQuantity] [float] NOT NULL,
	[OnOrderQuantity] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Shelf] [nvarchar](50) NULL,
	[Storage] [nvarchar](50) NULL,
	[OrderedQuantity] [float] NOT NULL,
	[IdShelf] [int] NULL,
	[IdStorage] [int] NULL,
 CONSTRAINT [PK_ItemWarehouse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_ItemWarehouse_IdItemAndIdWarehouse] UNIQUE NONCLUSTERED 
(
	[IdItem] ASC,
	[IdWarehouse] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[MeasureUnit]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[MeasureUnit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MeasureUnitCode] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDecomposable] [bit] NOT NULL,
	[DigitsAfterComma] [int] NOT NULL,
 CONSTRAINT [PK_UNITTYPE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeMeasureUnit] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[MeasureUnitCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ModelOfItem]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ModelOfItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[IdVehicleBrand] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[MovementHistory]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[MovementHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [nvarchar](50) NULL,
	[IdItem] [int] NULL,
	[ItemCode] [nvarchar](max) NULL,
	[ItemDesignation] [nvarchar](max) NULL,
	[DocumentType] [nvarchar](50) NULL,
	[CustomerCode] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](max) NULL,
	[Date] [datetime] NULL,
	[OrderNumber] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[PUHT] [float] NULL,
	[PUHT1] [float] NULL,
	[Price] [float] NULL,
	[Discount] [float] NULL,
	[IsPurchase] [bit] NOT NULL,
	[IsSale] [bit] NOT NULL,
	[FiscalYear] [nvarchar](50) NULL,
 CONSTRAINT [PK_MovementHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Nature]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Nature](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsStockManaged] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[UrlPicture] [nvarchar](255) NULL,
 CONSTRAINT [PK_Nature] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Oem]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Oem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTecDoc] [int] NOT NULL,
	[OemCode] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Oem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[OemItem]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[OemItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[OemNumber] [nvarchar](20) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdBrand] [int] NULL,
 CONSTRAINT [PK_OemItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[ProductItem]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[ProductItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodeProduct] [nvarchar](255) NULL,
	[LabelProduct] [nvarchar](255) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeProduct] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CodeProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Shelf]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Shelf](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](250) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdWharehouse] [int] NULL,
	[IsDefault] [bit] NULL,
 CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[StockDocument]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[StockDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TypeStockDocument] [nvarchar](50) NULL,
	[IdWarehouseSource] [int] NULL,
	[IdWarehouseDestination] [int] NULL,
	[IdDocumentStatus] [int] NULL,
	[DocumentDate] [datetime] NULL,
	[ValidationDate] [datetime] NULL,
	[Reference] [nvarchar](50) NULL,
	[Informations] [nvarchar](255) NULL,
	[IsPlannedInventory] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[Shelf] [nvarchar](50) NULL,
	[IdUser] [int] NULL,
	[IdInputUser1] [int] NULL,
	[IdInputUser2] [int] NULL,
	[isDefaultValue] [bit] NULL,
	[isOnlyAvailableQuantity] [bit] NULL,
	[IdStorageSource] [int] NULL,
	[IdStorageDestination] [int] NULL,
	[TransferType] [nvarchar](50) NULL,
 CONSTRAINT [PK_StockDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeStockDocument] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[StockDocumentLine]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[StockDocumentLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdStockDocument] [int] NOT NULL,
	[ActualQuantity] [float] NULL,
	[ForecastQuantity] [float] NULL,
	[IdItem] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdWarehouse] [int] NULL,
	[Shelf] [nvarchar](50) NULL,
	[Storage] [nvarchar](50) NULL,
	[ForecastQuantity2] [float] NULL,
 CONSTRAINT [PK_StockDocumentLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[StockDocumentType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[StockDocumentType](
	[CodeType] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[StockOperation] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TypeStockDocument] PRIMARY KEY CLUSTERED 
(
	[CodeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[StockMovement]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[StockMovement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumentLine] [int] NULL,
	[IdStockDocumentLine] [int] NULL,
	[IdItem] [int] NULL,
	[IdWarehouse] [int] NOT NULL,
	[CreationDate] [datetime] NULL,
	[RealStock] [float] NULL,
	[MovementQty] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Cump] [float] NULL,
	[Operation] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdClaim] [int] NULL,
 CONSTRAINT [PK_Operation_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Storage]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Storage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](250) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdShelf] [int] NULL,
	[IsDefault] [bit] NULL,
	[IdResponsable] [int] NULL,
 CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[SubFamily]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[SubFamily](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[IdFamily] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[IdSubCategoryEcommerce] [int] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SubFamily] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[SubModel]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[SubModel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[IdModel] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SubModel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[TaxeItem]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[TaxeItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTaxe] [int] NOT NULL,
	[IdItem] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TaxeArticle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[VehicleBrand]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[VehicleBrand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Inventory].[Warehouse]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Inventory].[Warehouse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseCode] [nvarchar](255) NULL,
	[WarehouseName] [nvarchar](255) NULL,
	[WarehouseAdresse] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdWarehouseParent] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsCentral] [bit] NOT NULL,
	[IsWarehouse] [bit] NOT NULL,
	[IdResponsable] [int] NULL,
	[IsEcommerce] [bit] NOT NULL,
	[ForEcommerceModule] [bit] NOT NULL,
	[IdUserResponsable] [int] NULL,
 CONSTRAINT [PK_WAREHOUSE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeWarehouse] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[WarehouseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[CashRegister]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[CashRegister](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Type] [int] NOT NULL,
	[Address] [nvarchar](255) NULL,
	[IdResponsible] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdParentCash] [int] NULL,
	[IdCity] [int] NULL,
	[IdCountry] [int] NULL,
	[Status] [int] NOT NULL,
	[IdWarehouse] [int] NOT NULL,
	[AgentCode] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_CashRegister] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[FundsTransfer]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[FundsTransfer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[IdSourceCash] [int] NOT NULL,
	[IdDestinationCash] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[AmountWithCurrency] [float] NOT NULL,
	[IdCurrency] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdCashier] [int] NULL,
	[TransferDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FundsTransfer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[PaymentCondition]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[PaymentCondition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nbr] [int] NULL,
	[Designation] [nvarchar](255) NULL,
	[Unit] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[PaymentCondition_int_1] [int] NULL,
	[PaymentCondition_int_2] [int] NULL,
	[PaymentCondition_int_3] [int] NULL,
	[PaymentCondition_int_4] [int] NULL,
	[PaymentCondition_int_5] [int] NULL,
	[PaymentCondition_int_6] [int] NULL,
	[PaymentCondition_int_7] [int] NULL,
	[PaymentCondition_int_8] [int] NULL,
	[PaymentCondition_int_9] [int] NULL,
	[PaymentCondition_int_10] [int] NULL,
	[PaymentCondition_bit_1] [bit] NULL,
	[PaymentCondition_bit_2] [bit] NULL,
	[PaymentCondition_bit_3] [bit] NULL,
	[PaymentCondition_bit_4] [bit] NULL,
	[PaymentCondition_bit_5] [bit] NULL,
	[PaymentCondition_bit_6] [bit] NULL,
	[PaymentCondition_bit_7] [bit] NULL,
	[PaymentCondition_bit_8] [bit] NULL,
	[PaymentCondition_bit_9] [bit] NULL,
	[PaymentCondition_bit_10] [bit] NULL,
	[PaymentCondition_float_1] [float] NULL,
	[PaymentCondition_float_2] [float] NULL,
	[PaymentCondition_float_3] [float] NULL,
	[PaymentCondition_float_4] [float] NULL,
	[PaymentCondition_float_5] [float] NULL,
	[PaymentCondition_float_6] [float] NULL,
	[PaymentCondition_float_7] [float] NULL,
	[PaymentCondition_float_8] [float] NULL,
	[PaymentCondition_float_9] [float] NULL,
	[PaymentCondition_float_10] [float] NULL,
	[PaymentCondition_varchar_1] [varchar](max) NULL,
	[PaymentCondition_varchar_2] [varchar](max) NULL,
	[PaymentCondition_varchar_3] [varchar](max) NULL,
	[PaymentCondition_varchar_4] [varchar](max) NULL,
	[PaymentCondition_varchar_5] [varchar](max) NULL,
	[PaymentCondition_varchar_6] [varchar](max) NULL,
	[PaymentCondition_varchar_7] [varchar](max) NULL,
	[PaymentCondition_varchar_8] [varchar](max) NULL,
	[PaymentCondition_varchar_9] [varchar](max) NULL,
	[PaymentCondition_varchar_10] [varchar](max) NULL,
	[PaymentCondition_date_1] [date] NULL,
	[PaymentCondition_date_2] [date] NULL,
	[PaymentCondition_date_3] [date] NULL,
	[PaymentCondition_date_4] [date] NULL,
	[PaymentCondition_date_5] [date] NULL,
	[PaymentCondition_date_6] [date] NULL,
	[PaymentCondition_date_7] [date] NULL,
	[PaymentCondition_date_8] [date] NULL,
	[PaymentCondition_date_9] [date] NULL,
	[PaymentCondition_date_10] [date] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_PAYEMENTCONDITION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payment].[PaymentMethod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[PaymentMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[MethodName] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[AuthorizedForExpenses] [bit] NOT NULL,
	[AuthorizedForRecipes] [bit] NOT NULL,
	[Immediate] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdPaymentType] [int] NULL,
	[PaymentMethod_int_1] [int] NULL,
	[PaymentMethod_int_2] [int] NULL,
	[PaymentMethod_int_3] [int] NULL,
	[PaymentMethod_int_4] [int] NULL,
	[PaymentMethod_int_5] [int] NULL,
	[PaymentMethod_int_6] [int] NULL,
	[PaymentMethod_int_7] [int] NULL,
	[PaymentMethod_int_8] [int] NULL,
	[PaymentMethod_int_9] [int] NULL,
	[PaymentMethod_int_10] [int] NULL,
	[PaymentMethod_bit_1] [bit] NULL,
	[PaymentMethod_bit_2] [bit] NULL,
	[PaymentMethod_bit_3] [bit] NULL,
	[PaymentMethod_bit_4] [bit] NULL,
	[PaymentMethod_bit_5] [bit] NULL,
	[PaymentMethod_bit_6] [bit] NULL,
	[PaymentMethod_bit_7] [bit] NULL,
	[PaymentMethod_bit_8] [bit] NULL,
	[PaymentMethod_bit_9] [bit] NULL,
	[PaymentMethod_bit_10] [bit] NULL,
	[PaymentMethod_float_1] [float] NULL,
	[PaymentMethod_float_2] [float] NULL,
	[PaymentMethod_float_3] [float] NULL,
	[PaymentMethod_float_4] [float] NULL,
	[PaymentMethod_float_5] [float] NULL,
	[PaymentMethod_float_6] [float] NULL,
	[PaymentMethod_float_7] [float] NULL,
	[PaymentMethod_float_8] [float] NULL,
	[PaymentMethod_float_9] [float] NULL,
	[PaymentMethod_float_10] [float] NULL,
	[PaymentMethod_varchar_1] [varchar](max) NULL,
	[PaymentMethod_varchar_2] [varchar](max) NULL,
	[PaymentMethod_varchar_3] [varchar](max) NULL,
	[PaymentMethod_varchar_4] [varchar](max) NULL,
	[PaymentMethod_varchar_5] [varchar](max) NULL,
	[PaymentMethod_varchar_6] [varchar](max) NULL,
	[PaymentMethod_varchar_7] [varchar](max) NULL,
	[PaymentMethod_varchar_8] [varchar](max) NULL,
	[PaymentMethod_varchar_9] [varchar](max) NULL,
	[PaymentMethod_varchar_10] [varchar](max) NULL,
	[PaymentMethod_date_1] [date] NULL,
	[PaymentMethod_date_2] [date] NULL,
	[PaymentMethod_date_3] [date] NULL,
	[PaymentMethod_date_4] [date] NULL,
	[PaymentMethod_date_5] [date] NULL,
	[PaymentMethod_date_6] [date] NULL,
	[PaymentMethod_date_7] [date] NULL,
	[PaymentMethod_date_8] [date] NULL,
	[PaymentMethod_date_9] [date] NULL,
	[PaymentMethod_date_10] [date] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Fr] [nvarchar](255) NULL,
	[En] [nvarchar](255) NULL,
 CONSTRAINT [PK_PAYEMENTMETHOD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodePaymentMethod] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payment].[PaymentSlip]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[PaymentSlip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [nvarchar](255) NOT NULL,
	[Agency] [nvarchar](50) NULL,
	[Deposer] [nvarchar](50) NULL,
	[Date] [date] NOT NULL,
	[IdBankAccount] [int] NULL,
	[TotalAmountWithNumbers] [float] NULL,
	[TotalAmountWithLetters] [nvarchar](100) NULL,
	[State] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PaymentSlip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Reference_PaymentSlip] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[PaymentStatus]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[PaymentStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[PaymentType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[PaymentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[PaymentType_int_1] [int] NULL,
	[PaymentType_int_2] [int] NULL,
	[PaymentType_int_3] [int] NULL,
	[PaymentType_int_4] [int] NULL,
	[PaymentType_int_5] [int] NULL,
	[PaymentType_int_6] [int] NULL,
	[PaymentType_int_7] [int] NULL,
	[PaymentType_int_8] [int] NULL,
	[PaymentType_int_9] [int] NULL,
	[PaymentType_int_10] [int] NULL,
	[PaymentType_bit_1] [bit] NULL,
	[PaymentType_bit_2] [bit] NULL,
	[PaymentType_bit_3] [bit] NULL,
	[PaymentType_bit_4] [bit] NULL,
	[PaymentType_bit_5] [bit] NULL,
	[PaymentType_bit_6] [bit] NULL,
	[PaymentType_bit_7] [bit] NULL,
	[PaymentType_bit_8] [bit] NULL,
	[PaymentType_bit_9] [bit] NULL,
	[PaymentType_bit_10] [bit] NULL,
	[PaymentType_float_1] [float] NULL,
	[PaymentType_float_2] [float] NULL,
	[PaymentType_float_3] [float] NULL,
	[PaymentType_float_4] [float] NULL,
	[PaymentType_float_5] [float] NULL,
	[PaymentType_float_6] [float] NULL,
	[PaymentType_float_7] [float] NULL,
	[PaymentType_float_8] [float] NULL,
	[PaymentType_float_9] [float] NULL,
	[PaymentType_float_10] [float] NULL,
	[PaymentType_varchar_1] [varchar](max) NULL,
	[PaymentType_varchar_2] [varchar](max) NULL,
	[PaymentType_varchar_3] [varchar](max) NULL,
	[PaymentType_varchar_4] [varchar](max) NULL,
	[PaymentType_varchar_5] [varchar](max) NULL,
	[PaymentType_varchar_6] [varchar](max) NULL,
	[PaymentType_varchar_7] [varchar](max) NULL,
	[PaymentType_varchar_8] [varchar](max) NULL,
	[PaymentType_varchar_9] [varchar](max) NULL,
	[PaymentType_varchar_10] [varchar](max) NULL,
	[PaymentType_date_1] [date] NULL,
	[PaymentType_date_2] [date] NULL,
	[PaymentType_date_3] [date] NULL,
	[PaymentType_date_4] [date] NULL,
	[PaymentType_date_5] [date] NULL,
	[PaymentType_date_6] [date] NULL,
	[PaymentType_date_7] [date] NULL,
	[PaymentType_date_8] [date] NULL,
	[PaymentType_date_9] [date] NULL,
	[PaymentType_date_10] [date] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](50) NULL,
 CONSTRAINT [PK_PayementType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payment].[ReflectiveSettlement]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[ReflectiveSettlement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSettlement] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdGapSettlement] [int] NOT NULL,
 CONSTRAINT [PK_ReflectiveSettlement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[SessionCash]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[SessionCash](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[IdCashRegister] [int] NOT NULL,
	[OpeningDate] [datetime] NOT NULL,
	[LastCounter] [nvarchar](255) NOT NULL,
	[IdSeller] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[State] [int] NOT NULL,
	[ClosingDate] [datetime] NULL,
	[OpeningAmount] [float] NOT NULL,
	[ClosingAmount] [float] NOT NULL,
	[ClosingCashAmount] [float] NOT NULL,
	[CalculatedTotalAmount] [float] NOT NULL,
 CONSTRAINT [PK_SessionCash] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[Settlement]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[Settlement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NOT NULL,
	[SettlementDate] [date] NOT NULL,
	[IdPaymentMethod] [int] NOT NULL,
	[Amount] [float] NULL,
	[AmountWithCurrency] [float] NOT NULL,
	[ResidualAmount] [float] NULL,
	[ResidualAmountWithCurrency] [float] NULL,
	[IdStatus] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdUsedCurrency] [int] NULL,
	[ExchangeRate] [float] NULL,
	[AttachmentUrl] [nvarchar](max) NULL,
	[SettlementReference] [nvarchar](100) NULL,
	[IdBankAccount] [int] NULL,
	[Direction] [int] NOT NULL,
	[Code] [nvarchar](255) NULL,
	[IssuingBank] [nvarchar](255) NULL,
	[Holder] [nvarchar](255) NULL,
	[Type] [int] NOT NULL,
	[CommitmentDate] [date] NULL,
	[IsAccounted] [bit] NOT NULL,
	[IdPaymentStatus] [int] NULL,
	[HasBeenReplaced] [bit] NOT NULL,
	[WithholdingTax] [float] NULL,
	[IdPaymentSlip] [int] NULL,
	[WithholdingTaxAttachmentUrl] [nvarchar](max) NULL,
	[Label] [nvarchar](255) NULL,
	[IdReconciliation] [int] NULL,
	[IdSessionCash] [int] NULL,
 CONSTRAINT [PK_Settlement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payment].[SettlementCommitment]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[SettlementCommitment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommitmentId] [int] NOT NULL,
	[SettlementId] [int] NOT NULL,
	[AssignedAmount] [float] NULL,
	[AssignedAmountWithCurrency] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Direction] [int] NULL,
	[ExchangeRate] [float] NULL,
	[AssignedWithholdingTax] [float] NULL,
	[AssignedWithholdingTaxWithCurrency] [float] NULL,
 CONSTRAINT [PK_SettlementCommitment_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SettlementCommitment] UNIQUE NONCLUSTERED 
(
	[CommitmentId] ASC,
	[SettlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[SettlementDocumentWithholdingTax]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[SettlementDocumentWithholdingTax](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSettlement] [int] NOT NULL,
	[IdDocumentWithholdingTax] [int] NOT NULL,
	[AssignedWithholdingTax] [float] NULL,
	[AssignedWithholdingTaxWithCurrency] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TotalAmount] [float] NULL,
	[TotalAmountWithCurrency] [float] NOT NULL,
 CONSTRAINT [PK_SettlementDocumentWithholdingTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[WithholdingTax]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[WithholdingTax](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](50) NULL,
	[Designation] [nvarchar](255) NULL,
	[Percentage] [float] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_WithholdingTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payment].[WithholdingTaxLine]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payment].[WithholdingTaxLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdWithholdingTax] [int] NOT NULL,
	[IdReglement] [int] NOT NULL,
	[AmmountHolding] [float] NULL,
	[NetAmount] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[WithholdingTaxLine_int_1] [int] NULL,
	[WithholdingTaxLine_int_2] [int] NULL,
	[WithholdingTaxLine_int_3] [int] NULL,
	[WithholdingTaxLine_int_4] [int] NULL,
	[WithholdingTaxLine_int_5] [int] NULL,
	[WithholdingTaxLine_int_6] [int] NULL,
	[WithholdingTaxLine_int_7] [int] NULL,
	[WithholdingTaxLine_int_8] [int] NULL,
	[WithholdingTaxLine_int_9] [int] NULL,
	[WithholdingTaxLine_int_10] [int] NULL,
	[WithholdingTaxLine_bit_1] [bit] NULL,
	[WithholdingTaxLine_bit_2] [bit] NULL,
	[WithholdingTaxLine_bit_3] [bit] NULL,
	[WithholdingTaxLine_bit_4] [bit] NULL,
	[WithholdingTaxLine_bit_5] [bit] NULL,
	[WithholdingTaxLine_bit_6] [bit] NULL,
	[WithholdingTaxLine_bit_7] [bit] NULL,
	[WithholdingTaxLine_bit_8] [bit] NULL,
	[WithholdingTaxLine_bit_9] [bit] NULL,
	[WithholdingTaxLine_bit_10] [bit] NULL,
	[WithholdingTaxLine_float_1] [float] NULL,
	[WithholdingTaxLine_float_2] [float] NULL,
	[WithholdingTaxLine_float_3] [float] NULL,
	[WithholdingTaxLine_float_4] [float] NULL,
	[WithholdingTaxLine_float_5] [float] NULL,
	[WithholdingTaxLine_float_6] [float] NULL,
	[WithholdingTaxLine_float_7] [float] NULL,
	[WithholdingTaxLine_float_8] [float] NULL,
	[WithholdingTaxLine_float_9] [float] NULL,
	[WithholdingTaxLine_float_10] [float] NULL,
	[WithholdingTaxLine_varchar_1] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_2] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_3] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_4] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_5] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_6] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_7] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_8] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_9] [varchar](max) NULL,
	[WithholdingTaxLine_varchar_10] [varchar](max) NULL,
	[WithholdingTaxLine_date_1] [date] NULL,
	[WithholdingTaxLine_date_2] [date] NULL,
	[WithholdingTaxLine_date_3] [date] NULL,
	[WithholdingTaxLine_date_4] [date] NULL,
	[WithholdingTaxLine_date_5] [date] NULL,
	[WithholdingTaxLine_date_6] [date] NULL,
	[WithholdingTaxLine_date_7] [date] NULL,
	[WithholdingTaxLine_date_8] [date] NULL,
	[WithholdingTaxLine_date_9] [date] NULL,
	[WithholdingTaxLine_date_10] [date] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_WithholdingTaxLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[AdditionalHour]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[AdditionalHour](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Worked] [bit] NOT NULL,
	[IncreasePercentage] [float] NOT NULL,
 CONSTRAINT [PK_AdditionalHour] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[AdditionalHourSlot]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[AdditionalHourSlot](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdAdditionalHour] [int] NOT NULL,
 CONSTRAINT [PK_AdditionalHourSlot] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Attendance]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Attendance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdContract] [int] NOT NULL,
	[NumberDaysWorked] [float] NOT NULL,
	[NumberDaysPaidLeave] [float] NOT NULL,
	[NumberDaysNonPaidLeave] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[MaxNumberOfDaysAllowed] [float] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[AdditionalHourOne] [float] NOT NULL,
	[AdditionalHourTwo] [float] NOT NULL,
	[AdditionalHourThree] [float] NOT NULL,
	[AdditionalHourFour] [float] NOT NULL,
 CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[BaseSalary]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[BaseSalary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdContract] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Value] [float] NOT NULL,
	[StartDate] [date] NOT NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_BaseSalary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[BenefitInKind]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[BenefitInKind](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IdCnss] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](50) NOT NULL,
	[IsTaxable] [bit] NOT NULL,
	[DependNumberDaysWorked] [bit] NOT NULL,
 CONSTRAINT [PK_BenefitInKind] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Bonus]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Bonus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsFixe] [bit] NOT NULL,
	[IsTaxable] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdCnss] [int] NOT NULL,
	[DependNumberDaysWorked] [bit] NOT NULL,
 CONSTRAINT [PK_Premium] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[BonusValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[BonusValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [float] NOT NULL,
	[StartDate] [date] NOT NULL,
	[IdBonus] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Contract_PremiumValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Cnss]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Cnss](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[EmployerRate] [float] NOT NULL,
	[SalaryRate] [float] NOT NULL,
	[WorkAccidentQuota] [float] NOT NULL,
	[OperatingCode] [nvarchar](20) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Cnss] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[CnssDeclaration]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[CnssDeclaration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Trimester] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[CreationDate] [date] NOT NULL,
	[TotalAmount] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdCnss] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[State] [bit] NOT NULL,
 CONSTRAINT [PK_CnssDeclaration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[CnssDeclarationDetails]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[CnssDeclarationDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NumberOrder] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[FirstMonthValue] [float] NOT NULL,
	[SecondMonthValue] [float] NOT NULL,
	[ThirdMonthValue] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[IdCnssDeclaration] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[PageNumber] [int] NOT NULL,
 CONSTRAINT [PK_CnssDeclarationDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[CnssDeclarationSession]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[CnssDeclarationSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdCnssDeclaration] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_CnssDeclarationSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ConstantRate]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ConstantRate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdRuleUniqueReference] [int] NOT NULL,
 CONSTRAINT [PK_ConstantRate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ConstantRateValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ConstantRateValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[SalaryRate] [float] NULL,
	[EmployerRate] [float] NULL,
	[IdConstantRate] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ConstantRateValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ConstantValue]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ConstantValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdRuleUniqueReference] [int] NOT NULL,
 CONSTRAINT [PK_Constant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ConstantValueValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ConstantValueValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Value] [float] NOT NULL,
	[IdConstantValue] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_RuleValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Contract]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Contract](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContractReference] [nvarchar](255) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[WorkingTime] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmployee] [int] NOT NULL,
	[IdSalaryStructure] [int] NOT NULL,
	[IdCnss] [int] NOT NULL,
	[ContractAttached] [nvarchar](500) NULL,
	[IdContractType] [int] NOT NULL,
	[State] [int] NULL,
	[ThirteenthMonthBonus] [bit] NULL,
	[MealVoucher] [float] NULL,
	[AvailableCar] [bit] NULL,
	[AvailableHouse] [bit] NULL,
	[CommissionType] [int] NULL,
	[CommissionValue] [float] NULL,
 CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ContractAdvantage]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ContractAdvantage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdContract] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ContractAdvantage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ContractBenefitInKind]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ContractBenefitInKind](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdContract] [int] NOT NULL,
	[IdBenefitInKind] [int] NOT NULL,
	[ValidityStartDate] [date] NOT NULL,
	[ValidityEndDate] [date] NULL,
	[Value] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_ContractBenefitInKind] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ContractBonus]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ContractBonus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdBonus] [int] NOT NULL,
	[IdContract] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Value] [float] NULL,
	[ValidityStartDate] [date] NOT NULL,
	[ValidityEndDate] [date] NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_Contract_Premium] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ContractType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ContractType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](255) NOT NULL,
	[MinNoticePeriod] [int] NULL,
	[MaxNoticePeriod] [int] NULL,
	[Label] [nvarchar](255) NULL,
	[CalendarNoticeDays] [bit] NOT NULL,
	[HasEndDate] [bit] NOT NULL,
 CONSTRAINT [PK_ContractType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ContributionRegister]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ContributionRegister](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ContributionRegister] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Department]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentCode] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Domain] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[DocumentRequest]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[DocumentRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[SubmissionDate] [date] NOT NULL,
	[DeadLine] [date] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdDocumentRequestType] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[TreatmentDate] [date] NULL,
	[TreatedBy] [int] NULL,
	[Code] [nvarchar](255) NULL,
 CONSTRAINT [PK_DocumentRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[DocumentRequestEmail]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[DocumentRequestEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumentRequest] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DocumentRequestEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[DocumentRequestType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[DocumentRequestType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DocumentRequestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Employee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sex] [int] NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Matricule] [nvarchar](10) NULL,
	[AddressLine1] [nvarchar](255) NULL,
	[AddressLine2] [nvarchar](255) NULL,
	[AddressLine3] [nvarchar](255) NULL,
	[AddressLine4] [nvarchar](255) NULL,
	[AddressLine5] [nvarchar](255) NULL,
	[IdCountry] [int] NULL,
	[IdCity] [int] NULL,
	[ZipCode] [nvarchar](50) NULL,
	[PersonalPhone] [nvarchar](50) NULL,
	[ProfessionalPhone] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[BirthPlace] [nvarchar](50) NULL,
	[PseudoSkype] [nvarchar](255) NULL,
	[Facebook] [nvarchar](255) NULL,
	[Linkedin] [nvarchar](255) NULL,
	[SocialSecurityNumber] [nvarchar](50) NULL,
	[ChildrenNumber] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdGrade] [int] NULL,
	[IdUpperHierarchy] [int] NULL,
	[WorkingLicenseNumber] [nvarchar](255) NULL,
	[HiringDate] [date] NOT NULL,
	[Category] [nvarchar](50) NULL,
	[CIN] [nvarchar](50) NULL,
	[FamilyLeader] [bit] NULL,
	[Echelon] [int] NULL,
	[CinAttached] [nvarchar](500) NULL,
	[HomeLoan] [float] NULL,
	[ChildrenNoScholar] [int] NULL,
	[ChildrenDisabled] [int] NULL,
	[IsForeign] [bit] NOT NULL,
	[DependentParent] [int] NULL,
	[Picture] [nvarchar](500) NULL,
	[Rib] [nvarchar](50) NULL,
	[ResignationDate] [date] NULL,
	[ResignationDepositDate] [date] NULL,
	[IdCitizenship] [int] NULL,
	[IdPaymentType] [int] NULL,
	[SharedDocumentsPassword] [nvarchar](500) NULL,
	[PersonalEmail] [nvarchar](255) NULL,
	[IdOffice] [int] NULL,
	[HierarchyLevel] [nvarchar](max) NULL,
	[MaritalStatus] [int] NULL,
	[IdBank] [int] NULL,
	[Status] [int] NOT NULL,
	[ResignedFromExitEmployee] [bit] NOT NULL,
	[FullName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueKeyEmail] UNIQUE NONCLUSTERED 
(
	[Email] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueKeyMatricule] UNIQUE NONCLUSTERED 
(
	[Matricule] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[EmployeeDocument]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[EmployeeDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](250) NULL,
	[Type] [int] NOT NULL,
	[Value] [nvarchar](250) NULL,
	[IdEmployee] [int] NOT NULL,
	[AttachedFile] [nvarchar](500) NULL,
	[ExpirationDate] [date] NULL,
	[IsPermanent] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_EmployeeDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[EmployeeSkills]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[EmployeeSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSkills] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Rate] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[EmployeeTeam]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[EmployeeTeam](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssignmentDate] [date] NOT NULL,
	[UnassignmentDate] [date] NULL,
	[IdEmployee] [int] NOT NULL,
	[IdTeam] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](max) NULL,
	[IsAssigned] [bit] NOT NULL,
	[AssignmentPercentage] [float] NOT NULL,
 CONSTRAINT [PK_EmployeeTeam] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitAction]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitActionEmployee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitActionEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](max) NULL,
	[IdExitEmployee] [int] NULL,
	[IdExitAction] [int] NULL,
	[Verify_Action] [bit] NOT NULL,
 CONSTRAINT [PK_ActionExitEmployee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitEmailForEmployee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitEmailForEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdExitEmployee] [int] NOT NULL,
 CONSTRAINT [PK_ExitEmailForEmployee_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitEmployee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdExitReason] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[ReleaseDate] [date] NOT NULL,
	[ExitEmployeeAttachementFile] [nvarchar](500) NULL,
	[CommentRh] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[TreatmentDate] [date] NULL,
	[TreatedBy] [int] NULL,
	[LegalExitDate] [date] NULL,
	[DamagingDeparture] [bit] NULL,
	[ExitDepositDate] [date] NULL,
	[MinNoticePeriodDate] [date] NULL,
	[MaxNoticePeriodDate] [date] NULL,
	[ExitPhysicalDate] [date] NULL,
	[StatePay] [int] NULL,
	[StateLeave] [int] NULL,
	[CreationDate] [date] NOT NULL,
	[RecoveredMaterial] [bit] NOT NULL,
 CONSTRAINT [PK_EmployeeExit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitEmployeeLeaveLine]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitEmployeeLeaveLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Details] [nvarchar](max) NULL,
	[Month] [date] NOT NULL,
	[DayTakenPerMonth] [nvarchar](max) NULL,
	[TotalTakenPerMonth] [float] NOT NULL,
	[AcquiredParMonth] [int] NOT NULL,
	[IdLeaveType] [int] NULL,
	[CumulativeTaken] [float] NOT NULL,
	[CumulativeAcquired] [float] NOT NULL,
	[BalancePerMonth] [float] NOT NULL,
	[IdExitEmployee] [int] NULL,
	[TotalTakenPerYear] [float] NOT NULL,
	[AcquiredPerYear] [float] NOT NULL,
	[Year] [int] NOT NULL,
	[BalancePerYear] [float] NOT NULL,
	[DayTakenPerYear] [nvarchar](max) NULL,
 CONSTRAINT [PK_ExitEmployeeLeaveLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitEmployeePayLine]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitEmployeePayLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Details] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[NumberDayWorked] [float] NULL,
	[State] [int] NULL,
	[Month] [date] NOT NULL,
	[IdExitEmployee] [int] NOT NULL,
 CONSTRAINT [PK_ExitEmployeePayLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitEmployeePayLineSalaryRule]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitEmployeePayLineSalaryRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSalaryRule] [int] NULL,
	[IdExitEmployeePayLine] [int] NULL,
	[Value] [float] NULL,
 CONSTRAINT [PK_LinesSalaryRule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExitReason]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExitReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_ExitReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExpenseReport]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExpenseReport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Purpose] [nvarchar](255) NOT NULL,
	[SubmissionDate] [date] NOT NULL,
	[TreatmentDate] [date] NULL,
	[Status] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[TotalAmount] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TreatedBy] [int] NULL,
	[Code] [nvarchar](255) NULL,
 CONSTRAINT [PK_ExpenseReport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExpenseReportDetails]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExpenseReportDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Amount] [float] NOT NULL,
	[IdCurrency] [int] NOT NULL,
	[IdExpenseReport] [int] NOT NULL,
	[IdExpenseReportDetailsType] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Date] [datetime] NOT NULL,
	[AttachmentUrl] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_ExpenseReportDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExpenseReportDetailsType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExpenseReportDetailsType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ExpenseReportDetailsType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ExpenseReportEmail]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ExpenseReportEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdExpenseReport] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ExpenseReportEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Grade]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Designation] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Job]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Job](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Designation] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[FunctionSheet] [nvarchar](max) NULL,
	[IdUpperJob] [int] NULL,
	[HierarchyLevel] [nvarchar](max) NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[JobEmployee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[JobEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NULL,
	[IdJob] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_JobEmployee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[JobSkills]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[JobSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdJob] [int] NOT NULL,
	[IdSkill] [int] NOT NULL,
	[Rate] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_JobSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Leave]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Leave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmployee] [int] NOT NULL,
	[IdLeaveType] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[DaysNumber] [float] NOT NULL,
	[HoursNumber] [float] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[LeaveAttachementFile] [nvarchar](500) NULL,
	[TreatmentDate] [date] NULL,
	[TreatedBy] [int] NULL,
	[Code] [nvarchar](255) NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Leave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[LeaveBalanceRemaining]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[LeaveBalanceRemaining](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdLeaveType] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[DeletedToken] [nvarchar](max) NULL,
	[RemainingBalanceDay] [float] NOT NULL,
	[RemainingBalanceHour] [float] NOT NULL,
	[CumulativeTakenDay] [float] NOT NULL,
	[CumulativeTakenHour] [float] NOT NULL,
	[CumulativeAcquiredDay] [float] NOT NULL,
	[CumulativeAcquiredHour] [float] NOT NULL,
 CONSTRAINT [PK_LeaveBalanceRemaining] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[LeaveEmail]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[LeaveEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdLeave] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_LeaveEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[LeaveType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[LeaveType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Label] [nvarchar](250) NOT NULL,
	[Paid] [bit] NOT NULL,
	[RequiredDocument] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MaximumNumberOfDays] [int] NOT NULL,
	[ExpiryDate] [date] NULL,
	[Calendar] [bit] NOT NULL,
	[Cumulable] [bit] NULL,
	[AuthorizedOvertaking] [bit] NOT NULL,
	[Period] [int] NOT NULL,
	[Worked] [bit] NOT NULL,
 CONSTRAINT [PK_LeaveType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Loan]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Loan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[State] [int] NULL,
	[Code] [nvarchar](255) NULL,
	[DisbursementDate] [date] NULL,
	[ApprouvementDate] [date] NULL,
	[Amount] [float] NOT NULL,
	[ObtainingDate] [date] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[Reason] [nvarchar](500) NULL,
	[LoanAttachementFile] [nvarchar](500) NULL,
	[MonthsNumber] [int] NOT NULL,
	[RefundStartDate] [date] NULL,
	[CreditType] [int] NULL,
 CONSTRAINT [PK_Loan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[LoanInstallment]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[LoanInstallment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[State] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Amount] [float] NOT NULL,
	[IdLoan] [int] NOT NULL,
	[Month] [date] NOT NULL,
 CONSTRAINT [PK_LoanInstallment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Note]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Note](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Mark] [nvarchar](max) NOT NULL,
	[idEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[idCreator] [int] NOT NULL,
 CONSTRAINT [PK_Note] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ParentInCharge]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ParentInCharge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdParentType] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
 CONSTRAINT [PK_ParentInCharge] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[ParentType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[ParentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ParentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Payslip]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Payslip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdContract] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdSession] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[Month] [date] NOT NULL,
	[IdTransferOrder] [int] NULL,
 CONSTRAINT [PK_Payslip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[PayslipDetails]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[PayslipDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rule] [nvarchar](255) NOT NULL,
	[Gain] [float] NOT NULL,
	[Deduction] [float] NOT NULL,
	[Order] [int] NOT NULL,
	[AppearsOnPaySlip] [bit] NOT NULL,
	[IdPayslip] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[NumberOfDays] [float] NOT NULL,
	[IdSalaryRule] [int] NULL,
	[IdBonus] [int] NULL,
	[IdBenefitInKind] [int] NULL,
	[IdLoanInstallment] [int] NULL,
	[IdAdditionalHour] [int] NULL,
 CONSTRAINT [PK_PayslipDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Qualification]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Qualification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[University] [nvarchar](255) NOT NULL,
	[QualificationDescritpion] [nvarchar](max) NULL,
	[GraduationYear] [int] NULL,
	[IdQualificationCountry] [int] NULL,
	[IdQualificationType] [int] NULL,
	[IdEmployee] [int] NULL,
	[QualificationAttached] [nvarchar](500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdCandidate] [int] NULL,
 CONSTRAINT [PK_Qualification_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[QualificationType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[QualificationType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_QualificationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[RuleUniqueReference]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[RuleUniqueReference](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [nvarchar](255) NOT NULL,
	[Type] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[DeletedToken] [nvarchar](255) NULL,
 CONSTRAINT [PK_RuleUniqueReference] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SalaryRule]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SalaryRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Order] [int] NOT NULL,
	[RuleType] [int] NOT NULL,
	[AppearsOnPaySlip] [bit] NOT NULL,
	[Applicability] [int] NOT NULL,
	[RuleCategory] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdContributionRegister] [int] NULL,
	[IdRuleUniqueReference] [int] NOT NULL,
	[DependNumberDaysWorked] [bit] NOT NULL,
	[UsedinNewsPaper] [bit] NULL,
 CONSTRAINT [PK_SalaryRule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SalaryRuleValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SalaryRuleValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[rule] [nvarchar](max) NULL,
	[IdSalaryRule] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_SalaryRuleValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SalaryStructure]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SalaryStructure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalaryStructureReference] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Order] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdParent] [int] NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_SalaryStructure] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SalaryStructureValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SalaryStructureValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[IdSalaryStructure] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_SalaryStructureValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SalaryStructureValidityPeriodSalaryRule]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdSalaryRule] [int] NOT NULL,
	[IdSalaryStructureValidityPeriod] [int] NOT NULL,
 CONSTRAINT [PK_SalaryStructureValidityPeriodSalaryRule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Session]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Session](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](125) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Month] [date] NOT NULL,
	[State] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[DependOnTimesheet] [bit] NOT NULL,
	[DaysOfWork] [float] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[DaysWorkedInTheWeek] [nvarchar](255) NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SessionBonus]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SessionBonus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdBonus] [int] NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdContract] [int] NOT NULL,
	[Value] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_PaySlip_Premium] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SessionContract]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SessionContract](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdContract] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SessionContract] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SessionLoanInstallment]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SessionLoanInstallment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdLoanInstallment] [int] NOT NULL,
	[IdContract] [int] NOT NULL,
	[Value] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SessionLoanInstallment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SharedDocument]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SharedDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubmissionDate] [datetime] NOT NULL,
	[AttachmentUrl] [nvarchar](255) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdType] [int] NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_SharedDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Skills]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Skills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Id_Family] [int] NULL,
 CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SkillsFamily]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SkillsFamily](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SkillsFamily] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SourceDeduction]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SourceDeduction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Year] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[TaxableWages] [float] NOT NULL,
	[NaturalAdvantage] [float] NOT NULL,
	[GrossTaxable] [float] NOT NULL,
	[RetainedReinvested] [float] NOT NULL,
	[SumIRPP] [float] NOT NULL,
	[CSS] [float] NOT NULL,
	[NetToPay] [float] NOT NULL,
	[IdSourceDeductionSession] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DetentionSource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SourceDeductionSession]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SourceDeductionSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](125) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Year] [int] NOT NULL,
	[State] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DetentionSourceSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[SourceDeductionSessionEmployee]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[SourceDeductionSessionEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSourceDeductionSession] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SourceDeductionSessionEmployee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Team]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamCode] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdDepartment] [int] NULL,
	[IdManager] [int] NOT NULL,
	[State] [bit] NOT NULL,
	[NumberOfAffected] [int] NULL,
	[IdTeamType] [int] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[TeamType]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[TeamType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_TeamType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[TransferOrder]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[TransferOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdBankAccount] [int] NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Month] [date] NOT NULL,
	[Title] [nvarchar](125) NOT NULL,
	[TotalAmount] [float] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_TransferOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[TransferOrderDetails]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[TransferOrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RIB] [nvarchar](50) NULL,
	[Amount] [float] NOT NULL,
	[IdTransferOrder] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmployee] [int] NOT NULL,
 CONSTRAINT [PK_TransferOrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[TransferOrderSession]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[TransferOrderSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSession] [int] NOT NULL,
	[IdTransferOrder] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TransferOrderSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[Variable]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[Variable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdRuleUniqueReference] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_Variable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Payroll].[VariableValidityPeriod]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Payroll].[VariableValidityPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[Formule] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdVariable] [int] NOT NULL,
	[State] [int] NULL,
 CONSTRAINT [PK_VariableValidityPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[Advantages]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Advantages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdOffer] [int] NOT NULL,
 CONSTRAINT [PK_Advantages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[Candidacy]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Candidacy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[State] [int] NOT NULL,
	[IdRecruitment] [int] NULL,
	[IdCandidate] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[CreationDate] [datetime] NOT NULL,
	[DepositDate] [datetime] NOT NULL,
	[IdEmail] [int] NULL,
 CONSTRAINT [PK_Candidacy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Candidate]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Candidate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sex] [int] NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[CIN] [nvarchar](50) NULL,
	[IsForeign] [bit] NOT NULL,
	[IdEmployee] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[LinkedIn] [nvarchar](max) NULL,
	[IdCitizenship] [int] NULL,
	[CreationDate] [date] NOT NULL,
	[IdCreationUser] [int] NULL,
	[IdOffice] [int] NULL,
	[BirthDate] [date] NULL,
	[AddressLine1] [nvarchar](255) NULL,
	[AddressLine2] [nvarchar](255) NULL,
	[AddressLine3] [nvarchar](255) NULL,
	[AddressLine4] [nvarchar](255) NULL,
	[AddressLine5] [nvarchar](255) NULL,
	[Facebook] [nvarchar](255) NULL,
	[PersonalPhone] [nvarchar](50) NULL,
	[ProfessionalPhone] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL,
	[FullName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Candidate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueKeyEmail] UNIQUE NONCLUSTERED 
(
	[Email] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[CriteriaMark]    Script Date: 05/11/2021 20:27:08 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[CriteriaMark](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Mark] [float] NULL,
	[IdEvaluationCriteria] [int] NOT NULL,
	[IdInterviewMark] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_CriteriaMark] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[CurriculumVitae]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[CurriculumVitae](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Entitled] [nvarchar](500) NOT NULL,
	[CurriculumVitaePath] [nvarchar](500) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdCandidate] [int] NOT NULL,
	[DepositDate] [date] NOT NULL,
 CONSTRAINT [PK_CV] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[EmployeeProject]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[EmployeeProject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssignmentDate] [datetime] NOT NULL,
	[UnassignmentDate] [date] NULL,
	[IdEmployee] [int] NOT NULL,
	[IdProject] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[AverageDailyRate] [float] NULL,
	[IsBillable] [bit] NOT NULL,
	[AssignmentPercentage] [float] NULL,
	[CompanyCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_EmployeeProject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[EmployeeTrainingSession]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[EmployeeTrainingSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdTrainingSession] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_EmployeeTrainingSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[EvaluationCriteria]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[EvaluationCriteria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](100) NOT NULL,
	[IdEvaluationCriteriaTheme] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_EvaluationCriteria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[EvaluationCriteriaTheme]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[EvaluationCriteriaTheme](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](100) NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_EvaluationCriteriaTheme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ExternalTrainer]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ExternalTrainer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](255) NULL,
	[YearsOfExperience] [int] NULL,
	[HourCost] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ExternalTrainer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ExternalTrainerSkills]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ExternalTrainerSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdExternalTrainer] [int] NULL,
	[IdSkills] [int] NULL,
	[IsRecognized] [bit] NULL,
	[IsCertified] [bit] NULL,
	[Rate] [int] NULL,
 CONSTRAINT [PK_ExternalTrainerSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ExternalTraining]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ExternalTraining](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdExternalTrainer] [int] NOT NULL,
	[IdTrainingCenterRoom] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTrainingSession] [int] NULL,
 CONSTRAINT [PK_ExternalTraining] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[FileDrive]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[FileDrive](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Type] [nvarchar](255) NULL,
	[IdParent] [int] NULL,
	[Size] [int] NOT NULL,
	[Path] [nvarchar](255) NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_FileDrive] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[FileDriveSharedDocument]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[FileDriveSharedDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SharingDate] [datetime] NULL,
	[AttachmentUrl] [varchar](250) NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_FileDriveSharedDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Formation]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Formation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdFormationType] [int] NOT NULL,
 CONSTRAINT [PK_Formation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[FormationType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[FormationType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Label] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_FormationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Interview]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Interview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AverageMark] [float] NULL,
	[CreationDate] [datetime] NOT NULL,
	[InterviewDate] [datetime] NOT NULL,
	[Remarks] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[IdInterviewType] [int] NULL,
	[IdCandidacy] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmail] [int] NULL,
	[IdReview] [int] NULL,
	[IdSupervisor] [int] NULL,
	[IdCreator] [int] NULL,
	[Token] [nvarchar](255) NULL,
	[EndTime] [time](7) NOT NULL,
	[IdExitEmployee] [int] NULL,
 CONSTRAINT [PK_Interview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[InterviewEmail]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[InterviewEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdInterview] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
	[CreationDate] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_InterviewEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[InterviewMark]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[InterviewMark](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Mark] [float] NULL,
	[IsRequired] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdInterview] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[InterviewerDecision] [int] NULL,
	[StrongPoints] [nvarchar](255) NULL,
	[Weaknesses] [nvarchar](255) NULL,
	[OtherInformations] [nvarchar](max) NULL,
 CONSTRAINT [PK_InterviewMark] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Employee_Interview] UNIQUE NONCLUSTERED 
(
	[IdEmployee] ASC,
	[IdInterview] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[InterviewQuestion]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[InterviewQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTheme] [int] NOT NULL,
 CONSTRAINT [PK_InterviewQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[InterviewQuestionTheme]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[InterviewQuestionTheme](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Theme] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_InterviewQuestionTheme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[InterviewType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[InterviewType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_InterviewType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[MobilityRequest]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[MobilityRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NULL,
	[IdEmployee] [int] NOT NULL,
	[IdCurrentOffice] [int] NOT NULL,
	[IdDestinationOffice] [int] NOT NULL,
	[DesiredMobilityDate] [datetime] NOT NULL,
	[EffectifMobilityDate] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
	[CreationDate] [datetime] NOT NULL,
	[IdCreationUser] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_MobilityRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[Objective]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Objective](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
	[ExpectedDate] [date] NOT NULL,
	[ObjectiveCollaboratorStatus] [int] NULL,
	[ObjectiveManagerStatus] [int] NULL,
	[DescriptionCollaborator] [nvarchar](max) NULL,
	[DescriptionManager] [nvarchar](max) NULL,
	[RealisationDate] [date] NULL,
	[IdReview] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmployee] [int] NOT NULL,
 CONSTRAINT [PK_Objective] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[Offer]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Offer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[State] [int] NOT NULL,
	[IdCandidacy] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[WorkingHoursPerWeek] [float] NOT NULL,
	[Salary] [float] NOT NULL,
	[ThirteenthMonthBonus] [bit] NULL,
	[IdSalaryStructure] [int] NOT NULL,
	[CreationDate] [date] NOT NULL,
	[SendingDate] [date] NULL,
	[IdEmail] [int] NULL,
	[IdCnss] [int] NOT NULL,
	[IdContractType] [int] NOT NULL,
	[Token] [nvarchar](255) NULL,
	[MealVoucher] [float] NULL,
	[AvailableCar] [bit] NULL,
	[AvailableHouse] [bit] NULL,
	[CommissionType] [int] NULL,
	[CommissionValue] [float] NULL,
 CONSTRAINT [PK_Offer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[OfferBenefitInKind]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[OfferBenefitInKind](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdOffer] [int] NOT NULL,
	[IdBenefitInKind] [int] NOT NULL,
	[ValidityStartDate] [date] NOT NULL,
	[ValidityEndDate] [date] NULL,
	[Value] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_OfferBenefitInKind] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[OfferBonus]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[OfferBonus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdOffer] [int] NOT NULL,
	[IdBonus] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Value] [float] NULL,
	[ValidityStartDate] [date] NOT NULL,
	[ValidityEndDate] [date] NULL,
 CONSTRAINT [PK_OfferBonus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Project]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](125) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[StartDate] [date] NOT NULL,
	[ExpectedEndDate] [date] NULL,
	[ProjectType] [int] NOT NULL,
	[IdTaxe] [int] NULL,
	[AverageDailyRate] [float] NULL,
	[IdTiers] [int] NULL,
	[IdSettlementMode] [int] NULL,
	[Default] [bit] NOT NULL,
	[IdContact] [int] NULL,
	[IdCurrency] [int] NULL,
	[IsBillable] [bit] NOT NULL,
	[ReferenceProject] [nvarchar](255) NULL,
	[ReferenceBc] [nvarchar](255) NULL,
	[LabelInInvoice] [nvarchar](255) NULL,
	[IdBankAccount] [int] NULL,
	[ProjectLabel] [nvarchar](255) NULL,
	[AttachementFile] [nvarchar](255) NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Question]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionLabel] [nvarchar](255) NOT NULL,
	[ResponseLabel] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdInterview] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Recruitment]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Recruitment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[YearOfExperience] [int] NULL,
	[WorkingHoursPerDays] [float] NULL,
	[Priority] [int] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[State] [int] NOT NULL,
	[CreationDate] [date] NOT NULL,
	[ClosingDate] [date] NULL,
	[IdQualificationType] [int] NOT NULL,
	[IdJob] [int] NOT NULL,
	[IdEmployeeAuthor] [int] NULL,
	[IdEmployeeValidator] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdOffice] [int] NULL,
	[RequestReason] [nvarchar](500) NULL,
	[ExpectedCandidateNumber] [int] NULL,
	[StartDate] [date] NULL,
	[IdContractType] [int] NULL,
	[Type] [int] NULL,
	[RequestStatus] [int] NULL,
	[Sex] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[OfferStatus] [int] NULL,
	[TreatmentDate] [date] NULL,
	[EndDate] [date] NULL,
	[OfferPicture] [nvarchar](500) NULL,
	[RecruitmentTypeCode] [nvarchar](255) NULL,
	[RecruitedCandidateNumber] [int] NOT NULL,
 CONSTRAINT [PK_Recruitment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[RecruitmentLanguage]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[RecruitmentLanguage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdRecruitment] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Rate] [int] NOT NULL,
 CONSTRAINT [PK_RequestLanguage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[RecruitmentSkills]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[RecruitmentSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSkills] [int] NOT NULL,
	[IdRecruitment] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Rate] [int] NOT NULL,
 CONSTRAINT [PK_RequestSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[Review]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReviewDate] [date] NOT NULL,
	[State] [int] NOT NULL,
	[IdEmployeeCollaborator] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdManager] [int] NULL,
	[FormManager] [int] NULL,
	[FormEmployee] [int] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ReviewFormation]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ReviewFormation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[FormationCollaboratorStatus] [int] NULL,
	[FormationManagerStatus] [int] NULL,
	[IdReview] [int] NOT NULL,
	[IdFormation] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[ManagerComment] [nvarchar](500) NULL,
	[CollaboratorComment] [nvarchar](500) NULL,
	[IdEmployee] [int] NOT NULL,
 CONSTRAINT [PK_ReviewFormation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ReviewResume]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ReviewResume](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResumeType] [int] NOT NULL,
	[Description] [nchar](255) NULL,
	[IdReview] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ReviewResume] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[ReviewSkills]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[ReviewSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CollaboratorMark] [int] NULL,
	[ManagerMark] [int] NULL,
	[IdReview] [int] NOT NULL,
	[IdSkills] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdEmployee] [int] NOT NULL,
	[IsOld] [bit] NOT NULL,
	[OldRate] [int] NULL,
 CONSTRAINT [PK_ReviewSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TimeSheet]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TimeSheet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Month] [date] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[TreatmentDate] [date] NULL,
	[IdEmployeeTreated] [int] NULL,
	[AttachementFile] [nvarchar](255) NULL,
 CONSTRAINT [PK_TimeSheet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TimeSheetLine]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TimeSheetLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[IdProject] [int] NULL,
	[Day] [date] NOT NULL,
	[IdTimeSheet] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Details] [nvarchar](max) NULL,
	[Valid] [bit] NOT NULL,
	[IdDayOff] [int] NULL,
	[IdLeave] [int] NULL,
	[Worked] [bit] NULL,
 CONSTRAINT [PK_TimeSheetLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[Training]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[Training](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](225) NOT NULL,
	[Description] [text] NOT NULL,
	[Duration] [float] NULL,
	[IsCertified] [bit] NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[IdSupplier] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TrainingPictureUrl] [nvarchar](255) NULL,
 CONSTRAINT [PK_Training] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingByEmployee]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingByEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdTraining] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TrainingByEmployee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingCenter]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingCenter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Place] [nvarchar](255) NULL,
	[OpeningTime] [time](7) NULL,
	[ClosingTime] [time](7) NULL,
	[ModeOfPayment] [int] NULL,
	[CenterPhoneNumber] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTrainingCenterManager] [int] NULL,
 CONSTRAINT [PK_TrainingCenter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingCenterManager]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingCenterManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TrainingCenterManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingCenterRoom]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingCenterRoom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Capacity] [int] NULL,
	[Availability] [int] NULL,
	[RoomType] [int] NULL,
	[RentPerHour] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTrainingCenter] [int] NOT NULL,
 CONSTRAINT [PK_TrainingCenterRoom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingExpectedSkills]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingExpectedSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTraining] [int] NOT NULL,
	[IdSkills] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TrainingExpectedSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingRequest]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpectedDate] [date] NULL,
	[Status] [int] NOT NULL,
	[CreationDate] [date] NOT NULL,
	[TreatmentDate] [date] NULL,
	[IdTraining] [int] NOT NULL,
	[IdEmployeeAuthor] [int] NOT NULL,
	[IdEmployeeCollaborator] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](250) NULL,
	[IdTrainingSession] [int] NULL,
 CONSTRAINT [PK_TrainingRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingRequiredSkills]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingRequiredSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTraining] [int] NOT NULL,
	[IdSkills] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TrainingRequiredSkills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingSeance]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingSeance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[StartHour] [time](7) NOT NULL,
	[EndHour] [time](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTrainingSession] [int] NOT NULL,
	[Details] [nvarchar](max) NULL,
	[DayOfWeek] [int] NULL,
 CONSTRAINT [PK_TrainingSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [RH].[TrainingSession]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[TrainingSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTraining] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Description] [nvarchar](255) NULL,
	[SessionPlan] [nvarchar](255) NULL,
	[Duration] [float] NULL,
	[SessionPlanUrl] [nvarchar](255) NULL,
	[IdExternalTrainer] [int] NULL,
	[IdEmployee] [int] NULL,
 CONSTRAINT [PK_TrainingPlanification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[UserFileAccess]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[UserFileAccess](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdFile] [int] NOT NULL,
	[ReadFile] [bit] NOT NULL,
	[WriteFile] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_UserFileAccess] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [RH].[UserFileModification]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [RH].[UserFileModification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdFile] [int] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_UserFileModification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[BillingEmployee]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[BillingEmployee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdBillingSession] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[IdTimeSheet] [int] NOT NULL,
	[IdProject] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsChecked] [bit] NOT NULL,
 CONSTRAINT [PK_BillingEmployee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[BillingSession]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[BillingSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](125) NOT NULL,
	[CreationDate] [date] NOT NULL,
	[Month] [date] NOT NULL,
	[State] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Code] [nvarchar](50) NOT NULL,
	[NumberOfNotGeneratedDocuments] [int] NULL,
 CONSTRAINT [PK_BillingSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DeliveryType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DeliveryType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DeliveryType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DetailsSettlementMode]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DetailsSettlementMode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSettlementMode] [int] NULL,
	[IdSettlementType] [int] NULL,
	[IdPaymentMethod] [int] NULL,
	[Percentage] [float] NULL,
	[NumberDays] [int] NULL,
	[SettlementDay] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[CompletePrinting] [nvarchar](max) NULL,
 CONSTRAINT [PK_DetailsSettlementMode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[Document]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Document](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Reference] [nvarchar](max) NULL,
	[IdDocumentStatus] [int] NOT NULL,
	[DocumentTypeCode] [nvarchar](255) NOT NULL,
	[Informations] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[IdContact] [int] NULL,
	[CreationDate] [datetime] NULL,
	[ValidationDate] [datetime] NULL,
	[DocumentDate] [datetime] NOT NULL,
	[DateTerm] [datetime] NULL,
	[DocumentHTPrice] [float] NULL,
	[DocumentTotalVatTaxes] [float] NULL,
	[DocumentTTCPrice] [float] NULL,
	[DocumentRemainingAmount] [float] NULL,
	[DocumentAmountPaid] [float] NULL,
	[DocumentTotalDiscount] [float] NULL,
	[AmountInLetter] [nvarchar](max) NULL,
	[WithHoldingFlag] [bit] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdDiscountGroupTiers] [int] NULL,
	[IdPaymentMethod] [int] NULL,
	[IdTaxeGroupTiers] [int] NULL,
	[Document_varchar_2] [varchar](max) NULL,
	[Document_varchar_3] [varchar](max) NULL,
	[Document_varchar_7] [varchar](max) NULL,
	[Document_varchar_8] [varchar](max) NULL,
	[Name] [nvarchar](255) NULL,
	[MatriculeFiscale] [nvarchar](255) NULL,
	[IdUsedCurrency] [int] NULL,
	[ExchangeRate] [float] NULL,
	[DocumentHTPriceWithCurrency] [float] NULL,
	[DocumentTotalVatTaxesWithCurrency] [float] NULL,
	[DocumentTTCPriceWithCurrency] [float] NULL,
	[DocumentRemainingAmountWithCurrency] [float] NULL,
	[DocumentAmountPaidWithCurrency] [float] NULL,
	[DocumentTotalDiscountWithCurrency] [float] NULL,
	[Adress] [nvarchar](max) NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Tel1] [nvarchar](255) NULL,
	[Tel2] [nvarchar](255) NULL,
	[IdSettlementMode] [int] NULL,
	[AttachmentUrl] [nvarchar](max) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdBankAccount] [int] NULL,
	[DocumentPriceIncludeVAT] [float] NULL,
	[DocumentPriceIncludeVATWithCurrency] [float] NULL,
	[DocumentOtherTaxes] [float] NULL,
	[DocumentOtherTaxesWithCurrency] [float] NULL,
	[DocumentMonthDate] [int] NULL,
	[IdDecisionMaker] [int] NULL,
	[DocumentTotalExcVatTaxes] [float] NULL,
	[DocumentTotalExcVatTaxesWithCurrency] [float] NULL,
	[IdValidator] [int] NULL,
	[IdDocumentAssociated] [int] NULL,
	[IsTermBilling] [bit] NOT NULL,
	[IdPriceRequest] [int] NULL,
	[IsGenerated] [bit] NOT NULL,
	[IdTimeSheet] [int] NULL,
	[IdProject] [int] NULL,
	[IsAccounted] [bit] NOT NULL,
	[IsBToB] [bit] NULL,
	[IdProvision] [int] NULL,
	[IdExchangeRate] [int] NULL,
	[IdCreator] [int] NULL,
	[InoicingType] [int] NULL,
	[IdDeliveryType] [int] NULL,
	[DocumentInvoicingNumber] [nvarchar](255) NULL,
	[DocumentInvoicingDate] [datetime] NULL,
	[IsDeliverySuccess] [bit] NULL,
	[Coefficient] [float] NULL,
	[IdInvoiceEcommerce] [int] NULL,
	[ProvisionalCode] [nvarchar](255) NULL,
	[IsRestaurn] [bit] NOT NULL,
	[Priority] [int] NULL,
	[IsFromGarage] [bit] NULL,
	[IsForPos] [bit] NULL,
	[IdVehicle] [int] NULL,
	[IsSynchronizedBToB] [bit] NOT NULL,
 CONSTRAINT [PK_DOCUMENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeDocument] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC,
	[DocumentTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentExpenseLine]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentExpenseLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodeExpenseLine] [nvarchar](50) NULL,
	[IdDocument] [int] NOT NULL,
	[IdExpense] [int] NOT NULL,
	[Designation] [nvarchar](300) NULL,
	[IdTaxe] [int] NULL,
	[HtAmoutLine] [float] NOT NULL,
	[TtcAmoutLine] [float] NOT NULL,
	[HtAmountLineWithCurrency] [float] NOT NULL,
	[TtcAmountLineWithCurrency] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdCurrency] [int] NULL,
	[ExchangeRate] [float] NULL,
	[IdTiers] [int] NULL,
	[TaxeAmoun] [float] NULL,
	[HtAmountLineWithCurrencyPercentage] [float] NOT NULL,
	[TaxeAmount] [float] NULL,
 CONSTRAINT [PK_DocumentExpenseLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentLine]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodeDocumentLine] [nvarchar](50) NULL,
	[IdDocument] [int] NOT NULL,
	[IdItem] [int] NOT NULL,
	[Designation] [nvarchar](300) NULL,
	[MovementQty] [float] NOT NULL,
	[IdMeasureUnit] [int] NULL,
	[IdPrices] [int] NULL,
	[IdWarehouse] [int] NULL,
	[HtUnitAmount] [float] NULL,
	[DiscountPercentage] [float] NULL,
	[HtAmount] [float] NOT NULL,
	[VatTaxAmount] [float] NULL,
	[VatTaxRate] [float] NULL,
	[HtTotalLine] [float] NULL,
	[TtcTotalLine] [float] NULL,
	[IdDocumentLineAssociated] [int] NULL,
	[IdDocumentLineStatus] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[HtUnitAmountWithCurrency] [float] NULL,
	[HtAmountWithCurrency] [float] NULL,
	[TtcAmountWithCurrency] [float] NULL,
	[HtTotalLineWithCurrency] [float] NULL,
	[TtcTotalLineWithCurrency] [float] NULL,
	[VatTaxAmountWithCurrency] [float] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Requirement] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[ExcVatTaxAmount] [float] NULL,
	[ExcVatTaxRate] [float] NULL,
	[ExcVatTaxAmountWithCurrency] [float] NULL,
	[UnitPriceFromQuotation] [float] NULL,
	[CostPrice] [float] NULL,
	[PercentageMargin] [float] NULL,
	[SellingPrice] [float] NULL,
	[ConclusiveSellingPrice] [float] NULL,
	[TaxeAmoun] [float] NULL,
	[IdDocumentAssociated] [int] NULL,
	[IdDeliveryAssociated] [int] NULL,
	[selectedItemSalePolicy] [int] NULL,
	[DateAvailability] [date] NULL,
	[TaxeAmount] [float] NULL,
	[IsFromGarage] [bit] NULL,
 CONSTRAINT [PK_DOCUMENTLINE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentLineNegotiationOptions]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentLineNegotiationOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumentLine] [int] NOT NULL,
	[Price] [float] NULL,
	[Qty] [float] NULL,
	[IsFinal] [bit] NOT NULL,
	[IsAccepted] [bit] NOT NULL,
	[IsRejected] [bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[IdUser] [int] NOT NULL,
	[QteSupplier] [float] NULL,
	[PriceSupplier] [float] NULL,
	[IdItem] [int] NOT NULL,
 CONSTRAINT [PK_DocumentLineNegotiationOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentLinePrices]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentLinePrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPrices] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[TransactionUserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DocumentLinePrices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentLineTaxe]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentLineTaxe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTaxe] [int] NOT NULL,
	[IdDocumentLine] [int] NOT NULL,
	[TaxeValue] [float] NULL,
	[TaxeAmount] [float] NULL,
	[TransactionUserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TaxeBase] [float] NULL,
	[TaxeBaseWithCurrency] [float] NULL,
	[TaxeValueWithCurrency] [float] NULL,
 CONSTRAINT [PK_DocumentLineTaxe] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentStatus]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_STATUS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeDocumentStatus] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentTaxsResume]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentTaxsResume](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Tax] [int] NULL,
	[HtAmount] [float] NULL,
	[HtAmountWithCurrency] [float] NULL,
	[TaxAmount] [float] NULL,
	[TaxAmountWithCurrency] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdDocument] [int] NOT NULL,
	[DiscountAmount] [float] NULL,
	[DiscountAmountWithCurrency] [float] NULL,
	[ExcVatTaxAmount] [float] NULL,
	[ExcVatTaxAmountWithCurrency] [float] NULL,
 CONSTRAINT [PK_DocumentTaxsResume] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentType](
	[CodeType] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Label] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[DefaultCodeDocumentTypeAssociated] [nvarchar](50) NULL,
	[IsStockAffected] [bit] NOT NULL,
	[StockOperation] [nvarchar](50) NULL,
	[StockOperationStatus] [nvarchar](50) NULL,
	[CreateAssociatedDocument] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsSaleDocumentType] [bit] NOT NULL,
	[IsFinancialCommitmentAffected] [bit] NOT NULL,
	[FinancialCommitmentDirection] [int] NULL,
	[IsActiveGeneration] [bit] NOT NULL,
	[LabelEn] [nvarchar](max) NULL,
 CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED 
(
	[CodeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeDocumentType] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentTypeRelation]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentTypeRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CodeDocumentType] [nvarchar](50) NOT NULL,
	[CodeDocumentTypeAssociated] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DocumentTypeRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[DocumentWithholdingTax]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[DocumentWithholdingTax](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDocument] [int] NOT NULL,
	[IdWithholdingTax] [int] NOT NULL,
	[AmountWithCurrency] [float] NOT NULL,
	[Amount] [float] NOT NULL,
	[WithholdingTaxWithCurrency] [float] NOT NULL,
	[WithholdingTax] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[RemainingWithholdingTaxWithCurrency] [float] NULL,
	[RemainingWithholdingTax] [float] NULL,
 CONSTRAINT [PK_DocumentWithholdingTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[Expense]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Expense](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdTaxe] [int] NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[FinancialCommitment]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[FinancialCommitment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDocument] [int] NULL,
	[CommitmentDate] [date] NOT NULL,
	[RemainingAmount] [float] NOT NULL,
	[RemainingAmountWithCurrency] [float] NULL,
	[IdPaymentMethod] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdStatus] [int] NULL,
	[Amount] [float] NULL,
	[AmountWithCurrency] [float] NULL,
	[BenefitPeriod] [int] NULL,
	[Direction] [int] NOT NULL,
	[Code] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[IdCurrency] [int] NULL,
	[ExchangeRate] [float] NULL,
	[FinancialCommitmentDate] [date] NULL,
	[WithholdingTaxWithCurrency] [float] NULL,
	[WithholdingTax] [float] NULL,
	[RemainingWithholdingTax] [float] NULL,
	[RemainingWithholdingTaxWithCurrency] [float] NULL,
	[AmountWithoutWithholdingTax] [float] NULL,
	[AmountWithoutWithholdingTaxWithCurrency] [float] NULL,
	[TtcWithholdingTaxWithCurrency] [float] NULL,
	[TtcWithholdingTax] [float] NULL,
	[VatWithholdingTaxWithCurrency] [float] NULL,
	[VatWithholdingTax] [float] NULL,
	[RemainingVatWithholdingTaxWithCurrency] [float] NULL,
	[RemainingVatWithholdingTax] [float] NULL,
 CONSTRAINT [PK_FinancialCommitment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[OperationType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[OperationType](
	[Id] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Label] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_OperationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeOperationType] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[PriceDetail]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[PriceDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPrices] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[Percentage] [float] NULL,
	[ReducedValue] [float] NULL,
	[SpecialPrice] [float] NULL,
	[MinimumQuantity] [float] NULL,
	[MaximumQuantity] [float] NULL,
	[TotalPrices] [float] NULL,
	[SaledItemsNumber] [float] NULL,
	[GiftedItemsNumber] [float] NULL,
	[TypeOfPriceDetail] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_PriceDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[PriceRequest]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[PriceRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Reference] [nvarchar](500) NULL,
	[DocumentDate] [date] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PriceRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[PriceRequestDetail]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[PriceRequestDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPriceRequest] [int] NOT NULL,
	[IdItem] [int] NOT NULL,
	[Designation] [nvarchar](300) NULL,
	[MovementQty] [float] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[IdTiers] [int] NOT NULL,
	[IdContact] [int] NULL,
 CONSTRAINT [PK_PriceRequestDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[Prices]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Prices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LabelPrices] [nvarchar](255) NULL,
	[CodePrices] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdUsedCurrency] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[AttachmentUrl] [nvarchar](max) NULL,
	[ContractCode] [nvarchar](255) NULL,
 CONSTRAINT [PK_TAXE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodePrices] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CodePrices] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[Provisioning]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Provisioning](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[ProjectDate] [datetime] NULL,
	[CreationDate] [datetime] NULL,
	[IdProvisioningOption] [int] NOT NULL,
	[IsPurchaseOrderGenerated] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NOT NULL,
 CONSTRAINT [PK_Provisioning] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[ProvisioningDetails]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[ProvisioningDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProvisioning] [int] NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdTiers] [int] NOT NULL,
	[MvtQty] [float] NULL,
	[LastePurchasePrice] [float] NULL,
	[TransactionUserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProvisioningDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[ProvisioningOption]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[ProvisioningOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SearchByQty] [bit] NOT NULL,
	[SearchByPurhaseHistory] [bit] NOT NULL,
	[SearchBySalesHistory] [bit] NOT NULL,
	[PucrahseStartDate] [datetime] NULL,
	[PucrahseEndDate] [datetime] NULL,
	[SalesStartDate] [datetime] NULL,
	[SalesEndDate] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NOT NULL,
	[SearchByNewReferences] [bit] NOT NULL,
	[NewReferencesStartDate] [datetime] NULL,
	[NewReferencesEndDate] [datetime] NULL,
 CONSTRAINT [PK_ProvisioningOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[PurchaseSettings]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[PurchaseSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOtherTaxes] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdPurchasingManager] [int] NULL,
	[PurchaseAllowItemManagedInStock] [bit] NOT NULL,
	[PurchaseAllowItemRelatedToSupplier] [bit] NOT NULL,
 CONSTRAINT [PK_PurchaseSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[SaleSettings]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SaleSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleOtherTaxes] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[InvoicingDay] [int] NULL,
	[InvoicingEndMonth] [bit] NOT NULL,
	[SaleAllowItemManagedInStock] [bit] NOT NULL,
	[AllowEditionItemDesignation] [bit] NOT NULL,
 CONSTRAINT [PK_SaleSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[SalesInvoiceLog]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SalesInvoiceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SalesInvoiceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[SalesPrice]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SalesPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NULL,
	[IsActivated] [bit] NOT NULL,
	[Value] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SalesPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[SearchItem]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SearchItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NOT NULL,
	[Date] [datetime] NULL,
	[SearchMethod] [nvarchar](max) NULL,
	[IdCashier] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SearchItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[SettlementMode]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SettlementMode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SettlementMode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeSettlementMode] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[SettlementType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[SettlementType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_SettlementType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeSettlementType] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[TaxeGroupTiers]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TaxeGroupTiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TaxeGroupTiers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTaxeGroupTiers] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[TaxeGroupTiersConfig]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TaxeGroupTiersConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTaxeGroupTiers] [int] NOT NULL,
	[IdTaxe] [int] NOT NULL,
	[Value] [float] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TaxeTiersConfig_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[TierCategory]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TierCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_TierCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTierCategory] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[Tiers]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Tiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdLegalForme] [int] NULL,
	[IdPaymentCondition] [int] NULL,
	[IdTypeTiers] [int] NOT NULL,
	[IdCity] [int] NULL,
	[IdCountry] [int] NULL,
	[CodeTiers] [nvarchar](50) NULL,
	[Name] [nvarchar](255) NULL,
	[Logo] [image] NULL,
	[Adress] [nvarchar](max) NULL,
	[Region] [nvarchar](max) NULL,
	[AuthorizedSettlement] [float] NULL,
	[Status] [int] NULL,
	[Rib] [nvarchar](255) NULL,
	[CIN] [nvarchar](50) NULL,
	[Discount] [float] NULL,
	[MatriculeFiscale] [nvarchar](255) NULL,
	[IdPaymentMethod] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdAccountingAccountTiers] [int] NULL,
	[CounterPartyAccount] [nvarchar](50) NULL,
	[CommercialRegister] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL,
	[AuthorizedAmountOrder] [float] NULL,
	[AuthorizedAmountDelivery] [float] NULL,
	[AuthorizedAmountInvoice] [float] NULL,
	[IdTaxeGroupTiers] [int] NULL,
	[IdCurrency] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[DeleveryDelay] [int] NULL,
	[PaymentDelay] [int] NULL,
	[IsCash] [bit] NULL,
	[IdEcommerceCustomer] [int] NULL,
	[ProvisionalAuthorizedAmountDelivery] [float] NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Linkedin] [nvarchar](255) NULL,
	[Facebook] [nvarchar](255) NULL,
	[Twitter] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[MapLocalisation] [nvarchar](255) NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[ActivitySector] [nvarchar](50) NULL,
	[LeadSource] [nvarchar](50) NULL,
	[IdPhone] [int] NULL,
	[CreationDate] [date] NULL,
	[IdSettlementMode] [int] NULL,
	[IdDeliveryType] [int] NULL,
	[TiersClassification] [int] NULL,
	[WasLead] [bit] NOT NULL,
	[IdSalesPrice] [int] NULL,
	[IdTierCategory] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[IsSynchronizedBToB] [bit] NOT NULL,
 CONSTRAINT [PK_TIERS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTiers] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CodeTiers] ASC,
	[IdTypeTiers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[Tiers_Provisioning]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Tiers_Provisioning](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NOT NULL,
	[IdProvisioning] [int] NOT NULL,
	[Total] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Tiers_Provisioning] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[TiersPrices]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TiersPrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NOT NULL,
	[IdPrices] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TiersPrices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_TiersPrices] UNIQUE NONCLUSTERED 
(
	[IdPrices] ASC,
	[IdTiers] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[TypePrices]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TypePrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodeTypePrices] [nvarchar](50) NOT NULL,
	[Description] [text] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TaxeType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTypePrices] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CodeTypePrices] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Sales].[TypeTiers]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[TypeTiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TYPETIERS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[Vehicle]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NULL,
	[IdVehicleBrand] [int] NULL,
	[IdVehicleModel] [int] NULL,
	[IdVehicleEnergy] [int] NULL,
	[RegistrationNumber] [nvarchar](255) NOT NULL,
	[ChassisNumber] [nvarchar](255) NULL,
	[Power] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Sales].[VehicleEnergy]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Sales].[VehicleEnergy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_VehicleEnergy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Address]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Address](
	[Id] [int] IDENTITY(100000,1) NOT NULL,
	[ZipCode] [nvarchar](255) NULL,
	[ExtraAdress] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedToken] [nvarchar](255) NULL,
	[PrincipalAddress] [nvarchar](255) NULL,
	[Label] [nvarchar](50) NULL,
	[IdCountry] [int] NULL,
	[IdCompany] [int] NULL,
	[IdCity] [int] NULL,
	[IdOffice] [int] NULL,
	[IdZipCode] [int] NULL,
 CONSTRAINT [PK_Adress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Bank]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Bank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](255) NOT NULL,
	[AttachmentUrl] [nvarchar](255) NULL,
	[WebSite] [nvarchar](50) NULL,
	[IdCountry] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdPhone] [int] NULL,
 CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[BankAccount]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[BankAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rib] [nvarchar](50) NOT NULL,
	[IBAN] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Agency] [nvarchar](250) NOT NULL,
	[Locality] [nvarchar](250) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[BIC] [nvarchar](50) NULL,
	[InitialBalance] [float] NOT NULL,
	[CurrentBalance] [float] NOT NULL,
	[IdBank] [int] NOT NULL,
	[Entitled] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Telephone] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Pic] [varchar](50) NULL,
	[TypeAccount] [int] NULL,
	[ZipCode] [nvarchar](50) NULL,
	[IdCurrency] [int] NOT NULL,
	[IdCountry] [int] NULL,
	[IdCity] [int] NULL,
 CONSTRAINT [PK_BankAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeBankAccount] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueIBANBankAccount] UNIQUE NONCLUSTERED 
(
	[IBAN] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueRIBBankAccount] UNIQUE NONCLUSTERED 
(
	[Rib] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[BankAgency]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[BankAgency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Label] [nvarchar](50) NULL,
	[IdBank] [int] NULL,
 CONSTRAINT [PK_BankAgency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[City]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IdCountry] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeCity] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Civility]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Civility](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CivilityCode] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Description] [text] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Civility_int_1] [int] NULL,
	[Civility_int_2] [int] NULL,
	[Civility_int_3] [int] NULL,
	[Civility_int_4] [int] NULL,
	[Civility_int_5] [int] NULL,
	[Civility_int_6] [int] NULL,
	[Civility_int_7] [int] NULL,
	[Civility_int_8] [int] NULL,
	[Civility_int_9] [int] NULL,
	[Civility_int_10] [int] NULL,
	[Civility_bit_1] [bit] NULL,
	[Civility_bit_2] [bit] NULL,
	[Civility_bit_3] [bit] NULL,
	[Civility_bit_4] [bit] NULL,
	[Civility_bit_5] [bit] NULL,
	[Civility_bit_6] [bit] NULL,
	[Civility_bit_7] [bit] NULL,
	[Civility_bit_8] [bit] NULL,
	[Civility_bit_9] [bit] NULL,
	[Civility_bit_10] [bit] NULL,
	[Civility_float_1] [float] NULL,
	[Civility_float_2] [float] NULL,
	[Civility_float_3] [float] NULL,
	[Civility_float_4] [float] NULL,
	[Civility_float_5] [float] NULL,
	[Civility_float_6] [float] NULL,
	[Civility_float_7] [float] NULL,
	[Civility_float_8] [float] NULL,
	[Civility_float_9] [float] NULL,
	[Civility_float_10] [float] NULL,
	[Civility_varchar_1] [varchar](max) NULL,
	[Civility_varchar_2] [varchar](max) NULL,
	[Civility_varchar_3] [varchar](max) NULL,
	[Civility_varchar_4] [varchar](max) NULL,
	[Civility_varchar_5] [varchar](max) NULL,
	[Civility_varchar_6] [varchar](max) NULL,
	[Civility_varchar_7] [varchar](max) NULL,
	[Civility_varchar_8] [varchar](max) NULL,
	[Civility_varchar_9] [varchar](max) NULL,
	[Civility_varchar_10] [varchar](max) NULL,
	[Civility_date_1] [date] NULL,
	[Civility_date_2] [date] NULL,
	[Civility_date_3] [date] NULL,
	[Civility_date_4] [date] NULL,
	[Civility_date_5] [date] NULL,
	[Civility_date_6] [date] NULL,
	[Civility_date_7] [date] NULL,
	[Civility_date_8] [date] NULL,
	[Civility_date_9] [date] NULL,
	[Civility_date_10] [date] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Civility] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeCivility] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CivilityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[Company]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[MatriculeFisc] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[CommercialRegister] [nvarchar](255) NULL,
	[TaxIdentNumber] [nvarchar](255) NULL,
	[Picture] [image] NULL,
	[Email] [nvarchar](255) NULL,
	[WebSite] [nvarchar](255) NULL,
	[SIRET] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Tel1] [nvarchar](50) NULL,
	[Tel2] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[FiscalStamp] [float] NULL,
	[NIC] [nvarchar](max) NULL,
	[IdNAF] [int] NULL,
	[Capital] [float] NULL,
	[PaymentOffset] [nchar](10) NULL,
	[IdATRate] [int] NULL,
	[HeuRef] [float] NULL,
	[RegularisationMode] [nvarchar](250) NULL,
	[IdCurrency] [int] NULL,
	[Culture] [nvarchar](50) NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[AttachmentUrl] [nvarchar](max) NULL,
	[DataLogoCompany] [image] NULL,
	[VatNumber] [nvarchar](50) NULL,
	[CnssAffiliation] [nvarchar](50) NULL,
	[TimeSheetPerHalfDay] [bit] NOT NULL,
	[Category] [nvarchar](255) NULL,
	[SecondaryEstablishment] [nvarchar](255) NULL,
	[PayDependOnTimesheet] [bit] NOT NULL,
	[DaysOfWork] [float] NULL,
	[ActivityArea] [int] NOT NULL,
	[ActivitySector] [nvarchar](50) NULL,
	[WithholdingTax] [bit] NOT NULL,
	[AllowEditionItemDesignation] [bit] NOT NULL,
	[AutomaticCandidateMailSending] [bit] NOT NULL,
	[DaysWorkedInTheWeek] [nvarchar](255) NULL,
	[IdDefaultTax] [int] NULL,
	[AllowRelationSupplierItems] [bit] NOT NULL,
	[NoteIsRequired] [bit] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeCompany] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueMatriculeFiscCompany] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[MatriculeFisc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[Contact]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Tel1] [nvarchar](255) NULL,
	[Tel2] [nvarchar](255) NULL,
	[Fax1] [nvarchar](255) NULL,
	[Fax2] [nvarchar](255) NULL,
	[Picture] [image] NULL,
	[Email] [nvarchar](255) NULL,
	[WebSite] [text] NULL,
	[IdVille] [int] NULL,
	[Adress] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Fonction] [varchar](255) NULL,
	[IdCompany] [int] NULL,
	[HomePhone] [nvarchar](255) NULL,
	[OtherPhone] [nvarchar](255) NULL,
	[AssistantPhone] [nvarchar](255) NULL,
	[AssistantName] [nvarchar](255) NULL,
	[Linkedin] [nvarchar](255) NULL,
	[Facebook] [nvarchar](255) NULL,
	[Twitter] [nvarchar](255) NULL,
	[UrlPicture] [nvarchar](255) NULL,
	[ContactType] [nvarchar](255) NULL,
	[Prefix] [nvarchar](255) NULL,
	[Classification] [nvarchar](255) NULL,
	[MapLocation] [nvarchar](255) NULL,
	[DateOfBirth] [datetime2](7) NULL,
	[Description] [nvarchar](255) NULL,
	[IdAddress] [int] NULL,
	[Label] [nvarchar](50) NULL,
	[IdAgency] [int] NULL,
	[IdOffice] [int] NULL,
	[WasLead] [bit] NOT NULL,
	[CreationDate] [date] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[ContactTypeDocument]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[ContactTypeDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdContact] [int] NULL,
	[CodeTypeDocument] [nvarchar](50) NULL,
	[IsChecked] [bit] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ContactTypeDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Counter]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Counter](
	[Id] [nvarchar](50) NOT NULL,
	[Prefix] [nvarchar](50) NULL,
	[Value] [bigint] NULL,
	[Counter_int_1] [int] NULL,
	[Counter_int_2] [int] NULL,
	[Counter_int_3] [int] NULL,
	[Counter_int_4] [int] NULL,
	[Counter_int_5] [int] NULL,
	[Counter_int_6] [int] NULL,
	[Counter_int_7] [int] NULL,
	[Counter_int_8] [int] NULL,
	[Counter_int_9] [int] NULL,
	[Counter_int_10] [int] NULL,
	[Counter_bit_1] [bit] NULL,
	[Counter_bit_2] [bit] NULL,
	[Counter_bit_3] [bit] NULL,
	[Counter_bit_4] [bit] NULL,
	[Counter_bit_5] [bit] NULL,
	[Counter_bit_6] [bit] NULL,
	[Counter_bit_7] [bit] NULL,
	[Counter_bit_8] [bit] NULL,
	[Counter_bit_9] [bit] NULL,
	[Counter_bit_10] [bit] NULL,
	[Counter_float_1] [float] NULL,
	[Counter_float_2] [float] NULL,
	[Counter_float_3] [float] NULL,
	[Counter_float_4] [float] NULL,
	[Counter_float_5] [float] NULL,
	[Counter_float_6] [float] NULL,
	[Counter_float_7] [float] NULL,
	[Counter_float_8] [float] NULL,
	[Counter_float_9] [float] NULL,
	[Counter_float_10] [float] NULL,
	[Counter_varchar_1] [varchar](max) NULL,
	[Counter_varchar_2] [varchar](max) NULL,
	[Counter_varchar_3] [varchar](max) NULL,
	[Counter_varchar_4] [varchar](max) NULL,
	[Counter_varchar_5] [varchar](max) NULL,
	[Counter_varchar_6] [varchar](max) NULL,
	[Counter_varchar_7] [varchar](max) NULL,
	[Counter_varchar_8] [varchar](max) NULL,
	[Counter_varchar_9] [varchar](max) NULL,
	[Counter_varchar_10] [varchar](max) NULL,
	[Counter_date_1] [date] NULL,
	[Counter_date_2] [date] NULL,
	[Counter_date_3] [date] NULL,
	[Counter_date_4] [date] NULL,
	[Counter_date_5] [date] NULL,
	[Counter_date_6] [date] NULL,
	[Counter_date_7] [date] NULL,
	[Counter_date_8] [date] NULL,
	[Counter_date_9] [date] NULL,
	[Counter_date_10] [date] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Counter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[Country]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Alpha2] [nvarchar](2) NULL,
	[Alpha3] [nvarchar](3) NULL,
	[NameEn] [nvarchar](255) NULL,
	[NameFr] [nvarchar](255) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ConstraintCode] UNIQUE NONCLUSTERED 
(
	[Code] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueAlpha2Country] UNIQUE NONCLUSTERED 
(
	[Alpha2] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueAlpha3Country] UNIQUE NONCLUSTERED 
(
	[Alpha3] ASC,
	[Deleted_Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodePays] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[DateToRemember]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[DateToRemember](
	[Id] [int] IDENTITY(100000,1) NOT NULL,
	[EventName] [nvarchar](255) NULL,
	[Date] [datetime2](7) NULL,
	[IdTiers] [int] NULL,
	[IdContact] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedToken] [nvarchar](255) NULL,
 CONSTRAINT [PK_DateToRemember] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[DayOff]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[DayOff](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Date] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdPeriod] [int] NOT NULL,
 CONSTRAINT [PK_DayOff] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Email]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Email](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](255) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Status] [int] NOT NULL,
	[Sender] [nvarchar](255) NOT NULL,
	[Receivers] [nvarchar](max) NOT NULL,
	[AttemptsToSendNumber] [int] NOT NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[GeneralSettings]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[GeneralSettings](
	[Id] [int] NOT NULL,
	[Keys] [nvarchar](255) NULL,
	[Field] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_GeneralSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Hours]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Hours](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[IdPeriod] [int] NOT NULL,
	[WorkTimeTable] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Hours] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[JobsParameter]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[JobsParameter](
	[Id] [int] NOT NULL,
	[Keys] [nvarchar](255) NULL,
	[Field] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_JobsParameter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Language]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[NewUserEmail]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[NewUserEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdEmail] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_NewUserEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Office]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Office](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OfficeName] [nvarchar](255) NOT NULL,
	[AddressLine1] [nvarchar](255) NULL,
	[AddressLine2] [nvarchar](255) NULL,
	[AddressLine3] [nvarchar](255) NULL,
	[AddressLine4] [nvarchar](255) NULL,
	[AddressLine5] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Facebook] [nvarchar](255) NULL,
	[LinkedIn] [nvarchar](max) NULL,
	[IdOfficeManager] [int] NULL,
	[IdCreationUser] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[CreationDate] [datetime] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Twitter] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
 CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[Period]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Period](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[FirstDayOfWork] [int] NOT NULL,
	[LastDayOfWork] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Phone]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Phone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NULL,
	[DialCode] [nchar](5) NULL,
	[CountryCode] [nchar](10) NULL,
	[TransactionUserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[IdContact] [int] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[Taxe]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[Taxe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NULL,
	[CodeTaxe] [nvarchar](255) NULL,
	[TaxeValue] [float] NULL,
	[IdTaxeType] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TaxeType] [int] NOT NULL,
	[IdAccountingAccountSales] [int] NULL,
	[IdAccountingAccountPurchase] [int] NULL,
	[IsCalculable] [bit] NOT NULL,
 CONSTRAINT [PK_Taxe_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTaxe] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[CodeTaxe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Shared].[TaxeType]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[TaxeType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaxeTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[IdTaxeTypeCalculation] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_TaxeType_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueCodeTaxeType] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[TaxeTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Shared].[ZipCode]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Shared].[ZipCode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Region] [nvarchar](50) NULL,
	[Code] [nchar](10) NULL,
	[IdCity] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[DetailReconciliation]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[DetailReconciliation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdReconciliation] [int] NULL,
	[IdPayment] [int] NULL,
	[IdDetailTimetable] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DetailReconciliation_IdDetailReconciliation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[DetailTimetable]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[DetailTimetable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTimetable] [int] NULL,
	[IdPaymentType] [int] NULL,
	[IdBankAccount] [int] NULL,
	[IdCaisse] [int] NULL,
	[DateTimetable] [date] NULL,
	[PriceTimetable] [float] NULL,
	[IsPaid] [bit] NULL,
	[PostponedDate] [date] NULL,
	[RemainingPrice] [float] NULL,
	[Meaning] [nvarchar](255) NULL,
	[Activity] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
	[IdDetailTimetableAxis_1] [int] NULL,
	[IdDetailTimetableAxis_2] [int] NULL,
	[IdDetailTimetableAxis_3] [int] NULL,
	[IdDetailTimetableAxis_4] [int] NULL,
	[IdDetailTimetableAxis_5] [int] NULL,
	[IdDetailTimetableAxis_6] [int] NULL,
	[IdDetailTimetableAxis_7] [int] NULL,
	[IdDetailTimetableAxis_8] [int] NULL,
	[IdDetailTimetableAxis_9] [int] NULL,
	[IdDetailTimetableAxis_10] [int] NULL,
	[IdDetailTimetableAxis_11] [int] NULL,
	[IdDetailTimetableAxis_12] [int] NULL,
	[IdDetailTimetableAxis_13] [int] NULL,
	[IdDetailTimetableAxis_14] [int] NULL,
	[IdDetailTimetableAxis_15] [int] NULL,
	[IdDetailTimetableAxis_16] [int] NULL,
	[IdDetailTimetableAxis_17] [int] NULL,
	[IdDetailTimetableAxis_18] [int] NULL,
	[IdDetailTimetableAxis_19] [int] NULL,
	[IdDetailTimetableAxis_20] [int] NULL,
	[IdDetailTimetableAxis_21] [int] NULL,
	[IdDetailTimetableAxis_22] [int] NULL,
	[IdDetailTimetableAxis_23] [int] NULL,
	[IdDetailTimetableAxis_24] [int] NULL,
	[IdDetailTimetableAxis_25] [int] NULL,
	[IdDetailTimetableAxis_26] [int] NULL,
	[IdDetailTimetableAxis_27] [int] NULL,
	[IdDetailTimetableAxis_28] [int] NULL,
	[IdDetailTimetableAxis_29] [int] NULL,
	[IdDetailTimetableAxis_30] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_DetailTimetable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[OperationCash]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[OperationCash](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[AgentCode] [nvarchar](max) NOT NULL,
	[IdSession] [int] NOT NULL,
	[OperationDate] [datetime] NOT NULL,
	[Amount] [float] NOT NULL,
	[AmountWithCurrency] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NOT NULL,
 CONSTRAINT [PK_OperationCash] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Treasury].[PaymentDirection]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[PaymentDirection](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_PaymentDirection] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[ReceiptSpent]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[ReceiptSpent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](max) NULL,
	[IdTiers] [int] NULL,
	[Activity] [nvarchar](max) NULL,
	[ProvisionalAmount] [float] NULL,
	[IdPaymentMethod] [int] NULL,
	[Deadline] [date] NULL,
	[IdBankAccount] [int] NULL,
	[IdCaisse] [int] NULL,
	[IdPaymentDirection] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Periodicity] [varchar](50) NULL,
	[PeriodsNumber] [int] NULL,
	[IdReceiptSpentAxis_1] [int] NULL,
	[IdReceiptSpentAxis_2] [int] NULL,
	[IdReceiptSpentAxis_3] [int] NULL,
	[IdReceiptSpentAxis_4] [int] NULL,
	[IdReceiptSpentAxis_5] [int] NULL,
	[IdReceiptSpentAxis_6] [int] NULL,
	[IdReceiptSpentAxis_7] [int] NULL,
	[IdReceiptSpentAxis_8] [int] NULL,
	[IdReceiptSpentAxis_9] [int] NULL,
	[IdReceiptSpentAxis_10] [int] NULL,
	[IdReceiptSpentAxis_11] [int] NULL,
	[IdReceiptSpentAxis_12] [int] NULL,
	[IdReceiptSpentAxis_13] [int] NULL,
	[IdReceiptSpentAxis_14] [int] NULL,
	[IdReceiptSpentAxis_15] [int] NULL,
	[IdReceiptSpentAxis_16] [int] NULL,
	[IdReceiptSpentAxis_17] [int] NULL,
	[IdReceiptSpentAxis_18] [int] NULL,
	[IdReceiptSpentAxis_19] [int] NULL,
	[IdReceiptSpentAxis_20] [int] NULL,
	[IdReceiptSpentAxis_21] [int] NULL,
	[IdReceiptSpentAxis_22] [int] NULL,
	[IdReceiptSpentAxis_23] [int] NULL,
	[IdReceiptSpentAxis_24] [int] NULL,
	[IdReceiptSpentAxis_25] [int] NULL,
	[IdReceiptSpentAxis_26] [int] NULL,
	[IdReceiptSpentAxis_27] [int] NULL,
	[IdReceiptSpentAxis_28] [int] NULL,
	[IdReceiptSpentAxis_29] [int] NULL,
	[IdReceiptSpentAxis_30] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_RecipeSpent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Treasury].[Reconciliation]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[Reconciliation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](50) NULL,
	[ReconciliationDate] [datetime] NOT NULL,
	[IdBankAccount] [int] NOT NULL,
	[IsValidate] [bit] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[AttachmentUrl] [nvarchar](max) NULL,
	[TotalDebit] [float] NULL,
	[TotalCredit] [float] NULL,
 CONSTRAINT [PK_Reconciliation_IdReconciliation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
/****** Object:  Table [Treasury].[Ticket]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[Ticket](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](255) NULL,
	[CreationDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[IdDeliveryForm] [int] NOT NULL,
	[IdSessionCash] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[IdInvoice] [int] NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[TicketPayment]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[TicketPayment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[IdTicket] [int] NOT NULL,
	[IdPaymentType] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[ReceivedAmount] [float] NULL,
	[AmountReturned] [float] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_TicketPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
/****** Object:  Table [Treasury].[Timetable]    Script Date: 05/11/2021 20:27:09 ******/
SET ANSI_NULLS ON
 
SET QUOTED_IDENTIFIER ON
 
CREATE TABLE [Treasury].[Timetable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NULL,
	[IdPaymentType] [int] NULL,
	[IdBankAccount] [int] NULL,
	[IdCaisse] [int] NULL,
	[Titre] [nvarchar](255) NULL,
	[TotalPrice] [float] NULL,
	[DateFirstTimetable] [date] NULL,
	[PriceTimetable] [float] NULL,
	[Frequence] [nvarchar](255) NULL,
	[NumberOfTimetable] [int] NULL,
	[TransactionUserId] [int] NULL,
	[IdTimetableAxis_1] [int] NULL,
	[IdTimetableAxis_2] [int] NULL,
	[IdTimetableAxis_3] [int] NULL,
	[IdTimetableAxis_4] [int] NULL,
	[IdTimetableAxis_5] [int] NULL,
	[IdTimetableAxis_6] [int] NULL,
	[IdTimetableAxis_7] [int] NULL,
	[IdTimetableAxis_8] [int] NULL,
	[IdTimetableAxis_9] [int] NULL,
	[IdTimetableAxis_10] [int] NULL,
	[IdTimetableAxis_11] [int] NULL,
	[IdTimetableAxis_12] [int] NULL,
	[IdTimetableAxis_13] [int] NULL,
	[IdTimetableAxis_14] [int] NULL,
	[IdTimetableAxis_15] [int] NULL,
	[IdTimetableAxis_16] [int] NULL,
	[IdTimetableAxis_17] [int] NULL,
	[IdTimetableAxis_18] [int] NULL,
	[IdTimetableAxis_19] [int] NULL,
	[IdTimetableAxis_20] [int] NULL,
	[IdTimetableAxis_21] [int] NULL,
	[IdTimetableAxis_22] [int] NULL,
	[IdTimetableAxis_23] [int] NULL,
	[IdTimetableAxis_24] [int] NULL,
	[IdTimetableAxis_25] [int] NULL,
	[IdTimetableAxis_26] [int] NULL,
	[IdTimetableAxis_27] [int] NULL,
	[IdTimetableAxis_28] [int] NULL,
	[IdTimetableAxis_29] [int] NULL,
	[IdTimetableAxis_30] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Timetable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
SET ANSI_PADDING ON
 
/****** Object:  Index [IX_Entity]    Script Date: 05/11/2021 20:27:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Entity] ON [ERPSettings].[Entity]
(
	[EntityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
SET ANSI_PADDING ON
 
/****** Object:  Index [IX_Claim]    Script Date: 05/11/2021 20:27:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Claim] ON [Helpdesk].[Claim]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
SET ANSI_PADDING ON
 
/****** Object:  Index [index_name]    Script Date: 05/11/2021 20:27:09 ******/
CREATE NONCLUSTERED INDEX [index_name] ON [Inventory].[Item]
(
	[Id] ASC,
	[Code] ASC,
	[IdTiers] ASC,
	[IdNature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
SET ANSI_PADDING ON
 
/****** Object:  Index [IX_StockDocument]    Script Date: 05/11/2021 20:27:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StockDocument] ON [Inventory].[StockDocument]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
SET ANSI_PADDING ON
 
/****** Object:  Index [Unique_RuleUniqueReference]    Script Date: 05/11/2021 20:27:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Unique_RuleUniqueReference] ON [Payroll].[RuleUniqueReference]
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
ALTER TABLE [Administration].[Currency] ADD  CONSTRAINT [DF_Currency_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Ecommerce].[JobTable] ADD  CONSTRAINT [DF_JobTable_LastExecuteDate]  DEFAULT (datetimefromparts(datepart(year,getutcdate()),datepart(month,getutcdate()),datepart(day,getutcdate()),(0),(0),(0),(0))) FOR [LastExecuteDate]
 
ALTER TABLE [Ecommerce].[JobTable] ADD  CONSTRAINT [DF_JobTable_NextExecuteDate]  DEFAULT (dateadd(day,(1),datetimefromparts(datepart(year,getutcdate()),datepart(month,getutcdate()),datepart(day,getutcdate()),(0),(0),(0),(0)))) FOR [NextExecuteDate]
 
ALTER TABLE [ERPSettings].[Codification] ADD  CONSTRAINT [DF_Codification_IsCounter]  DEFAULT ((0)) FOR [IsCounter]
 
ALTER TABLE [ERPSettings].[Comment] ADD  CONSTRAINT [DF_Comment_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [ERPSettings].[Discussion] ADD  CONSTRAINT [DF_DiscussionChat_isPair]  DEFAULT ((0)) FOR [NumberOfDiscussionMember]
 
ALTER TABLE [ERPSettings].[Functionality] ADD  CONSTRAINT [DF_Functionality_IdFunctionality]  DEFAULT (newid()) FOR [IdFunctionality]
 
ALTER TABLE [ERPSettings].[Information] ADD  CONSTRAINT [DF_Information_IsMail]  DEFAULT ((0)) FOR [IsMail]
 
ALTER TABLE [ERPSettings].[Information] ADD  CONSTRAINT [DF_Information_IsNotification]  DEFAULT ((0)) FOR [IsNotification]
 
ALTER TABLE [ERPSettings].[Information] ADD  CONSTRAINT [DF_Information_IsAcceptedInfo]  DEFAULT ((0)) FOR [IsAcceptedInfo]
 
ALTER TABLE [ERPSettings].[Information] ADD  CONSTRAINT [DF_Information_IsToManager]  DEFAULT ((0)) FOR [IsToManager]
 
ALTER TABLE [ERPSettings].[Message] ADD  CONSTRAINT [DF_Message_TypeMessage]  DEFAULT ((1)) FOR [TypeMessage]
 
ALTER TABLE [ERPSettings].[User] ADD  DEFAULT ('true') FOR [IsActif]
 
ALTER TABLE [ERPSettings].[User] ADD  CONSTRAINT [DF_User_IsWithEmailNotification]  DEFAULT ((1)) FOR [IsWithEmailNotification]
 
ALTER TABLE [ERPSettings].[UserDiscussionChat] ADD  CONSTRAINT [DF_UserDiscussionChat_isNotif]  DEFAULT ((0)) FOR [HasNotif]
 
ALTER TABLE [ERPSettings].[UserInfo] ADD  CONSTRAINT [DF_UserInfo_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Helpdesk].[Claim] ADD  DEFAULT ((0)) FOR [IsClaimQtyLocked]
 
ALTER TABLE [Helpdesk].[ClaimInteraction] ADD  CONSTRAINT [DF_ClaimInteraction_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Helpdesk].[ClaimType] ADD  CONSTRAINT [DF_ClaimType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[Family] ADD  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[Item] ADD  CONSTRAINT [DF_Item_OnOrder]  DEFAULT ((0)) FOR [OnOrder]
 
ALTER TABLE [Inventory].[Item] ADD  CONSTRAINT [DF_Item_IsForPurchase]  DEFAULT ((1)) FOR [IsForPurchase]
 
ALTER TABLE [Inventory].[Item] ADD  CONSTRAINT [DF_Item_IsForSales]  DEFAULT ((1)) FOR [IsForSales]
 
ALTER TABLE [Inventory].[Item] ADD  CONSTRAINT [DF_Item_IsKit]  DEFAULT ((0)) FOR [IsKit]
 
ALTER TABLE [Inventory].[Item] ADD  DEFAULT ((0)) FOR [HaveClaims]
 
ALTER TABLE [Inventory].[Item] ADD  DEFAULT ((0)) FOR [IsEcommerce]
 
ALTER TABLE [Inventory].[Item] ADD  DEFAULT ((0)) FOR [ExistInEcommerce]
 
ALTER TABLE [Inventory].[Item] ADD  DEFAULT (getutcdate()) FOR [LastUpdateEcommerce]
 
ALTER TABLE [Inventory].[Item] ADD  DEFAULT ((0)) FOR [ProvInventory]
 
ALTER TABLE [Inventory].[ItemPrices] ADD  CONSTRAINT [DF_ItemPrices_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[ItemWarehouse] ADD  CONSTRAINT [DF_ItemWarehouse_AvailableQuantity]  DEFAULT ((0)) FOR [AvailableQuantity]
 
ALTER TABLE [Inventory].[ItemWarehouse] ADD  CONSTRAINT [DF_ItemWarehouse_ReservedQuantity]  DEFAULT ((0)) FOR [ReservedQuantity]
 
ALTER TABLE [Inventory].[ItemWarehouse] ADD  CONSTRAINT [DF_ItemWarehouse_OnOrderQuantity]  DEFAULT ((0)) FOR [OnOrderQuantity]
 
ALTER TABLE [Inventory].[ItemWarehouse] ADD  CONSTRAINT [DF_ItemWarehouse_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[ItemWarehouse] ADD  CONSTRAINT [DF_ItemWarehouse_OrderedQuantity]  DEFAULT ((0)) FOR [OrderedQuantity]
 
ALTER TABLE [Inventory].[MeasureUnit] ADD  CONSTRAINT [DF__UnitType__Transa__04AFB25B]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[MeasureUnit] ADD  CONSTRAINT [DF_MeasureUnit_IsDecomposable]  DEFAULT ((0)) FOR [IsDecomposable]
 
ALTER TABLE [Inventory].[MeasureUnit] ADD  CONSTRAINT [DF_MeasureUnit_DigitsAfterComma]  DEFAULT ((0)) FOR [DigitsAfterComma]
 
ALTER TABLE [Inventory].[ModelOfItem] ADD  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[MovementHistory] ADD  CONSTRAINT [DF_MovementHistory_IsPurchase]  DEFAULT ((0)) FOR [IsPurchase]
 
ALTER TABLE [Inventory].[MovementHistory] ADD  CONSTRAINT [DF_MovementHistory_IsSale]  DEFAULT ((0)) FOR [IsSale]
 
ALTER TABLE [Inventory].[Nature] ADD  CONSTRAINT [DF_Nature_IsStockManaged]  DEFAULT ((0)) FOR [IsStockManaged]
 
ALTER TABLE [Inventory].[Nature] ADD  CONSTRAINT [DF_Nature_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[Oem] ADD  CONSTRAINT [DF_Oem_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[ProductItem] ADD  CONSTRAINT [DF_ProductItem_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[Shelf] ADD  CONSTRAINT [DF_Shelf_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[Shelf] ADD  CONSTRAINT [DF_Shelf_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[StockDocument] ADD  CONSTRAINT [DF_StockDocument_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[StockDocumentLine] ADD  CONSTRAINT [DF_StockDocumentLine_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[StockDocumentType] ADD  CONSTRAINT [DF_TypeStockDocument_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[StockMovement] ADD  CONSTRAINT [DF__StockMove__Trans__29820FAE]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[Storage] ADD  CONSTRAINT [DF_Storage_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[Storage] ADD  CONSTRAINT [DF_Storage_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[SubFamily] ADD  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[SubModel] ADD  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[TaxeItem] ADD  CONSTRAINT [DF__TaxeArtic__Trans__24285DB4]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[VehicleBrand] ADD  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Inventory].[Warehouse] ADD  CONSTRAINT [DF__Warehouse__Trans__0C50D423]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Inventory].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_IsCentral]  DEFAULT ((0)) FOR [IsCentral]
 
ALTER TABLE [Inventory].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_IsWarehouse]  DEFAULT ((0)) FOR [IsWarehouse]
 
ALTER TABLE [Inventory].[Warehouse] ADD  DEFAULT ((0)) FOR [IsEcommerce]
 
ALTER TABLE [Inventory].[Warehouse] ADD  DEFAULT ((0)) FOR [ForEcommerceModule]
 
ALTER TABLE [Payment].[CashRegister] ADD  CONSTRAINT [DF_CashRegister_AgentCode]  DEFAULT ('') FOR [AgentCode]
 
ALTER TABLE [Payment].[PaymentCondition] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payment].[PaymentMethod] ADD  CONSTRAINT [DF__PayementM__Trans__0E391C95]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payment].[SessionCash] ADD  DEFAULT ('0000') FOR [LastCounter]
 
ALTER TABLE [Payment].[SessionCash] ADD  DEFAULT ((0)) FOR [ClosingCashAmount]
 
ALTER TABLE [Payment].[SessionCash] ADD  DEFAULT ((0)) FOR [CalculatedTotalAmount]
 
ALTER TABLE [Payment].[Settlement] ADD  CONSTRAINT [DF_Settlement_State]  DEFAULT ((0)) FOR [IdStatus]
 
ALTER TABLE [Payment].[Settlement] ADD  CONSTRAINT [DF_Settlement_Sens]  DEFAULT ((1)) FOR [Direction]
 
ALTER TABLE [Payment].[Settlement] ADD  CONSTRAINT [DF_Settlement_Type]  DEFAULT ((1)) FOR [Type]
 
ALTER TABLE [Payment].[Settlement] ADD  CONSTRAINT [DF_Settlement_IsAccounted]  DEFAULT ((0)) FOR [IsAccounted]
 
ALTER TABLE [Payment].[Settlement] ADD  CONSTRAINT [DF_Settlement_HasBeenReplaced]  DEFAULT ((0)) FOR [HasBeenReplaced]
 
ALTER TABLE [Payment].[WithholdingTax] ADD  DEFAULT ((1)) FOR [Type]
 
ALTER TABLE [Payroll].[BenefitInKind] ADD  CONSTRAINT [DF_BenefitInKind_IsTaxable]  DEFAULT ((0)) FOR [IsTaxable]
 
ALTER TABLE [Payroll].[BenefitInKind] ADD  CONSTRAINT [DF_BenefitInKind_DependNumberDaysWorked]  DEFAULT ((0)) FOR [DependNumberDaysWorked]
 
ALTER TABLE [Payroll].[Bonus] ADD  CONSTRAINT [DF_Bonus_DependNumberDaysWorked]  DEFAULT ((0)) FOR [DependNumberDaysWorked]
 
ALTER TABLE [Payroll].[CnssDeclaration] ADD  DEFAULT ('0') FOR [Code]
 
ALTER TABLE [Payroll].[CnssDeclaration] ADD  CONSTRAINT [DF_CnssDeclaration_State]  DEFAULT ((1)) FOR [State]
 
ALTER TABLE [Payroll].[CnssDeclarationDetails] ADD  DEFAULT ((0)) FOR [PageNumber]
 
ALTER TABLE [Payroll].[ContractType] ADD  DEFAULT ('') FOR [Code]
 
ALTER TABLE [Payroll].[ContractType] ADD  DEFAULT ('false') FOR [CalendarNoticeDays]
 
ALTER TABLE [Payroll].[ContractType] ADD  DEFAULT ('false') FOR [HasEndDate]
 
ALTER TABLE [Payroll].[Employee] ADD  CONSTRAINT [DF_Employee_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payroll].[Employee] ADD  CONSTRAINT [DF_Employee_IsForeign]  DEFAULT ((0)) FOR [IsForeign]
 
ALTER TABLE [Payroll].[Employee] ADD  CONSTRAINT [DF_Employee_Status]  DEFAULT ((1)) FOR [Status]
 
ALTER TABLE [Payroll].[Employee] ADD  CONSTRAINT [DF_Employee_ResignedFromExitEmployee]  DEFAULT ((0)) FOR [ResignedFromExitEmployee]
 
ALTER TABLE [Payroll].[EmployeeDocument] ADD  CONSTRAINT [DF_EmployeeDocument_IsPermanent]  DEFAULT ((0)) FOR [IsPermanent]
 
ALTER TABLE [Payroll].[EmployeeSkills] ADD  CONSTRAINT [DF_EmployeeSkills_Rate]  DEFAULT ((0)) FOR [Rate]
 
ALTER TABLE [Payroll].[EmployeeTeam] ADD  DEFAULT ((0)) FOR [IsAssigned]
 
ALTER TABLE [Payroll].[EmployeeTeam] ADD  DEFAULT ((0)) FOR [AssignmentPercentage]
 
ALTER TABLE [Payroll].[ExitActionEmployee] ADD  CONSTRAINT [DF_ExitActionEmployee_Verify_Action]  DEFAULT ((0)) FOR [Verify_Action]
 
ALTER TABLE [Payroll].[ExitEmployee] ADD  DEFAULT ((0)) FOR [RecoveredMaterial]
 
ALTER TABLE [Payroll].[ExpenseReport] ADD  CONSTRAINT [DF_ExpenseReport_TotalAmount]  DEFAULT ((0)) FOR [TotalAmount]
 
ALTER TABLE [Payroll].[JobEmployee] ADD  CONSTRAINT [DF_JobEmployee_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Payroll].[JobEmployee] ADD  CONSTRAINT [DF_JobEmployee_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payroll].[JobSkills] ADD  CONSTRAINT [DF_JobSkills_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Payroll].[JobSkills] ADD  CONSTRAINT [DF_JobSkills_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [RemainingBalanceDay]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [RemainingBalanceHour]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [CumulativeTakenDay]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [CumulativeTakenHour]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [CumulativeAcquiredDay]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD  DEFAULT ((0)) FOR [CumulativeAcquiredHour]
 
ALTER TABLE [Payroll].[LeaveType] ADD  DEFAULT ((1)) FOR [MaximumNumberOfDays]
 
ALTER TABLE [Payroll].[LeaveType] ADD  CONSTRAINT [DF_LeaveType_Calendar]  DEFAULT ((0)) FOR [Calendar]
 
ALTER TABLE [Payroll].[LeaveType] ADD  DEFAULT ((0)) FOR [AuthorizedOvertaking]
 
ALTER TABLE [Payroll].[LeaveType] ADD  DEFAULT ((1)) FOR [Period]
 
ALTER TABLE [Payroll].[LeaveType] ADD  DEFAULT ((0)) FOR [Worked]
 
ALTER TABLE [Payroll].[Payslip] ADD  CONSTRAINT [DF_Payslip_Status]  DEFAULT ((0)) FOR [Status]
 
ALTER TABLE [Payroll].[QualificationType] ADD  CONSTRAINT [DF_QualificationType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payroll].[SalaryRule] ADD  CONSTRAINT [DF_SalaryRule_DependNumberDaysWorked]  DEFAULT ((0)) FOR [DependNumberDaysWorked]
 
ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] ADD  DEFAULT ((1)) FOR [State]
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] ADD  DEFAULT ((1)) FOR [State]
 
ALTER TABLE [Payroll].[Session] ADD  DEFAULT ((0)) FOR [DependOnTimesheet]
 
ALTER TABLE [Payroll].[Session] ADD  DEFAULT ((26)) FOR [DaysOfWork]
 
ALTER TABLE [Payroll].[Session] ADD  DEFAULT ('0') FOR [Code]
 
ALTER TABLE [Payroll].[SourceDeduction] ADD  DEFAULT ((0)) FOR [Status]
 
ALTER TABLE [Payroll].[Team] ADD  DEFAULT ((0)) FOR [State]
 
ALTER TABLE [Payroll].[TeamType] ADD  CONSTRAINT [DF_TeamType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Payroll].[TransferOrder] ADD  CONSTRAINT [DF_TransferOrder_State]  DEFAULT ((0)) FOR [State]
 
ALTER TABLE [Payroll].[VariableValidityPeriod] ADD  DEFAULT ((1)) FOR [State]
 
ALTER TABLE [RH].[Candidacy] ADD  CONSTRAINT [DF_Candidacy_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[Candidate] ADD  CONSTRAINT [DF_Candidate_IsForeign]  DEFAULT ((0)) FOR [IsForeign]
 
ALTER TABLE [RH].[Candidate] ADD  CONSTRAINT [DF_Candidate_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [RH].[Candidate] ADD  CONSTRAINT [DF_Candidate_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[CurriculumVitae] ADD  CONSTRAINT [DF_CV_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[EmployeeProject] ADD  CONSTRAINT [DF_EmployeeProject_AssignmentDate]  DEFAULT (getdate()) FOR [AssignmentDate]
 
ALTER TABLE [RH].[EmployeeProject] ADD  CONSTRAINT [DF_EmployeeProject_Billable]  DEFAULT ((0)) FOR [IsBillable]
 
ALTER TABLE [RH].[FileDriveSharedDocument] ADD  CONSTRAINT [DF_FileDriveSharedDocument_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [RH].[FormationType] ADD  CONSTRAINT [DF_FormationType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [RH].[Interview] ADD  CONSTRAINT [DF_Interview_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[Interview] ADD  CONSTRAINT [DF_Interview_Status]  DEFAULT ((1)) FOR [Status]
 
ALTER TABLE [RH].[Interview] ADD  DEFAULT ('00:00:00') FOR [EndTime]
 
ALTER TABLE [RH].[InterviewMark] ADD  CONSTRAINT [DF_InterviewMark_isRequired]  DEFAULT ((0)) FOR [IsRequired]
 
ALTER TABLE [RH].[InterviewMark] ADD  CONSTRAINT [DF_InterviewMark_Status]  DEFAULT ((1)) FOR [Status]
 
ALTER TABLE [RH].[InterviewType] ADD  CONSTRAINT [DF_InterviewType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [RH].[MobilityRequest] ADD  CONSTRAINT [DF_MobilityOffice_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[MobilityRequest] ADD  CONSTRAINT [DF_MobilityOffice_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [RH].[Offer] ADD  CONSTRAINT [DF_Offer_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[Project] ADD  CONSTRAINT [DF_Project_Default]  DEFAULT ((0)) FOR [Default]
 
ALTER TABLE [RH].[Project] ADD  CONSTRAINT [DF_Project_IsForeign]  DEFAULT ((0)) FOR [IsBillable]
 
ALTER TABLE [RH].[Project] ADD  CONSTRAINT [DF_Project_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [RH].[Recruitment] ADD  CONSTRAINT [DF_Recruitment_RecruitedCandidateNumber]  DEFAULT ((0)) FOR [RecruitedCandidateNumber]
 
ALTER TABLE [RH].[TimeSheet] ADD  CONSTRAINT [DF_TimeSheet_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [Sales].[BillingEmployee] ADD  CONSTRAINT [DF_BillingEmployee_Checked]  DEFAULT ((0)) FOR [IsChecked]
 
ALTER TABLE [Sales].[BillingSession] ADD  DEFAULT ('0') FOR [Code]
 
ALTER TABLE [Sales].[BillingSession] ADD  CONSTRAINT [DF_BillingSession_NumberOfNotGeneratedDocuments]  DEFAULT ((0)) FOR [NumberOfNotGeneratedDocuments]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_WithHoldingFlag]  DEFAULT ((0)) FOR [WithHoldingFlag]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF__Document__Transa__628FA481]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_IsTermBilling]  DEFAULT ((0)) FOR [IsTermBilling]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_IsGenerated]  DEFAULT ((0)) FOR [IsGenerated]
 
ALTER TABLE [Sales].[Document] ADD  DEFAULT ((0)) FOR [IsAccounted]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_IsB2b]  DEFAULT ((0)) FOR [IsBToB]
 
ALTER TABLE [Sales].[Document] ADD  DEFAULT ((0)) FOR [IsDeliverySuccess]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_Coefficient]  DEFAULT ((1)) FOR [Coefficient]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_IsRestourn]  DEFAULT ((0)) FOR [IsRestaurn]
 
ALTER TABLE [Sales].[Document] ADD  DEFAULT ((0)) FOR [IsForPos]
 
ALTER TABLE [Sales].[Document] ADD  CONSTRAINT [DF_Document_IsSynchronizedBToB]  DEFAULT ((0)) FOR [IsSynchronizedBToB]
 
ALTER TABLE [Sales].[DocumentExpenseLine] ADD  CONSTRAINT [DF_DocumentExpenseLine_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[DocumentExpenseLine] ADD  DEFAULT ((0)) FOR [HtAmountLineWithCurrencyPercentage]
 
ALTER TABLE [Sales].[DocumentLine] ADD  CONSTRAINT [DF_DocumentLine_IsActive]  DEFAULT ((0)) FOR [IsActive]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] ADD  CONSTRAINT [DF_DocumentLineNegotiationOptions_IsFinal]  DEFAULT ((0)) FOR [IsFinal]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] ADD  CONSTRAINT [DF_DocumentLineNegotiationOptions_IsAccepted]  DEFAULT ((0)) FOR [IsAccepted]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] ADD  CONSTRAINT [DF_DocumentLineNegotiationOptions_IsRejected]  DEFAULT ((0)) FOR [IsRejected]
 
ALTER TABLE [Sales].[DocumentLinePrices] ADD  CONSTRAINT [DF_DocumentLinePrices_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[DocumentLineTaxe] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[DocumentStatus] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[DocumentType] ADD  CONSTRAINT [DF_DocumentType_IsStockAffected]  DEFAULT ((0)) FOR [IsStockAffected]
 
ALTER TABLE [Sales].[DocumentType] ADD  CONSTRAINT [DF_DocumentType_CreateAssociatedDocument]  DEFAULT ((0)) FOR [CreateAssociatedDocument]
 
ALTER TABLE [Sales].[DocumentType] ADD  CONSTRAINT [DF__TypeDocum__Trans__2F9A1060]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[DocumentType] ADD  CONSTRAINT [DF_DocumentType_IsFinancialCommitmentAffected]  DEFAULT ((0)) FOR [IsFinancialCommitmentAffected]
 
ALTER TABLE [Sales].[DocumentType] ADD  CONSTRAINT [DF_DocumentType_IsImmobilisationGeneration]  DEFAULT ((0)) FOR [IsActiveGeneration]
 
ALTER TABLE [Sales].[DocumentWithholdingTax] ADD  CONSTRAINT [DF_DocumentWithholdingTax_AmountWithCurrency]  DEFAULT ((0)) FOR [AmountWithCurrency]
 
ALTER TABLE [Sales].[DocumentWithholdingTax] ADD  CONSTRAINT [DF_DocumentWithholdingTax_Amount]  DEFAULT ((0)) FOR [Amount]
 
ALTER TABLE [Sales].[DocumentWithholdingTax] ADD  CONSTRAINT [DF_DocumentWithholdingTax_WithholdingTaxWithCurrency]  DEFAULT ((0)) FOR [WithholdingTaxWithCurrency]
 
ALTER TABLE [Sales].[DocumentWithholdingTax] ADD  CONSTRAINT [DF_DocumentWithholdingTax_withholdingTax]  DEFAULT ((0)) FOR [WithholdingTax]
 
ALTER TABLE [Sales].[Expense] ADD  CONSTRAINT [DF_Expense_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[OperationType] ADD  CONSTRAINT [DF_OperationType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[PriceDetail] ADD  CONSTRAINT [DF_PriceDetail_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[PriceRequest] ADD  CONSTRAINT [DF_PriceRequest_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[PriceRequestDetail] ADD  CONSTRAINT [DF_PriceRequestDetail_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[Prices] ADD  CONSTRAINT [DF__Taxe__Transactio__22401542]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[Provisioning] ADD  CONSTRAINT [DF_Provisioning_IsPurchaseOrderGenerated]  DEFAULT ((0)) FOR [IsPurchaseOrderGenerated]
 
ALTER TABLE [Sales].[ProvisioningOption] ADD  CONSTRAINT [DF_ProvisioningOption_SearchByQty]  DEFAULT ((0)) FOR [SearchByQty]
 
ALTER TABLE [Sales].[ProvisioningOption] ADD  CONSTRAINT [DF_ProvisioningOption_SearchByPurhaseHistory]  DEFAULT ((0)) FOR [SearchByPurhaseHistory]
 
ALTER TABLE [Sales].[ProvisioningOption] ADD  CONSTRAINT [DF_ProvisioningOption_SearchBySalesHistory]  DEFAULT ((0)) FOR [SearchBySalesHistory]
 
ALTER TABLE [Sales].[ProvisioningOption] ADD  CONSTRAINT [DF_ProvisioningOption_SearchBySalesHistory1]  DEFAULT ((0)) FOR [SearchByNewReferences]
 
ALTER TABLE [Sales].[PurchaseSettings] ADD  CONSTRAINT [DF_PurchaseSettings_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[PurchaseSettings] ADD  CONSTRAINT [DF_PurchaseSettings_AllowItemManagedInStock]  DEFAULT ((1)) FOR [PurchaseAllowItemManagedInStock]
 
ALTER TABLE [Sales].[PurchaseSettings] ADD  CONSTRAINT [DF_PurchaseSettings_PurchaseAllowItemRelatedToSupplier]  DEFAULT ((1)) FOR [PurchaseAllowItemRelatedToSupplier]
 
ALTER TABLE [Sales].[SaleSettings] ADD  CONSTRAINT [DF_SaleSettings_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[SaleSettings] ADD  CONSTRAINT [DF_SaleSettings_InvoicingEndMonth]  DEFAULT ((1)) FOR [InvoicingEndMonth]
 
ALTER TABLE [Sales].[SaleSettings] ADD  CONSTRAINT [DF_SaleSettings_PurchaseAllowItemManagedInStock]  DEFAULT ((1)) FOR [SaleAllowItemManagedInStock]
 
ALTER TABLE [Sales].[SaleSettings] ADD  DEFAULT ((0)) FOR [AllowEditionItemDesignation]
 
ALTER TABLE [Sales].[SalesInvoiceLog] ADD  CONSTRAINT [DF_SalesInvoiceLog_TransactionUserId1]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[SalesPrice] ADD  DEFAULT ((0)) FOR [Value]
 
ALTER TABLE [Sales].[SearchItem] ADD  CONSTRAINT [DF_SearchItem_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[TaxeGroupTiers] ADD  CONSTRAINT [DF_TaxeGroupTiers_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[TaxeGroupTiersConfig] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[Tiers] ADD  CONSTRAINT [DF__Tiers__Transacti__36DC0ACC]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[Tiers] ADD  CONSTRAINT [DF_Tiers_IsCash]  DEFAULT ((0)) FOR [IsCash]
 
ALTER TABLE [Sales].[Tiers] ADD  CONSTRAINT [DF_Tiers_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [Sales].[Tiers] ADD  DEFAULT ((1)) FOR [TiersClassification]
 
ALTER TABLE [Sales].[Tiers] ADD  CONSTRAINT [DF_Tiers_WasLead]  DEFAULT ((0)) FOR [WasLead]
 
ALTER TABLE [Sales].[Tiers] ADD  CONSTRAINT [DF_Tiers_IsSynchronizedBToB]  DEFAULT ((0)) FOR [IsSynchronizedBToB]
 
ALTER TABLE [Sales].[TiersPrices] ADD  CONSTRAINT [DF_TiersPrices_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[TypePrices] ADD  CONSTRAINT [DF__TaxeType__Transa__27F8EE98]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Sales].[TypeTiers] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[BankAccount] ADD  DEFAULT ((0)) FOR [InitialBalance]
 
ALTER TABLE [Shared].[BankAccount] ADD  DEFAULT ((0)) FOR [CurrentBalance]
 
ALTER TABLE [Shared].[BankAgency] ADD  CONSTRAINT [DF_BankAgency_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[City] ADD  CONSTRAINT [DF__City__Transactio__4E88ABD4]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Civility] ADD  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Company] ADD  CONSTRAINT [DF__Company__Transac__185783AC]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Company] ADD  CONSTRAINT [DF_Company_TimeSheetPerHalfDay]  DEFAULT ((1)) FOR [TimeSheetPerHalfDay]
 
ALTER TABLE [Shared].[Company] ADD  CONSTRAINT [DF_Company_PayDependOnPeriod]  DEFAULT ((0)) FOR [PayDependOnTimesheet]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ((1)) FOR [ActivityArea]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ((1)) FOR [WithholdingTax]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ((1)) FOR [AllowEditionItemDesignation]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ((0)) FOR [AutomaticCandidateMailSending]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ('false') FOR [AllowRelationSupplierItems]
 
ALTER TABLE [Shared].[Company] ADD  DEFAULT ('false') FOR [NoteIsRequired]
 
ALTER TABLE [Shared].[Contact] ADD  CONSTRAINT [DF__Contact__Transac__4E53A1AA]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Contact] ADD  CONSTRAINT [DF_Contact_WasLead]  DEFAULT ((0)) FOR [WasLead]
 
ALTER TABLE [Shared].[ContactTypeDocument] ADD  CONSTRAINT [DF_ContactTypeDocument_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Country] ADD  CONSTRAINT [DF_Country_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Shared].[Country] ADD  CONSTRAINT [DF__Pays__Transactio__40F9A68C]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[DayOff] ADD  CONSTRAINT [DF_DayOff_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Shared].[DayOff] ADD  CONSTRAINT [DF_DayOff_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Email] ADD  CONSTRAINT [DF_Email_AttemptsToSendNumber]  DEFAULT ((0)) FOR [AttemptsToSendNumber]
 
ALTER TABLE [Shared].[Hours] ADD  CONSTRAINT [DF_Hours_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Shared].[Hours] ADD  CONSTRAINT [DF_Hours_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Office] ADD  CONSTRAINT [DF_Office_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
 
ALTER TABLE [Shared].[Office] ADD  CONSTRAINT [DF_Office_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Period] ADD  CONSTRAINT [DF_Period_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
 
ALTER TABLE [Shared].[Period] ADD  CONSTRAINT [DF_Period_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Taxe] ADD  CONSTRAINT [DF_Taxe_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[Taxe] ADD  CONSTRAINT [DF_Taxe_TaxeType]  DEFAULT ((1)) FOR [TaxeType]
 
ALTER TABLE [Shared].[Taxe] ADD  DEFAULT ((0)) FOR [IsCalculable]
 
ALTER TABLE [Shared].[TaxeType] ADD  CONSTRAINT [DF_TaxeType_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Shared].[ZipCode] ADD  CONSTRAINT [DF_ZipCode_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Treasury].[PaymentDirection] ADD  CONSTRAINT [DF_PaymentDirection_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Treasury].[ReceiptSpent] ADD  CONSTRAINT [DF_ReceiptSpent_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Treasury].[Ticket] ADD  CONSTRAINT [DF_Ticket_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Treasury].[TicketPayment] ADD  CONSTRAINT [DF_TicketPayment_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
 
ALTER TABLE [Administration].[AxisEntity]  WITH CHECK ADD  CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1] FOREIGN KEY([IdAxis])
REFERENCES [Administration].[Axis] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Administration].[AxisEntity] CHECK CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1]
 
ALTER TABLE [Administration].[AxisEntity]  WITH CHECK ADD  CONSTRAINT [FK_AxisEntity_Entity] FOREIGN KEY([IdTableEntity])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [Administration].[AxisEntity] CHECK CONSTRAINT [FK_AxisEntity_Entity]
 
ALTER TABLE [Administration].[AxisRelationShip]  WITH CHECK ADD  CONSTRAINT [FK_AxisRelationShip_Axis] FOREIGN KEY([IdAxis])
REFERENCES [Administration].[Axis] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Administration].[AxisRelationShip] CHECK CONSTRAINT [FK_AxisRelationShip_Axis]
 
ALTER TABLE [Administration].[AxisRelationShip]  WITH CHECK ADD  CONSTRAINT [FK_AxisRelationShip_Axis1] FOREIGN KEY([IdAxisParent])
REFERENCES [Administration].[Axis] ([Id])
 
ALTER TABLE [Administration].[AxisRelationShip] CHECK CONSTRAINT [FK_AxisRelationShip_Axis1]
 
ALTER TABLE [Administration].[AxisValue]  WITH CHECK ADD  CONSTRAINT [FK__AxisValue__IdAxi__675524F5] FOREIGN KEY([IdAxis])
REFERENCES [Administration].[Axis] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Administration].[AxisValue] CHECK CONSTRAINT [FK__AxisValue__IdAxi__675524F5]
 
ALTER TABLE [Administration].[AxisValueRelationShip]  WITH CHECK ADD  CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0] FOREIGN KEY([IdAxisValue])
REFERENCES [Administration].[AxisValue] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Administration].[AxisValueRelationShip] CHECK CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0]
 
ALTER TABLE [Administration].[AxisValueRelationShip]  WITH CHECK ADD  CONSTRAINT [FK_AxisValueRelationShip_AxisValue] FOREIGN KEY([IdAxisValueParent])
REFERENCES [Administration].[AxisValue] ([Id])
 
ALTER TABLE [Administration].[AxisValueRelationShip] CHECK CONSTRAINT [FK_AxisValueRelationShip_AxisValue]
 
ALTER TABLE [Administration].[CurrencyRate]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Administration].[CurrencyRate] CHECK CONSTRAINT [FK_CurrencyRate_Currency]
 
ALTER TABLE [Administration].[EntityAxisValues]  WITH CHECK ADD  CONSTRAINT [FK_EntityAxisValues_AxisValue] FOREIGN KEY([IdAxisValue])
REFERENCES [Administration].[AxisValue] ([Id])
 
ALTER TABLE [Administration].[EntityAxisValues] CHECK CONSTRAINT [FK_EntityAxisValues_AxisValue]
 
ALTER TABLE [Administration].[EntityAxisValues]  WITH CHECK ADD  CONSTRAINT [FK_EntityAxisValues_Entity] FOREIGN KEY([Entity])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [Administration].[EntityAxisValues] CHECK CONSTRAINT [FK_EntityAxisValues_Entity]
 
ALTER TABLE [Ecommerce].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Ecommerce].[Delivery] CHECK CONSTRAINT [FK_Delivery_Item]
 
ALTER TABLE [Ecommerce].[TriggerItemLog]  WITH CHECK ADD  CONSTRAINT [FK_TriggerItemLog_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Ecommerce].[TriggerItemLog] CHECK CONSTRAINT [FK_TriggerItemLog_Item]
 
ALTER TABLE [ERPSettings].[Codification]  WITH CHECK ADD  CONSTRAINT [FK_Codification_Codification] FOREIGN KEY([IdCodificationParent])
REFERENCES [ERPSettings].[Codification] ([Id])
 
ALTER TABLE [ERPSettings].[Codification] CHECK CONSTRAINT [FK_Codification_Codification]
 
ALTER TABLE [ERPSettings].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Entity] FOREIGN KEY([IdEntityReference])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [ERPSettings].[Comment] CHECK CONSTRAINT [FK_Comment_Entity]
 
ALTER TABLE [ERPSettings].[Entity]  WITH CHECK ADD  CONSTRAINT [FK_Entity_Entity] FOREIGN KEY([IdRelatedEntity])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [ERPSettings].[Entity] CHECK CONSTRAINT [FK_Entity_Entity]
 
ALTER TABLE [ERPSettings].[EntityCodification]  WITH CHECK ADD  CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY([IdCodification])
REFERENCES [ERPSettings].[Codification] ([Id])
 
ALTER TABLE [ERPSettings].[EntityCodification] CHECK CONSTRAINT [FK_EntityCodification_Codification]
 
ALTER TABLE [ERPSettings].[EntityCodification]  WITH CHECK ADD  CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY([IdEntity])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [ERPSettings].[EntityCodification] CHECK CONSTRAINT [FK_EntityCodification_Entity]
 
ALTER TABLE [ERPSettings].[Functionality]  WITH CHECK ADD  CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY([IdRequestType])
REFERENCES [ERPSettings].[RequestType] ([Id])
 
ALTER TABLE [ERPSettings].[Functionality] CHECK CONSTRAINT [FK_Functionality_RequestType]
 
ALTER TABLE [ERPSettings].[Information]  WITH CHECK ADD  CONSTRAINT [FK_Information_Functionality] FOREIGN KEY([IdFunctionality])
REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
 
ALTER TABLE [ERPSettings].[Information] CHECK CONSTRAINT [FK_Information_Functionality]
 
ALTER TABLE [ERPSettings].[Information]  WITH CHECK ADD  CONSTRAINT [FK_Information_Information] FOREIGN KEY([IdInfoParent])
REFERENCES [ERPSettings].[Information] ([IdInfo])
 
ALTER TABLE [ERPSettings].[Information] CHECK CONSTRAINT [FK_Information_Information]
 
ALTER TABLE [ERPSettings].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Information_Message] FOREIGN KEY([IdInformation])
REFERENCES [ERPSettings].[Information] ([IdInfo])
 
ALTER TABLE [ERPSettings].[Message] CHECK CONSTRAINT [FK_Information_Message]
 
ALTER TABLE [ERPSettings].[MessageChat]  WITH NOCHECK ADD  CONSTRAINT [FK_MessageChat_UserDiscussionChat] FOREIGN KEY([IdUserDiscussion])
REFERENCES [ERPSettings].[UserDiscussionChat] ([Id])
 
ALTER TABLE [ERPSettings].[MessageChat] CHECK CONSTRAINT [FK_MessageChat_UserDiscussionChat]
 
ALTER TABLE [ERPSettings].[MsgNotification]  WITH CHECK ADD  CONSTRAINT [FK_MsgNotification_Message] FOREIGN KEY([IdMsg])
REFERENCES [ERPSettings].[Message] ([Id])
 
ALTER TABLE [ERPSettings].[MsgNotification] CHECK CONSTRAINT [FK_MsgNotification_Message]
 
ALTER TABLE [ERPSettings].[ReportTemplate]  WITH CHECK ADD  CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY([IdEntity])
REFERENCES [ERPSettings].[Entity] ([Id])
 
ALTER TABLE [ERPSettings].[ReportTemplate] CHECK CONSTRAINT [FK_ReportTemplate_Entity]
 
ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [ERPSettings].[User] CHECK CONSTRAINT [FK_User_Employee]
 
ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Phone] FOREIGN KEY([IdPhone])
REFERENCES [Shared].[Phone] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [ERPSettings].[User] CHECK CONSTRAINT [FK_User_Phone]
 
ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [ERPSettings].[User] CHECK CONSTRAINT [FK_User_Tiers]
 
ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([IdUserParent])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [ERPSettings].[User] CHECK CONSTRAINT [FK_User_User]
 
ALTER TABLE [ERPSettings].[UserDiscussionChat]  WITH NOCHECK ADD  CONSTRAINT [FK_UserDiscussionChat_DiscussionChat] FOREIGN KEY([IdDiscussion])
REFERENCES [ERPSettings].[Discussion] ([Id])
 
ALTER TABLE [ERPSettings].[UserDiscussionChat] CHECK CONSTRAINT [FK_UserDiscussionChat_DiscussionChat]
 
ALTER TABLE [ERPSettings].[UserDiscussionChat]  WITH NOCHECK ADD  CONSTRAINT [FK_UserDiscussionChat_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [ERPSettings].[UserDiscussionChat] CHECK CONSTRAINT [FK_UserDiscussionChat_User]
 
ALTER TABLE [ERPSettings].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_Info_UserInfo] FOREIGN KEY([IdInformation])
REFERENCES [ERPSettings].[Information] ([IdInfo])
 
ALTER TABLE [ERPSettings].[UserInfo] CHECK CONSTRAINT [FK_Info_UserInfo]
 
ALTER TABLE [ERPSettings].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_User_UserInfo] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [ERPSettings].[UserInfo] CHECK CONSTRAINT [FK_User_UserInfo]
 
ALTER TABLE [ERPSettings].[UserPrivilege]  WITH NOCHECK ADD  CONSTRAINT [FK_UserPrivilege_Privilege] FOREIGN KEY([IdPrivilege])
REFERENCES [ERPSettings].[Privilege] ([Id])
 
ALTER TABLE [ERPSettings].[UserPrivilege] CHECK CONSTRAINT [FK_UserPrivilege_Privilege]
 
ALTER TABLE [ERPSettings].[UserPrivilege]  WITH NOCHECK ADD  CONSTRAINT [FK_UserPrivilege_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [ERPSettings].[UserPrivilege] CHECK CONSTRAINT [FK_UserPrivilege_User]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_ClaimStatus] FOREIGN KEY([IdClaimStatus])
REFERENCES [Helpdesk].[ClaimStatus] ([IdStatus])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_ClaimStatus]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_ClaimType] FOREIGN KEY([ClaimType])
REFERENCES [Helpdesk].[ClaimType] ([CodeType])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_ClaimType]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Client] FOREIGN KEY([IdClient])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Client]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Contact]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_DeliveryDocument] FOREIGN KEY([IdDeliveryDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_DeliveryDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Document]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_DocumentLine] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_DocumentLine]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Fournisseur] FOREIGN KEY([IdFournisseur])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Fournisseur]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Item]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_MovementIn] FOREIGN KEY([IdMovementIn])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_MovementIn]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_MovementOut] FOREIGN KEY([IdMovementOut])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_MovementOut]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_PurchaseAssetDocument] FOREIGN KEY([IdPurchaseAssetDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_PurchaseAssetDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_PurchaseDocument] FOREIGN KEY([IdPurchaseDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_PurchaseDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_ReceiptDocument] FOREIGN KEY([IdReceiptDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_ReceiptDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_SalesAssetDocument] FOREIGN KEY([IdSalesAssetDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_SalesAssetDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_SalesDocument] FOREIGN KEY([IdSalesDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_SalesDocument]
 
ALTER TABLE [Helpdesk].[Claim]  WITH CHECK ADD  CONSTRAINT [FK_Claim_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Helpdesk].[Claim] CHECK CONSTRAINT [FK_Claim_Warehouse]
 
ALTER TABLE [Helpdesk].[ClaimInteraction]  WITH CHECK ADD  CONSTRAINT [FK_ClaimInteraction_Claim] FOREIGN KEY([IdClaim])
REFERENCES [Helpdesk].[Claim] ([Id])
 
ALTER TABLE [Helpdesk].[ClaimInteraction] CHECK CONSTRAINT [FK_ClaimInteraction_Claim]
 
ALTER TABLE [Immobilisation].[Active]  WITH CHECK ADD  CONSTRAINT [FK_Active_Category1] FOREIGN KEY([IdCategory])
REFERENCES [Immobilisation].[Category] ([Id])
 
ALTER TABLE [Immobilisation].[Active] CHECK CONSTRAINT [FK_Active_Category1]
 
ALTER TABLE [Immobilisation].[Active]  WITH CHECK ADD  CONSTRAINT [FK_Active_DocumentLine1] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Immobilisation].[Active] CHECK CONSTRAINT [FK_Active_DocumentLine1]
 
ALTER TABLE [Immobilisation].[Active]  WITH CHECK ADD  CONSTRAINT [FK_Active_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Immobilisation].[Active] CHECK CONSTRAINT [FK_Active_Warehouse]
 
ALTER TABLE [Immobilisation].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Active] FOREIGN KEY([IdActive])
REFERENCES [Immobilisation].[Active] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Immobilisation].[History] CHECK CONSTRAINT [FK_History_Active]
 
ALTER TABLE [Immobilisation].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Immobilisation].[History] CHECK CONSTRAINT [FK_History_Employee]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_Employee]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Family] FOREIGN KEY([IdFamily])
REFERENCES [Inventory].[Family] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_Family]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Item] FOREIGN KEY([IdItemReplacement])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_Item]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Nature] FOREIGN KEY([IdNature])
REFERENCES [Inventory].[Nature] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_Nature]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_ProductItem] FOREIGN KEY([IdProductItem])
REFERENCES [Inventory].[ProductItem] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_ProductItem]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_SubFamily] FOREIGN KEY([IdSubFamily])
REFERENCES [Inventory].[SubFamily] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_SubFamily]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_Tiers]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_UnitType] FOREIGN KEY([IdUnitSales])
REFERENCES [Inventory].[MeasureUnit] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_UnitType]
 
ALTER TABLE [Inventory].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_UnitType1] FOREIGN KEY([IdUnitStock])
REFERENCES [Inventory].[MeasureUnit] ([Id])
 
ALTER TABLE [Inventory].[Item] CHECK CONSTRAINT [FK_Item_UnitType1]
 
ALTER TABLE [Inventory].[ItemKit]  WITH CHECK ADD  CONSTRAINT [FK_ItemKit_Item] FOREIGN KEY([IdKit])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Inventory].[ItemKit] CHECK CONSTRAINT [FK_ItemKit_Item]
 
ALTER TABLE [Inventory].[ItemKit]  WITH CHECK ADD  CONSTRAINT [FK_ItemKit_Item1] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Inventory].[ItemKit] CHECK CONSTRAINT [FK_ItemKit_Item1]
 
ALTER TABLE [Inventory].[ItemPrices]  WITH CHECK ADD  CONSTRAINT [FK_ItemPrices_ItemPrices] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemPrices] CHECK CONSTRAINT [FK_ItemPrices_ItemPrices]
 
ALTER TABLE [Inventory].[ItemPrices]  WITH CHECK ADD  CONSTRAINT [FK_ItemPrices_Prices] FOREIGN KEY([IdPrices])
REFERENCES [Sales].[Prices] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemPrices] CHECK CONSTRAINT [FK_ItemPrices_Prices]
 
ALTER TABLE [Inventory].[ItemSalesPrice]  WITH CHECK ADD  CONSTRAINT [FK_ItemSalesPrice_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemSalesPrice] CHECK CONSTRAINT [FK_ItemSalesPrice_Item]
 
ALTER TABLE [Inventory].[ItemSalesPrice]  WITH CHECK ADD  CONSTRAINT [FK_ItemSalesPrice_SalesPrice] FOREIGN KEY([IdSalesPrice])
REFERENCES [Sales].[SalesPrice] ([Id])
 
ALTER TABLE [Inventory].[ItemSalesPrice] CHECK CONSTRAINT [FK_ItemSalesPrice_SalesPrice]
 
ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Item]
 
ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Tiers]
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]  WITH NOCHECK ADD  CONSTRAINT [FK_ItemVehicleBrandModelSubModel_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] CHECK CONSTRAINT [FK_ItemVehicleBrandModelSubModel_Item]
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]  WITH CHECK ADD  CONSTRAINT [FK_ItemVehicleBrandModelSubModel_ModelOfItem] FOREIGN KEY([IdModel])
REFERENCES [Inventory].[ModelOfItem] ([Id])
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] CHECK CONSTRAINT [FK_ItemVehicleBrandModelSubModel_ModelOfItem]
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]  WITH CHECK ADD  CONSTRAINT [FK_ItemVehicleBrandModelSubModel_SubModel] FOREIGN KEY([IdSubModel])
REFERENCES [Inventory].[SubModel] ([Id])
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] CHECK CONSTRAINT [FK_ItemVehicleBrandModelSubModel_SubModel]
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]  WITH CHECK ADD  CONSTRAINT [FK_ItemVehicleBrandModelSubModel_VehicleBrand] FOREIGN KEY([IdVehicleBrand])
REFERENCES [Inventory].[VehicleBrand] ([Id])
 
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] CHECK CONSTRAINT [FK_ItemVehicleBrandModelSubModel_VehicleBrand]
 
ALTER TABLE [Inventory].[ItemWarehouse]  WITH CHECK ADD  CONSTRAINT [FK_ItemWarehouse_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[ItemWarehouse] CHECK CONSTRAINT [FK_ItemWarehouse_Item]
 
ALTER TABLE [Inventory].[ItemWarehouse]  WITH NOCHECK ADD  CONSTRAINT [FK_ItemWarehouse_Shelf] FOREIGN KEY([IdShelf])
REFERENCES [Inventory].[Shelf] ([Id])
 
ALTER TABLE [Inventory].[ItemWarehouse] CHECK CONSTRAINT [FK_ItemWarehouse_Shelf]
 
ALTER TABLE [Inventory].[ItemWarehouse]  WITH NOCHECK ADD  CONSTRAINT [FK_ItemWarehouse_Storage] FOREIGN KEY([IdStorage])
REFERENCES [Inventory].[Storage] ([Id])
 
ALTER TABLE [Inventory].[ItemWarehouse] CHECK CONSTRAINT [FK_ItemWarehouse_Storage]
 
ALTER TABLE [Inventory].[ItemWarehouse]  WITH CHECK ADD  CONSTRAINT [FK_ItemWarehouse_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[ItemWarehouse] CHECK CONSTRAINT [FK_ItemWarehouse_Warehouse]
 
ALTER TABLE [Inventory].[ModelOfItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_Brand] FOREIGN KEY([IdVehicleBrand])
REFERENCES [Inventory].[VehicleBrand] ([Id])
 
ALTER TABLE [Inventory].[ModelOfItem] CHECK CONSTRAINT [FK_Model_Brand]
 
ALTER TABLE [Inventory].[MovementHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_MovementHistory_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Inventory].[MovementHistory] CHECK CONSTRAINT [FK_MovementHistory_Item]
 
ALTER TABLE [Inventory].[OemItem]  WITH CHECK ADD  CONSTRAINT [FK_OemItem_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[OemItem] CHECK CONSTRAINT [FK_OemItem_Item]
 
ALTER TABLE [Inventory].[OemItem]  WITH NOCHECK ADD  CONSTRAINT [FK_OemItem_VehicleBrand] FOREIGN KEY([IdBrand])
REFERENCES [Inventory].[VehicleBrand] ([Id])
 
ALTER TABLE [Inventory].[OemItem] CHECK CONSTRAINT [FK_OemItem_VehicleBrand]
 
ALTER TABLE [Inventory].[Shelf]  WITH CHECK ADD  CONSTRAINT [FK_Shelf_Warehouse] FOREIGN KEY([IdWharehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[Shelf] CHECK CONSTRAINT [FK_Shelf_Warehouse]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_DocumentStatus] FOREIGN KEY([IdDocumentStatus])
REFERENCES [Sales].[DocumentStatus] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_DocumentStatus]
 
ALTER TABLE [Inventory].[StockDocument]  WITH NOCHECK ADD  CONSTRAINT [FK_StockDocument_Storage] FOREIGN KEY([IdStorageSource])
REFERENCES [Inventory].[Storage] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_Storage]
 
ALTER TABLE [Inventory].[StockDocument]  WITH NOCHECK ADD  CONSTRAINT [FK_StockDocument_Storage1] FOREIGN KEY([IdStorageDestination])
REFERENCES [Inventory].[Storage] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_Storage1]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_Tiers]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_TypeStockDocument] FOREIGN KEY([TypeStockDocument])
REFERENCES [Inventory].[StockDocumentType] ([CodeType])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_TypeStockDocument]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_User]
 
ALTER TABLE [Inventory].[StockDocument]  WITH NOCHECK ADD  CONSTRAINT [FK_StockDocument_User1] FOREIGN KEY([IdInputUser1])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_User1]
 
ALTER TABLE [Inventory].[StockDocument]  WITH NOCHECK ADD  CONSTRAINT [FK_StockDocument_User2] FOREIGN KEY([IdInputUser2])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_User2]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_Warehouse] FOREIGN KEY([IdWarehouseDestination])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_Warehouse]
 
ALTER TABLE [Inventory].[StockDocument]  WITH CHECK ADD  CONSTRAINT [FK_StockDocument_Warehouse1] FOREIGN KEY([IdWarehouseSource])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[StockDocument] CHECK CONSTRAINT [FK_StockDocument_Warehouse1]
 
ALTER TABLE [Inventory].[StockDocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_StockDocumentLine_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Inventory].[StockDocumentLine] CHECK CONSTRAINT [FK_StockDocumentLine_Item]
 
ALTER TABLE [Inventory].[StockDocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_StockDocumentLine_StockDocument] FOREIGN KEY([IdStockDocument])
REFERENCES [Inventory].[StockDocument] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[StockDocumentLine] CHECK CONSTRAINT [FK_StockDocumentLine_StockDocument]
 
ALTER TABLE [Inventory].[StockDocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_StockDocumentLine_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[StockDocumentLine] CHECK CONSTRAINT [FK_StockDocumentLine_Warehouse]
 
ALTER TABLE [Inventory].[StockMovement]  WITH CHECK ADD  CONSTRAINT [FK_StockMovement_Claim] FOREIGN KEY([IdClaim])
REFERENCES [Helpdesk].[Claim] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Inventory].[StockMovement] CHECK CONSTRAINT [FK_StockMovement_Claim]
 
ALTER TABLE [Inventory].[StockMovement]  WITH CHECK ADD  CONSTRAINT [FK_StockMovement_DocumentLine] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[StockMovement] CHECK CONSTRAINT [FK_StockMovement_DocumentLine]
 
ALTER TABLE [Inventory].[StockMovement]  WITH CHECK ADD  CONSTRAINT [FK_StockMovement_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Inventory].[StockMovement] CHECK CONSTRAINT [FK_StockMovement_Item]
 
ALTER TABLE [Inventory].[StockMovement]  WITH CHECK ADD  CONSTRAINT [FK_StockMovement_StockDocumentLine] FOREIGN KEY([IdStockDocumentLine])
REFERENCES [Inventory].[StockDocumentLine] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[StockMovement] CHECK CONSTRAINT [FK_StockMovement_StockDocumentLine]
 
ALTER TABLE [Inventory].[StockMovement]  WITH CHECK ADD  CONSTRAINT [FK_StockMovement_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[StockMovement] CHECK CONSTRAINT [FK_StockMovement_Warehouse]
 
ALTER TABLE [Inventory].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_Shelf] FOREIGN KEY([IdShelf])
REFERENCES [Inventory].[Shelf] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[Storage] CHECK CONSTRAINT [FK_Storage_Shelf]
 
ALTER TABLE [Inventory].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_User] FOREIGN KEY([IdResponsable])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Inventory].[Storage] CHECK CONSTRAINT [FK_Storage_User]
 
ALTER TABLE [Inventory].[SubFamily]  WITH CHECK ADD  CONSTRAINT [FK_SubFamily_Family] FOREIGN KEY([IdFamily])
REFERENCES [Inventory].[Family] ([Id])
 
ALTER TABLE [Inventory].[SubFamily] CHECK CONSTRAINT [FK_SubFamily_Family]
 
ALTER TABLE [Inventory].[SubModel]  WITH CHECK ADD  CONSTRAINT [FK_SubModel_Model] FOREIGN KEY([IdModel])
REFERENCES [Inventory].[ModelOfItem] ([Id])
 
ALTER TABLE [Inventory].[SubModel] CHECK CONSTRAINT [FK_SubModel_Model]
 
ALTER TABLE [Inventory].[TaxeItem]  WITH CHECK ADD  CONSTRAINT [FK_TaxeItem_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Inventory].[TaxeItem] CHECK CONSTRAINT [FK_TaxeItem_Item]
 
ALTER TABLE [Inventory].[TaxeItem]  WITH CHECK ADD  CONSTRAINT [FK_TaxeItem_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Inventory].[TaxeItem] CHECK CONSTRAINT [FK_TaxeItem_Taxe]
 
ALTER TABLE [Inventory].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Employee] FOREIGN KEY([IdResponsable])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Inventory].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Employee]
 
ALTER TABLE [Inventory].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_User] FOREIGN KEY([IdUserResponsable])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Inventory].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_User]
 
ALTER TABLE [Inventory].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Warehouse] FOREIGN KEY([IdWarehouseParent])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Inventory].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Warehouse]
 
ALTER TABLE [Payment].[CashRegister]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_CashRegister] FOREIGN KEY([IdParentCash])
REFERENCES [Payment].[CashRegister] ([Id])
 
ALTER TABLE [Payment].[CashRegister] CHECK CONSTRAINT [FK_CashRegister_CashRegister]
 
ALTER TABLE [Payment].[CashRegister]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Payment].[CashRegister] CHECK CONSTRAINT [FK_CashRegister_City]
 
ALTER TABLE [Payment].[CashRegister]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Payment].[CashRegister] CHECK CONSTRAINT [FK_CashRegister_Country]
 
ALTER TABLE [Payment].[CashRegister]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_User] FOREIGN KEY([IdResponsible])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Payment].[CashRegister] CHECK CONSTRAINT [FK_CashRegister_User]
 
ALTER TABLE [Payment].[CashRegister]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Payment].[CashRegister] CHECK CONSTRAINT [FK_CashRegister_Warehouse]
 
ALTER TABLE [Payment].[FundsTransfer]  WITH NOCHECK ADD  CONSTRAINT [FK_FundsTransfer_Cashier] FOREIGN KEY([IdCashier])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Payment].[FundsTransfer] CHECK CONSTRAINT [FK_FundsTransfer_Cashier]
 
ALTER TABLE [Payment].[FundsTransfer]  WITH CHECK ADD  CONSTRAINT [FK_FundsTransfer_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Payment].[FundsTransfer] CHECK CONSTRAINT [FK_FundsTransfer_Currency]
 
ALTER TABLE [Payment].[FundsTransfer]  WITH CHECK ADD  CONSTRAINT [FK_FundsTransfer_DestinationCashRegister] FOREIGN KEY([IdDestinationCash])
REFERENCES [Payment].[CashRegister] ([Id])
 
ALTER TABLE [Payment].[FundsTransfer] CHECK CONSTRAINT [FK_FundsTransfer_DestinationCashRegister]
 
ALTER TABLE [Payment].[FundsTransfer]  WITH CHECK ADD  CONSTRAINT [FK_FundsTransfer_SourceCashRegister] FOREIGN KEY([IdSourceCash])
REFERENCES [Payment].[CashRegister] ([Id])
 
ALTER TABLE [Payment].[FundsTransfer] CHECK CONSTRAINT [FK_FundsTransfer_SourceCashRegister]
 
ALTER TABLE [Payment].[PaymentMethod]  WITH CHECK ADD  CONSTRAINT [FK_PayementMethod_PayementType] FOREIGN KEY([IdPaymentType])
REFERENCES [Payment].[PaymentType] ([Id])
 
ALTER TABLE [Payment].[PaymentMethod] CHECK CONSTRAINT [FK_PayementMethod_PayementType]
 
ALTER TABLE [Payment].[PaymentSlip]  WITH NOCHECK ADD  CONSTRAINT [FK_PaymentSlip_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [Payment].[PaymentSlip] CHECK CONSTRAINT [FK_PaymentSlip_BankAccount]
 
ALTER TABLE [Payment].[ReflectiveSettlement]  WITH CHECK ADD  CONSTRAINT [FK_ReflectiveSettlement_Settlement] FOREIGN KEY([IdSettlement])
REFERENCES [Payment].[Settlement] ([Id])
 
ALTER TABLE [Payment].[ReflectiveSettlement] CHECK CONSTRAINT [FK_ReflectiveSettlement_Settlement]
 
ALTER TABLE [Payment].[ReflectiveSettlement]  WITH CHECK ADD  CONSTRAINT [FK_ReflectiveSettlement_SettlementRelated] FOREIGN KEY([IdGapSettlement])
REFERENCES [Payment].[Settlement] ([Id])
 
ALTER TABLE [Payment].[ReflectiveSettlement] CHECK CONSTRAINT [FK_ReflectiveSettlement_SettlementRelated]
 
ALTER TABLE [Payment].[SessionCash]  WITH CHECK ADD  CONSTRAINT [FK_SessionCash_CashRegister] FOREIGN KEY([IdCashRegister])
REFERENCES [Payment].[CashRegister] ([Id])
 
ALTER TABLE [Payment].[SessionCash] CHECK CONSTRAINT [FK_SessionCash_CashRegister]
 
ALTER TABLE [Payment].[SessionCash]  WITH CHECK ADD  CONSTRAINT [FK_SessionCash_User] FOREIGN KEY([IdSeller])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Payment].[SessionCash] CHECK CONSTRAINT [FK_SessionCash_User]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_BankAccount]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_Currency] FOREIGN KEY([IdUsedCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_Currency]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_DocumentStatus] FOREIGN KEY([IdStatus])
REFERENCES [Sales].[DocumentStatus] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_DocumentStatus]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_PaymentMethod] FOREIGN KEY([IdPaymentMethod])
REFERENCES [Payment].[PaymentMethod] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_PaymentMethod]
 
ALTER TABLE [Payment].[Settlement]  WITH NOCHECK ADD  CONSTRAINT [FK_Settlement_PaymentSlip] FOREIGN KEY([IdPaymentSlip])
REFERENCES [Payment].[PaymentSlip] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_PaymentSlip]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_PaymentStatus] FOREIGN KEY([IdPaymentStatus])
REFERENCES [Payment].[PaymentStatus] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_PaymentStatus]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_Reconciliation] FOREIGN KEY([IdReconciliation])
REFERENCES [Treasury].[Reconciliation] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_Reconciliation]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_SessionCash] FOREIGN KEY([IdSessionCash])
REFERENCES [Payment].[SessionCash] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_SessionCash]
 
ALTER TABLE [Payment].[Settlement]  WITH CHECK ADD  CONSTRAINT [FK_Settlement_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Payment].[Settlement] CHECK CONSTRAINT [FK_Settlement_Tiers]
 
ALTER TABLE [Payment].[SettlementCommitment]  WITH CHECK ADD  CONSTRAINT [FK_SettlementCommitment_FinancialCommitment] FOREIGN KEY([CommitmentId])
REFERENCES [Sales].[FinancialCommitment] ([Id])
 
ALTER TABLE [Payment].[SettlementCommitment] CHECK CONSTRAINT [FK_SettlementCommitment_FinancialCommitment]
 
ALTER TABLE [Payment].[SettlementCommitment]  WITH CHECK ADD  CONSTRAINT [FK_SettlementCommitment_Settlement] FOREIGN KEY([SettlementId])
REFERENCES [Payment].[Settlement] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payment].[SettlementCommitment] CHECK CONSTRAINT [FK_SettlementCommitment_Settlement]
 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax]  WITH CHECK ADD  CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax] FOREIGN KEY([IdDocumentWithholdingTax])
REFERENCES [Sales].[DocumentWithholdingTax] ([Id])
 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax]
 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax]  WITH CHECK ADD  CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement] FOREIGN KEY([IdSettlement])
REFERENCES [Payment].[Settlement] ([Id])
 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement]
 
ALTER TABLE [Payment].[WithholdingTaxLine]  WITH CHECK ADD  CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax] FOREIGN KEY([IdWithholdingTax])
REFERENCES [Payment].[WithholdingTax] ([Id])
 
ALTER TABLE [Payment].[WithholdingTaxLine] CHECK CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax]
 
ALTER TABLE [Payroll].[AdditionalHourSlot]  WITH CHECK ADD  CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour] FOREIGN KEY([IdAdditionalHour])
REFERENCES [Payroll].[AdditionalHour] ([Id])
 
ALTER TABLE [Payroll].[AdditionalHourSlot] CHECK CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour]
 
ALTER TABLE [Payroll].[Attendance]  WITH NOCHECK ADD  CONSTRAINT [FK_Attendance_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Attendance] CHECK CONSTRAINT [FK_Attendance_Contract]
 
ALTER TABLE [Payroll].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Attendance] CHECK CONSTRAINT [FK_Attendance_Session]
 
ALTER TABLE [Payroll].[BaseSalary]  WITH CHECK ADD  CONSTRAINT [FK_BaseSalary_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[BaseSalary] CHECK CONSTRAINT [FK_BaseSalary_Contract]
 
ALTER TABLE [Payroll].[BenefitInKind]  WITH CHECK ADD  CONSTRAINT [FK_BenefitInKind_Cnss] FOREIGN KEY([IdCnss])
REFERENCES [Payroll].[Cnss] ([Id])
 
ALTER TABLE [Payroll].[BenefitInKind] CHECK CONSTRAINT [FK_BenefitInKind_Cnss]
 
ALTER TABLE [Payroll].[Bonus]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Cnss] FOREIGN KEY([IdCnss])
REFERENCES [Payroll].[Cnss] ([Id])
 
ALTER TABLE [Payroll].[Bonus] CHECK CONSTRAINT [FK_Bonus_Cnss]
 
ALTER TABLE [Payroll].[BonusValidityPeriod]  WITH CHECK ADD  CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus] FOREIGN KEY([IdBonus])
REFERENCES [Payroll].[Bonus] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[BonusValidityPeriod] CHECK CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus]
 
ALTER TABLE [Payroll].[CnssDeclaration]  WITH CHECK ADD  CONSTRAINT [FK_CnssDeclaration_Cnss] FOREIGN KEY([IdCnss])
REFERENCES [Payroll].[Cnss] ([Id])
 
ALTER TABLE [Payroll].[CnssDeclaration] CHECK CONSTRAINT [FK_CnssDeclaration_Cnss]
 
ALTER TABLE [Payroll].[CnssDeclarationDetails]  WITH CHECK ADD  CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration] FOREIGN KEY([IdCnssDeclaration])
REFERENCES [Payroll].[CnssDeclaration] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[CnssDeclarationDetails] CHECK CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration]
 
ALTER TABLE [Payroll].[CnssDeclarationDetails]  WITH CHECK ADD  CONSTRAINT [FK_CnssDelarationDetails_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[CnssDeclarationDetails] CHECK CONSTRAINT [FK_CnssDelarationDetails_Employee]
 
ALTER TABLE [Payroll].[CnssDeclarationSession]  WITH CHECK ADD  CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration] FOREIGN KEY([IdCnssDeclaration])
REFERENCES [Payroll].[CnssDeclaration] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[CnssDeclarationSession] CHECK CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration]
 
ALTER TABLE [Payroll].[CnssDeclarationSession]  WITH CHECK ADD  CONSTRAINT [FK_CnssDeclarationSession_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
 
ALTER TABLE [Payroll].[CnssDeclarationSession] CHECK CONSTRAINT [FK_CnssDeclarationSession_Session]
 
ALTER TABLE [Payroll].[ConstantRate]  WITH CHECK ADD  CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY([IdRuleUniqueReference])
REFERENCES [Payroll].[RuleUniqueReference] ([Id])
 
ALTER TABLE [Payroll].[ConstantRate] CHECK CONSTRAINT [FK_ConstantRate_RuleUniqueReference]
 
ALTER TABLE [Payroll].[ConstantRateValidityPeriod]  WITH CHECK ADD  CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY([IdConstantRate])
REFERENCES [Payroll].[ConstantRate] ([Id])
 
ALTER TABLE [Payroll].[ConstantRateValidityPeriod] CHECK CONSTRAINT [FK_ConstantRate_ValidityPeriod]
 
ALTER TABLE [Payroll].[ConstantValue]  WITH CHECK ADD  CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY([IdRuleUniqueReference])
REFERENCES [Payroll].[RuleUniqueReference] ([Id])
 
ALTER TABLE [Payroll].[ConstantValue] CHECK CONSTRAINT [FK_ConstantValue_RuleUniqueReference]
 
ALTER TABLE [Payroll].[ConstantValueValidityPeriod]  WITH CHECK ADD  CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY([IdConstantValue])
REFERENCES [Payroll].[ConstantValue] ([Id])
 
ALTER TABLE [Payroll].[ConstantValueValidityPeriod] CHECK CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue]
 
ALTER TABLE [Payroll].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Cnss] FOREIGN KEY([IdCnss])
REFERENCES [Payroll].[Cnss] ([Id])
 
ALTER TABLE [Payroll].[Contract] CHECK CONSTRAINT [FK_Contract_Cnss]
 
ALTER TABLE [Payroll].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY([IdContractType])
REFERENCES [Payroll].[ContractType] ([Id])
 
ALTER TABLE [Payroll].[Contract] CHECK CONSTRAINT [FK_Contract_ContractType]
 
ALTER TABLE [Payroll].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Contract] CHECK CONSTRAINT [FK_Contract_Employee]
 
ALTER TABLE [Payroll].[Contract]  WITH CHECK ADD  CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY([IdSalaryStructure])
REFERENCES [Payroll].[SalaryStructure] ([Id])
 
ALTER TABLE [Payroll].[Contract] CHECK CONSTRAINT [FK_Contract_SalaryStructure]
 
ALTER TABLE [Payroll].[ContractAdvantage]  WITH CHECK ADD  CONSTRAINT [FK_ContractAdvantage_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ContractAdvantage] CHECK CONSTRAINT [FK_ContractAdvantage_Contract]
 
ALTER TABLE [Payroll].[ContractBenefitInKind]  WITH CHECK ADD  CONSTRAINT [FK_ContractBenefitInKind_BenefitInKind] FOREIGN KEY([IdBenefitInKind])
REFERENCES [Payroll].[BenefitInKind] ([Id])
 
ALTER TABLE [Payroll].[ContractBenefitInKind] CHECK CONSTRAINT [FK_ContractBenefitInKind_BenefitInKind]
 
ALTER TABLE [Payroll].[ContractBenefitInKind]  WITH CHECK ADD  CONSTRAINT [FK_ContractBenefitInKind_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ContractBenefitInKind] CHECK CONSTRAINT [FK_ContractBenefitInKind_Contract]
 
ALTER TABLE [Payroll].[ContractBonus]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Bonus_Bonus] FOREIGN KEY([IdBonus])
REFERENCES [Payroll].[Bonus] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ContractBonus] CHECK CONSTRAINT [FK_Contract_Bonus_Bonus]
 
ALTER TABLE [Payroll].[ContractBonus]  WITH CHECK ADD  CONSTRAINT [FK_Contract_Bonus_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ContractBonus] CHECK CONSTRAINT [FK_Contract_Bonus_Contract]
 
ALTER TABLE [Payroll].[DocumentRequest]  WITH CHECK ADD  CONSTRAINT [FK_DocumentRequest_DocumentRequestType] FOREIGN KEY([IdDocumentRequestType])
REFERENCES [Payroll].[DocumentRequestType] ([Id])
 
ALTER TABLE [Payroll].[DocumentRequest] CHECK CONSTRAINT [FK_DocumentRequest_DocumentRequestType]
 
ALTER TABLE [Payroll].[DocumentRequest]  WITH CHECK ADD  CONSTRAINT [FK_DocumentRequest_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[DocumentRequest] CHECK CONSTRAINT [FK_DocumentRequest_Employee]
 
ALTER TABLE [Payroll].[DocumentRequest]  WITH CHECK ADD  CONSTRAINT [FK_DocumentRequest_Superior] FOREIGN KEY([TreatedBy])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[DocumentRequest] CHECK CONSTRAINT [FK_DocumentRequest_Superior]
 
ALTER TABLE [Payroll].[DocumentRequestEmail]  WITH CHECK ADD  CONSTRAINT [FK_DocumentRequest] FOREIGN KEY([IdDocumentRequest])
REFERENCES [Payroll].[DocumentRequest] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[DocumentRequestEmail] CHECK CONSTRAINT [FK_DocumentRequest]
 
ALTER TABLE [Payroll].[DocumentRequestEmail]  WITH CHECK ADD  CONSTRAINT [FK_DocumentRequestEmail] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [Payroll].[DocumentRequestEmail] CHECK CONSTRAINT [FK_DocumentRequestEmail]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Bank] FOREIGN KEY([IdBank])
REFERENCES [Shared].[Bank] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Bank]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY([IdCitizenship])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Citizenship]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_City]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Country]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Grade] FOREIGN KEY([IdGrade])
REFERENCES [Payroll].[Grade] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Grade]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Office] FOREIGN KEY([IdOffice])
REFERENCES [Shared].[Office] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Office]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_PaymentType] FOREIGN KEY([IdPaymentType])
REFERENCES [Payment].[PaymentType] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_PaymentType]
 
ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY([IdUpperHierarchy])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_UpperHierarchy]
 
ALTER TABLE [Payroll].[EmployeeDocument]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDocument_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[EmployeeDocument] CHECK CONSTRAINT [FK_EmployeeDocument_Employee]
 
ALTER TABLE [Payroll].[EmployeeSkills]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[EmployeeSkills] CHECK CONSTRAINT [FK_EmployeeSkills_Employee]
 
ALTER TABLE [Payroll].[EmployeeSkills]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[EmployeeSkills] CHECK CONSTRAINT [FK_EmployeeSkills_Skills]
 
ALTER TABLE [Payroll].[EmployeeTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTeam_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[EmployeeTeam] CHECK CONSTRAINT [FK_EmployeeTeam_Employee]
 
ALTER TABLE [Payroll].[EmployeeTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTeam_Team] FOREIGN KEY([IdTeam])
REFERENCES [Payroll].[Team] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[EmployeeTeam] CHECK CONSTRAINT [FK_EmployeeTeam_Team]
 
ALTER TABLE [Payroll].[ExitActionEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ActionExitEmployee_Actions] FOREIGN KEY([IdExitAction])
REFERENCES [Payroll].[ExitAction] ([Id])
 
ALTER TABLE [Payroll].[ExitActionEmployee] CHECK CONSTRAINT [FK_ActionExitEmployee_Actions]
 
ALTER TABLE [Payroll].[ExitActionEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY([IdExitEmployee])
REFERENCES [Payroll].[ExitEmployee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExitActionEmployee] CHECK CONSTRAINT [FK_ActionExitEmployee_EmployeeExit]
 
ALTER TABLE [Payroll].[ExitEmailForEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ExitEmailForEmployee_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[ExitEmailForEmployee] CHECK CONSTRAINT [FK_ExitEmailForEmployee_Employee]
 
ALTER TABLE [Payroll].[ExitEmailForEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit] FOREIGN KEY([IdExitEmployee])
REFERENCES [Payroll].[ExitEmployee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExitEmailForEmployee] CHECK CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit]
 
ALTER TABLE [Payroll].[ExitEmployee]  WITH NOCHECK ADD  CONSTRAINT [FK_EmployeeExit_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExitEmployee] CHECK CONSTRAINT [FK_EmployeeExit_Employee]
 
ALTER TABLE [Payroll].[ExitEmployee]  WITH NOCHECK ADD  CONSTRAINT [FK_EmployeeExit_ExitReason] FOREIGN KEY([IdExitReason])
REFERENCES [Payroll].[ExitReason] ([Id])
 
ALTER TABLE [Payroll].[ExitEmployee] CHECK CONSTRAINT [FK_EmployeeExit_ExitReason]
 
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine]  WITH CHECK ADD  CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit] FOREIGN KEY([IdExitEmployee])
REFERENCES [Payroll].[ExitEmployee] ([Id])
 
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] CHECK CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit]
 
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine]  WITH CHECK ADD  CONSTRAINT [FK_ExitEmployeeLeaveLine_LeaveType] FOREIGN KEY([IdLeaveType])
REFERENCES [Payroll].[LeaveType] ([Id])
 
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] CHECK CONSTRAINT [FK_ExitEmployeeLeaveLine_LeaveType]
 
ALTER TABLE [Payroll].[ExitEmployeePayLine]  WITH CHECK ADD  CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit] FOREIGN KEY([IdExitEmployee])
REFERENCES [Payroll].[ExitEmployee] ([Id])
 
ALTER TABLE [Payroll].[ExitEmployeePayLine] CHECK CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit]
 
ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule]  WITH NOCHECK ADD  CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY([IdExitEmployeePayLine])
REFERENCES [Payroll].[ExitEmployeePayLine] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule] CHECK CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine]
 
ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule]  WITH NOCHECK ADD  CONSTRAINT [FK_LinesSalaryRule_SalaryRule] FOREIGN KEY([IdSalaryRule])
REFERENCES [Payroll].[SalaryRule] ([Id])
 
ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule] CHECK CONSTRAINT [FK_LinesSalaryRule_SalaryRule]
 
ALTER TABLE [Payroll].[ExpenseReport]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReport_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[ExpenseReport] CHECK CONSTRAINT [FK_ExpenseReport_Employee]
 
ALTER TABLE [Payroll].[ExpenseReport]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReport_Superior] FOREIGN KEY([TreatedBy])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[ExpenseReport] CHECK CONSTRAINT [FK_ExpenseReport_Superior]
 
ALTER TABLE [Payroll].[ExpenseReportDetails]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReportDetails_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Payroll].[ExpenseReportDetails] CHECK CONSTRAINT [FK_ExpenseReportDetails_Currency]
 
ALTER TABLE [Payroll].[ExpenseReportDetails]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReportDetails_ExpenseReport] FOREIGN KEY([IdExpenseReport])
REFERENCES [Payroll].[ExpenseReport] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExpenseReportDetails] CHECK CONSTRAINT [FK_ExpenseReportDetails_ExpenseReport]
 
ALTER TABLE [Payroll].[ExpenseReportDetails]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReportDetails_ExpenseReportDetailsType] FOREIGN KEY([IdExpenseReportDetailsType])
REFERENCES [Payroll].[ExpenseReportDetailsType] ([Id])
 
ALTER TABLE [Payroll].[ExpenseReportDetails] CHECK CONSTRAINT [FK_ExpenseReportDetails_ExpenseReportDetailsType]
 
ALTER TABLE [Payroll].[ExpenseReportEmail]  WITH CHECK ADD  CONSTRAINT [FK_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [Payroll].[ExpenseReportEmail] CHECK CONSTRAINT [FK_Email]
 
ALTER TABLE [Payroll].[ExpenseReportEmail]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseReport] FOREIGN KEY([IdExpenseReport])
REFERENCES [Payroll].[ExpenseReport] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[ExpenseReportEmail] CHECK CONSTRAINT [FK_ExpenseReport]
 
ALTER TABLE [Payroll].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Job] FOREIGN KEY([IdUpperJob])
REFERENCES [Payroll].[Job] ([Id])
 
ALTER TABLE [Payroll].[Job] CHECK CONSTRAINT [FK_Job_Job]
 
ALTER TABLE [Payroll].[JobEmployee]  WITH NOCHECK ADD  CONSTRAINT [FK_JobEmployee_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[JobEmployee] CHECK CONSTRAINT [FK_JobEmployee_Employee]
 
ALTER TABLE [Payroll].[JobEmployee]  WITH CHECK ADD  CONSTRAINT [FK_JobEmployee_Job] FOREIGN KEY([IdJob])
REFERENCES [Payroll].[Job] ([Id])
 
ALTER TABLE [Payroll].[JobEmployee] CHECK CONSTRAINT [FK_JobEmployee_Job]
 
ALTER TABLE [Payroll].[JobSkills]  WITH CHECK ADD  CONSTRAINT [FK_JobSkills_Job] FOREIGN KEY([IdJob])
REFERENCES [Payroll].[Job] ([Id])
 
ALTER TABLE [Payroll].[JobSkills] CHECK CONSTRAINT [FK_JobSkills_Job]
 
ALTER TABLE [Payroll].[JobSkills]  WITH CHECK ADD  CONSTRAINT [FK_JobSkills_Skills] FOREIGN KEY([IdSkill])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [Payroll].[JobSkills] CHECK CONSTRAINT [FK_JobSkills_Skills]
 
ALTER TABLE [Payroll].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Leave] CHECK CONSTRAINT [FK_Leave_Employee]
 
ALTER TABLE [Payroll].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_LeaveType] FOREIGN KEY([IdLeaveType])
REFERENCES [Payroll].[LeaveType] ([Id])
 
ALTER TABLE [Payroll].[Leave] CHECK CONSTRAINT [FK_Leave_LeaveType]
 
ALTER TABLE [Payroll].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_Superior] FOREIGN KEY([TreatedBy])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Leave] CHECK CONSTRAINT [FK_Leave_Superior]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining]  WITH CHECK ADD  CONSTRAINT [FK_LeaveBalanceRemaining_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] CHECK CONSTRAINT [FK_LeaveBalanceRemaining_Employee]
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining]  WITH CHECK ADD  CONSTRAINT [FK_LeaveBalanceRemaining_LeaveType] FOREIGN KEY([IdLeaveType])
REFERENCES [Payroll].[LeaveType] ([Id])
 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] CHECK CONSTRAINT [FK_LeaveBalanceRemaining_LeaveType]
 
ALTER TABLE [Payroll].[LeaveEmail]  WITH CHECK ADD  CONSTRAINT [FK_Leave] FOREIGN KEY([IdLeave])
REFERENCES [Payroll].[Leave] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[LeaveEmail] CHECK CONSTRAINT [FK_Leave]
 
ALTER TABLE [Payroll].[LeaveEmail]  WITH CHECK ADD  CONSTRAINT [FK_Mail] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[LeaveEmail] CHECK CONSTRAINT [FK_Mail]
 
ALTER TABLE [Payroll].[Loan]  WITH NOCHECK ADD  CONSTRAINT [FK_Loan_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Loan] CHECK CONSTRAINT [FK_Loan_Employee]
 
ALTER TABLE [Payroll].[LoanInstallment]  WITH CHECK ADD  CONSTRAINT [FK_LoanInstallment_Loan] FOREIGN KEY([IdLoan])
REFERENCES [Payroll].[Loan] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[LoanInstallment] CHECK CONSTRAINT [FK_LoanInstallment_Loan]
 
ALTER TABLE [Payroll].[Note]  WITH CHECK ADD  CONSTRAINT [FK_Note_IdCreator] FOREIGN KEY([idCreator])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Payroll].[Note] CHECK CONSTRAINT [FK_Note_IdCreator]
 
ALTER TABLE [Payroll].[Note]  WITH CHECK ADD  CONSTRAINT [FK_Note_idEmployee] FOREIGN KEY([idEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Note] CHECK CONSTRAINT [FK_Note_idEmployee]
 
ALTER TABLE [Payroll].[ParentInCharge]  WITH CHECK ADD  CONSTRAINT [FK_ParentInCharge_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[ParentInCharge] CHECK CONSTRAINT [FK_ParentInCharge_Employee]
 
ALTER TABLE [Payroll].[ParentInCharge]  WITH CHECK ADD  CONSTRAINT [FK_ParentInCharge_ParentType] FOREIGN KEY([IdParentType])
REFERENCES [Payroll].[ParentType] ([Id])
 
ALTER TABLE [Payroll].[ParentInCharge] CHECK CONSTRAINT [FK_ParentInCharge_ParentType]
 
ALTER TABLE [Payroll].[Payslip]  WITH NOCHECK ADD  CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Payslip] CHECK CONSTRAINT [FK_Payslip_Contract]
 
ALTER TABLE [Payroll].[Payslip]  WITH CHECK ADD  CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Payslip] CHECK CONSTRAINT [FK_Payslip_Employee]
 
ALTER TABLE [Payroll].[Payslip]  WITH CHECK ADD  CONSTRAINT [FK_Payslip_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Payslip] CHECK CONSTRAINT [FK_Payslip_Session]
 
ALTER TABLE [Payroll].[Payslip]  WITH CHECK ADD  CONSTRAINT [FK_Payslip_TransferOrder] FOREIGN KEY([IdTransferOrder])
REFERENCES [Payroll].[TransferOrder] ([Id])
 
ALTER TABLE [Payroll].[Payslip] CHECK CONSTRAINT [FK_Payslip_TransferOrder]
 
ALTER TABLE [Payroll].[PayslipDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_PayslipDetails_BenefitInKind] FOREIGN KEY([IdBenefitInKind])
REFERENCES [Payroll].[BenefitInKind] ([Id])
 
ALTER TABLE [Payroll].[PayslipDetails] CHECK CONSTRAINT [FK_PayslipDetails_BenefitInKind]
 
ALTER TABLE [Payroll].[PayslipDetails]  WITH CHECK ADD  CONSTRAINT [FK_PayslipDetails_Bonus] FOREIGN KEY([IdBonus])
REFERENCES [Payroll].[Bonus] ([Id])
 
ALTER TABLE [Payroll].[PayslipDetails] CHECK CONSTRAINT [FK_PayslipDetails_Bonus]
 
ALTER TABLE [Payroll].[PayslipDetails]  WITH CHECK ADD  CONSTRAINT [FK_PayslipDetails_LoanInstallment] FOREIGN KEY([IdLoanInstallment])
REFERENCES [Payroll].[LoanInstallment] ([Id])
 
ALTER TABLE [Payroll].[PayslipDetails] CHECK CONSTRAINT [FK_PayslipDetails_LoanInstallment]
 
ALTER TABLE [Payroll].[PayslipDetails]  WITH CHECK ADD  CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY([IdPayslip])
REFERENCES [Payroll].[Payslip] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[PayslipDetails] CHECK CONSTRAINT [FK_PayslipDetails_Payslip]
 
ALTER TABLE [Payroll].[PayslipDetails]  WITH CHECK ADD  CONSTRAINT [FK_PayslipDetails_SalaryRule] FOREIGN KEY([IdSalaryRule])
REFERENCES [Payroll].[SalaryRule] ([Id])
 
ALTER TABLE [Payroll].[PayslipDetails] CHECK CONSTRAINT [FK_PayslipDetails_SalaryRule]
 
ALTER TABLE [Payroll].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Candidate] FOREIGN KEY([IdCandidate])
REFERENCES [RH].[Candidate] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Qualification] CHECK CONSTRAINT [FK_Qualification_Candidate]
 
ALTER TABLE [Payroll].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Country] FOREIGN KEY([IdQualificationCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Payroll].[Qualification] CHECK CONSTRAINT [FK_Qualification_Country]
 
ALTER TABLE [Payroll].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Qualification] CHECK CONSTRAINT [FK_Qualification_Employee]
 
ALTER TABLE [Payroll].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_QualificationType] FOREIGN KEY([IdQualificationType])
REFERENCES [Payroll].[QualificationType] ([Id])
 
ALTER TABLE [Payroll].[Qualification] CHECK CONSTRAINT [FK_Qualification_QualificationType]
 
ALTER TABLE [Payroll].[SalaryRule]  WITH CHECK ADD  CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY([IdContributionRegister])
REFERENCES [Payroll].[ContributionRegister] ([Id])
 
ALTER TABLE [Payroll].[SalaryRule] CHECK CONSTRAINT [FK_SalaryRule_ContributionRegister]
 
ALTER TABLE [Payroll].[SalaryRule]  WITH NOCHECK ADD  CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY([IdRuleUniqueReference])
REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SalaryRule] CHECK CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
 
ALTER TABLE [Payroll].[SalaryRuleValidityPeriod]  WITH NOCHECK ADD  CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule] FOREIGN KEY([IdSalaryRule])
REFERENCES [Payroll].[SalaryRule] ([Id])
 
ALTER TABLE [Payroll].[SalaryRuleValidityPeriod] CHECK CONSTRAINT [FK_SalaryRuleValidityPeriod_SalaryRule]
 
ALTER TABLE [Payroll].[SalaryStructure]  WITH CHECK ADD  CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY([IdParent])
REFERENCES [Payroll].[SalaryStructure] ([Id])
 
ALTER TABLE [Payroll].[SalaryStructure] CHECK CONSTRAINT [FK_SalaryStructure_SalaryStructureParent]
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod]  WITH NOCHECK ADD  CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure] FOREIGN KEY([IdSalaryStructure])
REFERENCES [Payroll].[SalaryStructure] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod] CHECK CONSTRAINT [FK_SalaryStructureValidityPeriod_SalaryStructure]
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule]  WITH CHECK ADD  CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryRule] FOREIGN KEY([IdSalaryRule])
REFERENCES [Payroll].[SalaryRule] ([Id])
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] CHECK CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryRule]
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule]  WITH NOCHECK ADD  CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod] FOREIGN KEY([IdSalaryStructureValidityPeriod])
REFERENCES [Payroll].[SalaryStructureValidityPeriod] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SalaryStructureValidityPeriodSalaryRule] CHECK CONSTRAINT [FK_SalaryStructureValidityPeriodSalaryRule_SalaryStructureValidityPeriod]
 
ALTER TABLE [Payroll].[SessionBonus]  WITH NOCHECK ADD  CONSTRAINT [FK_PaySlip_Premium_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionBonus] CHECK CONSTRAINT [FK_PaySlip_Premium_Contract]
 
ALTER TABLE [Payroll].[SessionBonus]  WITH CHECK ADD  CONSTRAINT [FK_PaySlip_Premium_Premium] FOREIGN KEY([IdBonus])
REFERENCES [Payroll].[Bonus] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionBonus] CHECK CONSTRAINT [FK_PaySlip_Premium_Premium]
 
ALTER TABLE [Payroll].[SessionBonus]  WITH CHECK ADD  CONSTRAINT [FK_PaySlip_Premium_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionBonus] CHECK CONSTRAINT [FK_PaySlip_Premium_Session]
 
ALTER TABLE [Payroll].[SessionContract]  WITH NOCHECK ADD  CONSTRAINT [FK_SessionContract_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionContract] CHECK CONSTRAINT [FK_SessionContract_Contract]
 
ALTER TABLE [Payroll].[SessionContract]  WITH CHECK ADD  CONSTRAINT [FK_SessionContract_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionContract] CHECK CONSTRAINT [FK_SessionContract_Session]
 
ALTER TABLE [Payroll].[SessionLoanInstallment]  WITH NOCHECK ADD  CONSTRAINT [FK_SessionLoan_Contract] FOREIGN KEY([IdContract])
REFERENCES [Payroll].[Contract] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionLoanInstallment] CHECK CONSTRAINT [FK_SessionLoan_Contract]
 
ALTER TABLE [Payroll].[SessionLoanInstallment]  WITH CHECK ADD  CONSTRAINT [FK_SessionLoan_LoanInstallment] FOREIGN KEY([IdLoanInstallment])
REFERENCES [Payroll].[LoanInstallment] ([Id])
 
ALTER TABLE [Payroll].[SessionLoanInstallment] CHECK CONSTRAINT [FK_SessionLoan_LoanInstallment]
 
ALTER TABLE [Payroll].[SessionLoanInstallment]  WITH CHECK ADD  CONSTRAINT [FK_SessionLoan_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SessionLoanInstallment] CHECK CONSTRAINT [FK_SessionLoan_Session]
 
ALTER TABLE [Payroll].[SharedDocument]  WITH CHECK ADD  CONSTRAINT [FK_SharedDocument_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[SharedDocument] CHECK CONSTRAINT [FK_SharedDocument_Employee]
 
ALTER TABLE [Payroll].[SharedDocument]  WITH CHECK ADD  CONSTRAINT [FK_SharedDocument_Type] FOREIGN KEY([IdType])
REFERENCES [Payroll].[DocumentRequestType] ([Id])
 
ALTER TABLE [Payroll].[SharedDocument] CHECK CONSTRAINT [FK_SharedDocument_Type]
 
ALTER TABLE [Payroll].[SharedDocument]  WITH CHECK ADD  CONSTRAINT [FK_SharedDocument_User] FOREIGN KEY([TransactionUserId])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Payroll].[SharedDocument] CHECK CONSTRAINT [FK_SharedDocument_User]
 
ALTER TABLE [Payroll].[Skills]  WITH CHECK ADD  CONSTRAINT [FK_Family_Skills] FOREIGN KEY([Id_Family])
REFERENCES [Payroll].[SkillsFamily] ([Id])
 
ALTER TABLE [Payroll].[Skills] CHECK CONSTRAINT [FK_Family_Skills]
 
ALTER TABLE [Payroll].[SourceDeduction]  WITH CHECK ADD  CONSTRAINT [FK_SourceDeduction_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[SourceDeduction] CHECK CONSTRAINT [FK_SourceDeduction_Employee]
 
ALTER TABLE [Payroll].[SourceDeduction]  WITH CHECK ADD  CONSTRAINT [FK_SourceDeduction_SourceDeductionSession] FOREIGN KEY([IdSourceDeductionSession])
REFERENCES [Payroll].[SourceDeductionSession] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SourceDeduction] CHECK CONSTRAINT [FK_SourceDeduction_SourceDeductionSession]
 
ALTER TABLE [Payroll].[SourceDeductionSessionEmployee]  WITH CHECK ADD  CONSTRAINT [FK_SourceDeductionSessionEmployee_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[SourceDeductionSessionEmployee] CHECK CONSTRAINT [FK_SourceDeductionSessionEmployee_Employee]
 
ALTER TABLE [Payroll].[SourceDeductionSessionEmployee]  WITH CHECK ADD  CONSTRAINT [FK_SourceDeductionSessionEmployee_SourceDeductionSession] FOREIGN KEY([IdSourceDeductionSession])
REFERENCES [Payroll].[SourceDeductionSession] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[SourceDeductionSessionEmployee] CHECK CONSTRAINT [FK_SourceDeductionSessionEmployee_SourceDeductionSession]
 
ALTER TABLE [Payroll].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Department] FOREIGN KEY([IdDepartment])
REFERENCES [Payroll].[Department] ([Id])
 
ALTER TABLE [Payroll].[Team] CHECK CONSTRAINT [FK_Team_Department]
 
ALTER TABLE [Payroll].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Employee] FOREIGN KEY([IdManager])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[Team] CHECK CONSTRAINT [FK_Team_Employee]
 
ALTER TABLE [Payroll].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_TeamType] FOREIGN KEY([IdTeamType])
REFERENCES [Payroll].[TeamType] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Team] CHECK CONSTRAINT [FK_Team_TeamType]
 
ALTER TABLE [Payroll].[TransferOrder]  WITH CHECK ADD  CONSTRAINT [FK_TransferOrder_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [Payroll].[TransferOrder] CHECK CONSTRAINT [FK_TransferOrder_BankAccount]
 
ALTER TABLE [Payroll].[TransferOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_TransferOrderDetails_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Payroll].[TransferOrderDetails] CHECK CONSTRAINT [FK_TransferOrderDetails_Employee]
 
ALTER TABLE [Payroll].[TransferOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_TransferOrderDetails_TransferOrder] FOREIGN KEY([IdTransferOrder])
REFERENCES [Payroll].[TransferOrder] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[TransferOrderDetails] CHECK CONSTRAINT [FK_TransferOrderDetails_TransferOrder]
 
ALTER TABLE [Payroll].[TransferOrderSession]  WITH CHECK ADD  CONSTRAINT [FK_TransferOrderSession_Session] FOREIGN KEY([IdSession])
REFERENCES [Payroll].[Session] ([Id])
 
ALTER TABLE [Payroll].[TransferOrderSession] CHECK CONSTRAINT [FK_TransferOrderSession_Session]
 
ALTER TABLE [Payroll].[TransferOrderSession]  WITH CHECK ADD  CONSTRAINT [FK_TransferOrderSession_TransferOrder] FOREIGN KEY([IdTransferOrder])
REFERENCES [Payroll].[TransferOrder] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[TransferOrderSession] CHECK CONSTRAINT [FK_TransferOrderSession_TransferOrder]
 
ALTER TABLE [Payroll].[Variable]  WITH NOCHECK ADD  CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY([IdRuleUniqueReference])
REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[Variable] CHECK CONSTRAINT [FK_Variable_RuleUnique]
 
ALTER TABLE [Payroll].[VariableValidityPeriod]  WITH NOCHECK ADD  CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY([IdVariable])
REFERENCES [Payroll].[Variable] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Payroll].[VariableValidityPeriod] CHECK CONSTRAINT [FK_VariableValidityPeriod_Variable]
 
ALTER TABLE [RH].[Advantages]  WITH CHECK ADD  CONSTRAINT [FK_Advantages_Advantages] FOREIGN KEY([IdOffer])
REFERENCES [RH].[Offer] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[Advantages] CHECK CONSTRAINT [FK_Advantages_Advantages]
 
ALTER TABLE [RH].[Candidacy]  WITH CHECK ADD  CONSTRAINT [FK_Candidacy_Candidate] FOREIGN KEY([IdCandidate])
REFERENCES [RH].[Candidate] ([Id])
 
ALTER TABLE [RH].[Candidacy] CHECK CONSTRAINT [FK_Candidacy_Candidate]
 
ALTER TABLE [RH].[Candidacy]  WITH CHECK ADD  CONSTRAINT [FK_Candidacy_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [RH].[Candidacy] CHECK CONSTRAINT [FK_Candidacy_Email]
 
ALTER TABLE [RH].[Candidacy]  WITH CHECK ADD  CONSTRAINT [FK_Candidacy_Recruitment] FOREIGN KEY([IdRecruitment])
REFERENCES [RH].[Recruitment] ([Id])
 
ALTER TABLE [RH].[Candidacy] CHECK CONSTRAINT [FK_Candidacy_Recruitment]
 
ALTER TABLE [RH].[Candidate]  WITH CHECK ADD  CONSTRAINT [FK_Candidate_Country] FOREIGN KEY([IdCitizenship])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [RH].[Candidate] CHECK CONSTRAINT [FK_Candidate_Country]
 
ALTER TABLE [RH].[Candidate]  WITH CHECK ADD  CONSTRAINT [FK_Candidate_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Candidate] CHECK CONSTRAINT [FK_Candidate_Employee]
 
ALTER TABLE [RH].[Candidate]  WITH CHECK ADD  CONSTRAINT [FK_Candidate_User] FOREIGN KEY([IdCreationUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[Candidate] CHECK CONSTRAINT [FK_Candidate_User]
 
ALTER TABLE [RH].[CriteriaMark]  WITH CHECK ADD  CONSTRAINT [FK_CriteriaMark_EvaluationCriteria] FOREIGN KEY([IdEvaluationCriteria])
REFERENCES [RH].[EvaluationCriteria] ([Id])
 
ALTER TABLE [RH].[CriteriaMark] CHECK CONSTRAINT [FK_CriteriaMark_EvaluationCriteria]
 
ALTER TABLE [RH].[CriteriaMark]  WITH CHECK ADD  CONSTRAINT [FK_CriteriaMark_InterviewMark] FOREIGN KEY([IdInterviewMark])
REFERENCES [RH].[InterviewMark] ([Id])
 
ALTER TABLE [RH].[CriteriaMark] CHECK CONSTRAINT [FK_CriteriaMark_InterviewMark]
 
ALTER TABLE [RH].[CurriculumVitae]  WITH CHECK ADD  CONSTRAINT [FK_CV_Candidate] FOREIGN KEY([IdCandidate])
REFERENCES [RH].[Candidate] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[CurriculumVitae] CHECK CONSTRAINT [FK_CV_Candidate]
 
ALTER TABLE [RH].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_Employee]
 
ALTER TABLE [RH].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY([IdProject])
REFERENCES [RH].[Project] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_Project]
 
ALTER TABLE [RH].[EmployeeTrainingSession]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTrainingSession_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[EmployeeTrainingSession] CHECK CONSTRAINT [FK_EmployeeTrainingSession_Employee]
 
ALTER TABLE [RH].[EmployeeTrainingSession]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTrainingSession_TrainingSession] FOREIGN KEY([IdTrainingSession])
REFERENCES [RH].[TrainingSession] ([Id])
 
ALTER TABLE [RH].[EmployeeTrainingSession] CHECK CONSTRAINT [FK_EmployeeTrainingSession_TrainingSession]
 
ALTER TABLE [RH].[EvaluationCriteria]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY([IdEvaluationCriteriaTheme])
REFERENCES [RH].[EvaluationCriteriaTheme] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[EvaluationCriteria] CHECK CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme]
 
ALTER TABLE [RH].[ExternalTrainerSkills]  WITH CHECK ADD  CONSTRAINT [FK_ExternalTrainerSkills_ExternalTrainer] FOREIGN KEY([IdExternalTrainer])
REFERENCES [RH].[ExternalTrainer] ([Id])
 
ALTER TABLE [RH].[ExternalTrainerSkills] CHECK CONSTRAINT [FK_ExternalTrainerSkills_ExternalTrainer]
 
ALTER TABLE [RH].[ExternalTrainerSkills]  WITH CHECK ADD  CONSTRAINT [FK_ExternalTrainerSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [RH].[ExternalTrainerSkills] CHECK CONSTRAINT [FK_ExternalTrainerSkills_Skills]
 
ALTER TABLE [RH].[ExternalTraining]  WITH CHECK ADD  CONSTRAINT [FK_ExternalTraining_ExternalTrainer] FOREIGN KEY([IdExternalTrainer])
REFERENCES [RH].[ExternalTrainer] ([Id])
 
ALTER TABLE [RH].[ExternalTraining] CHECK CONSTRAINT [FK_ExternalTraining_ExternalTrainer]
 
ALTER TABLE [RH].[ExternalTraining]  WITH CHECK ADD  CONSTRAINT [FK_ExternalTraining_TrainingCenterRoom] FOREIGN KEY([IdTrainingCenterRoom])
REFERENCES [RH].[TrainingCenterRoom] ([Id])
 
ALTER TABLE [RH].[ExternalTraining] CHECK CONSTRAINT [FK_ExternalTraining_TrainingCenterRoom]
 
ALTER TABLE [RH].[ExternalTraining]  WITH CHECK ADD  CONSTRAINT [FK_ExternalTraining_TrainingSession] FOREIGN KEY([IdTrainingSession])
REFERENCES [RH].[TrainingSession] ([Id])
 
ALTER TABLE [RH].[ExternalTraining] CHECK CONSTRAINT [FK_ExternalTraining_TrainingSession]
 
ALTER TABLE [RH].[FileDrive]  WITH CHECK ADD  CONSTRAINT [FK_FileDrive_FileDrive] FOREIGN KEY([IdParent])
REFERENCES [RH].[FileDrive] ([Id])
 
ALTER TABLE [RH].[FileDrive] CHECK CONSTRAINT [FK_FileDrive_FileDrive]
 
ALTER TABLE [RH].[FileDrive]  WITH CHECK ADD  CONSTRAINT [FK_FileDrive_User] FOREIGN KEY([CreatedBy])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[FileDrive] CHECK CONSTRAINT [FK_FileDrive_User]
 
ALTER TABLE [RH].[FileDriveSharedDocument]  WITH CHECK ADD  CONSTRAINT [FK_FileDriveSharedDocument_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[FileDriveSharedDocument] CHECK CONSTRAINT [FK_FileDriveSharedDocument_Employee]
 
ALTER TABLE [RH].[FileDriveSharedDocument]  WITH CHECK ADD  CONSTRAINT [FK_FileDriveSharedDocument_User] FOREIGN KEY([TransactionUserId])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[FileDriveSharedDocument] CHECK CONSTRAINT [FK_FileDriveSharedDocument_User]
 
ALTER TABLE [RH].[Formation]  WITH CHECK ADD  CONSTRAINT [FK_Formation_FormationType] FOREIGN KEY([IdFormationType])
REFERENCES [RH].[FormationType] ([Id])
 
ALTER TABLE [RH].[Formation] CHECK CONSTRAINT [FK_Formation_FormationType]
 
ALTER TABLE [RH].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Candidacy] FOREIGN KEY([IdCandidacy])
REFERENCES [RH].[Candidacy] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_Candidacy]
 
ALTER TABLE [RH].[Interview]  WITH NOCHECK ADD  CONSTRAINT [FK_Interview_Creator] FOREIGN KEY([IdCreator])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_Creator]
 
ALTER TABLE [RH].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_Email]
 
ALTER TABLE [RH].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Employee] FOREIGN KEY([IdSupervisor])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_Employee]
 
ALTER TABLE [RH].[Interview]  WITH NOCHECK ADD  CONSTRAINT [FK_Interview_ExitEmployee] FOREIGN KEY([IdExitEmployee])
REFERENCES [Payroll].[ExitEmployee] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_ExitEmployee]
 
ALTER TABLE [RH].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_InterviewType] FOREIGN KEY([IdInterviewType])
REFERENCES [RH].[InterviewType] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_InterviewType]
 
ALTER TABLE [RH].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Review] FOREIGN KEY([IdReview])
REFERENCES [RH].[Review] ([Id])
 
ALTER TABLE [RH].[Interview] CHECK CONSTRAINT [FK_Interview_Review]
 
ALTER TABLE [RH].[InterviewEmail]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEmail_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [RH].[InterviewEmail] CHECK CONSTRAINT [FK_InterviewEmail_Email]
 
ALTER TABLE [RH].[InterviewEmail]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEmail_Interview] FOREIGN KEY([IdInterview])
REFERENCES [RH].[Interview] ([Id])
 
ALTER TABLE [RH].[InterviewEmail] CHECK CONSTRAINT [FK_InterviewEmail_Interview]
 
ALTER TABLE [RH].[InterviewMark]  WITH CHECK ADD  CONSTRAINT [FK_InterviewMark_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[InterviewMark] CHECK CONSTRAINT [FK_InterviewMark_Employee]
 
ALTER TABLE [RH].[InterviewMark]  WITH CHECK ADD  CONSTRAINT [FK_InterviewMark_Interview] FOREIGN KEY([IdInterview])
REFERENCES [RH].[Interview] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[InterviewMark] CHECK CONSTRAINT [FK_InterviewMark_Interview]
 
ALTER TABLE [RH].[InterviewQuestion]  WITH CHECK ADD  CONSTRAINT [FK_InterviewQuestion_InterviewQuestionTheme] FOREIGN KEY([IdTheme])
REFERENCES [RH].[InterviewQuestionTheme] ([Id])
 
ALTER TABLE [RH].[InterviewQuestion] CHECK CONSTRAINT [FK_InterviewQuestion_InterviewQuestionTheme]
 
ALTER TABLE [RH].[MobilityRequest]  WITH CHECK ADD  CONSTRAINT [FK_MobilityOffice_CurrentOffice] FOREIGN KEY([IdCurrentOffice])
REFERENCES [Shared].[Office] ([Id])
 
ALTER TABLE [RH].[MobilityRequest] CHECK CONSTRAINT [FK_MobilityOffice_CurrentOffice]
 
ALTER TABLE [RH].[MobilityRequest]  WITH CHECK ADD  CONSTRAINT [FK_MobilityOffice_DestinationOffice] FOREIGN KEY([IdDestinationOffice])
REFERENCES [Shared].[Office] ([Id])
 
ALTER TABLE [RH].[MobilityRequest] CHECK CONSTRAINT [FK_MobilityOffice_DestinationOffice]
 
ALTER TABLE [RH].[MobilityRequest]  WITH CHECK ADD  CONSTRAINT [FK_MobilityOffice_User] FOREIGN KEY([IdCreationUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[MobilityRequest] CHECK CONSTRAINT [FK_MobilityOffice_User]
 
ALTER TABLE [RH].[MobilityRequest]  WITH CHECK ADD  CONSTRAINT [FK_MobilityRequest_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[MobilityRequest] CHECK CONSTRAINT [FK_MobilityRequest_Employee]
 
ALTER TABLE [RH].[Objective]  WITH CHECK ADD  CONSTRAINT [FK_Objective_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Objective] CHECK CONSTRAINT [FK_Objective_Employee]
 
ALTER TABLE [RH].[Objective]  WITH CHECK ADD  CONSTRAINT [FK_Objective_Review] FOREIGN KEY([IdReview])
REFERENCES [RH].[Review] ([Id])
 
ALTER TABLE [RH].[Objective] CHECK CONSTRAINT [FK_Objective_Review]
 
ALTER TABLE [RH].[Offer]  WITH CHECK ADD  CONSTRAINT [FK_Offer_Candidacy] FOREIGN KEY([IdCandidacy])
REFERENCES [RH].[Candidacy] ([Id])
 
ALTER TABLE [RH].[Offer] CHECK CONSTRAINT [FK_Offer_Candidacy]
 
ALTER TABLE [RH].[Offer]  WITH CHECK ADD  CONSTRAINT [FK_Offer_Cnss] FOREIGN KEY([IdCnss])
REFERENCES [Payroll].[Cnss] ([Id])
 
ALTER TABLE [RH].[Offer] CHECK CONSTRAINT [FK_Offer_Cnss]
 
ALTER TABLE [RH].[Offer]  WITH CHECK ADD  CONSTRAINT [FK_Offer_ContractType] FOREIGN KEY([IdContractType])
REFERENCES [Payroll].[ContractType] ([Id])
 
ALTER TABLE [RH].[Offer] CHECK CONSTRAINT [FK_Offer_ContractType]
 
ALTER TABLE [RH].[Offer]  WITH CHECK ADD  CONSTRAINT [FK_Offer_Email] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
 
ALTER TABLE [RH].[Offer] CHECK CONSTRAINT [FK_Offer_Email]
 
ALTER TABLE [RH].[Offer]  WITH CHECK ADD  CONSTRAINT [FK_Offer_SalaryStructure] FOREIGN KEY([IdSalaryStructure])
REFERENCES [Payroll].[SalaryStructure] ([Id])
 
ALTER TABLE [RH].[Offer] CHECK CONSTRAINT [FK_Offer_SalaryStructure]
 
ALTER TABLE [RH].[OfferBenefitInKind]  WITH CHECK ADD  CONSTRAINT [FK_OfferBenefitInKind_BenefitInKind] FOREIGN KEY([IdBenefitInKind])
REFERENCES [Payroll].[BenefitInKind] ([Id])
 
ALTER TABLE [RH].[OfferBenefitInKind] CHECK CONSTRAINT [FK_OfferBenefitInKind_BenefitInKind]
 
ALTER TABLE [RH].[OfferBenefitInKind]  WITH CHECK ADD  CONSTRAINT [FK_OfferBenefitInKind_Offer] FOREIGN KEY([IdOffer])
REFERENCES [RH].[Offer] ([Id])
 
ALTER TABLE [RH].[OfferBenefitInKind] CHECK CONSTRAINT [FK_OfferBenefitInKind_Offer]
 
ALTER TABLE [RH].[OfferBonus]  WITH CHECK ADD  CONSTRAINT [FK_OfferBonus_Bonus] FOREIGN KEY([IdBonus])
REFERENCES [Payroll].[Bonus] ([Id])
 
ALTER TABLE [RH].[OfferBonus] CHECK CONSTRAINT [FK_OfferBonus_Bonus]
 
ALTER TABLE [RH].[OfferBonus]  WITH CHECK ADD  CONSTRAINT [FK_OfferBonus_Offer] FOREIGN KEY([IdOffer])
REFERENCES [RH].[Offer] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[OfferBonus] CHECK CONSTRAINT [FK_OfferBonus_Offer]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_BankAccount]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_Contact]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_Currency]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_SettlementMode] FOREIGN KEY([IdSettlementMode])
REFERENCES [Sales].[SettlementMode] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_SettlementMode]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_Taxe]
 
ALTER TABLE [RH].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [RH].[Project] CHECK CONSTRAINT [FK_Project_Tiers]
 
ALTER TABLE [RH].[Question]  WITH NOCHECK ADD  CONSTRAINT [FK_Question_Interview] FOREIGN KEY([IdInterview])
REFERENCES [RH].[Interview] ([Id])
 
ALTER TABLE [RH].[Question] CHECK CONSTRAINT [FK_Question_Interview]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_ContractType] FOREIGN KEY([IdContractType])
REFERENCES [Payroll].[ContractType] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_ContractType]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_EmployeeAuthor] FOREIGN KEY([IdEmployeeAuthor])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_EmployeeAuthor]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_EmployeeValidator] FOREIGN KEY([IdEmployeeValidator])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_EmployeeValidator]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_Job] FOREIGN KEY([IdJob])
REFERENCES [Payroll].[Job] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_Job]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_Office] FOREIGN KEY([IdOffice])
REFERENCES [Shared].[Office] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_Office]
 
ALTER TABLE [RH].[Recruitment]  WITH CHECK ADD  CONSTRAINT [FK_Recruitment_QualificationType] FOREIGN KEY([IdQualificationType])
REFERENCES [Payroll].[QualificationType] ([Id])
 
ALTER TABLE [RH].[Recruitment] CHECK CONSTRAINT [FK_Recruitment_QualificationType]
 
ALTER TABLE [RH].[RecruitmentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_RecruitmentLanguage_Language] FOREIGN KEY([IdLanguage])
REFERENCES [Shared].[Language] ([Id])
 
ALTER TABLE [RH].[RecruitmentLanguage] CHECK CONSTRAINT [FK_RecruitmentLanguage_Language]
 
ALTER TABLE [RH].[RecruitmentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_RecruitmentLanguage_Recruitment] FOREIGN KEY([IdRecruitment])
REFERENCES [RH].[Recruitment] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [RH].[RecruitmentLanguage] CHECK CONSTRAINT [FK_RecruitmentLanguage_Recruitment]
 
ALTER TABLE [RH].[RecruitmentSkills]  WITH CHECK ADD  CONSTRAINT [FK_RecruitmentSkills_Recruitment] FOREIGN KEY([IdRecruitment])
REFERENCES [RH].[Recruitment] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [RH].[RecruitmentSkills] CHECK CONSTRAINT [FK_RecruitmentSkills_Recruitment]
 
ALTER TABLE [RH].[RecruitmentSkills]  WITH CHECK ADD  CONSTRAINT [FK_RecruitmentSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [RH].[RecruitmentSkills] CHECK CONSTRAINT [FK_RecruitmentSkills_Skills]
 
ALTER TABLE [RH].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Employee_Collaborator] FOREIGN KEY([IdEmployeeCollaborator])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Review] CHECK CONSTRAINT [FK_Review_Employee_Collaborator]
 
ALTER TABLE [RH].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Manager] FOREIGN KEY([IdManager])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[Review] CHECK CONSTRAINT [FK_Review_Manager]
 
ALTER TABLE [RH].[ReviewFormation]  WITH CHECK ADD  CONSTRAINT [FK_ReviewFormation_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[ReviewFormation] CHECK CONSTRAINT [FK_ReviewFormation_Employee]
 
ALTER TABLE [RH].[ReviewFormation]  WITH CHECK ADD  CONSTRAINT [FK_ReviewFormation_Formation] FOREIGN KEY([IdFormation])
REFERENCES [RH].[Formation] ([Id])
 
ALTER TABLE [RH].[ReviewFormation] CHECK CONSTRAINT [FK_ReviewFormation_Formation]
 
ALTER TABLE [RH].[ReviewFormation]  WITH CHECK ADD  CONSTRAINT [FK_ReviewFormation_Review] FOREIGN KEY([IdReview])
REFERENCES [RH].[Review] ([Id])
 
ALTER TABLE [RH].[ReviewFormation] CHECK CONSTRAINT [FK_ReviewFormation_Review]
 
ALTER TABLE [RH].[ReviewResume]  WITH CHECK ADD  CONSTRAINT [FK_ReviewResume_Review] FOREIGN KEY([IdReview])
REFERENCES [RH].[Review] ([Id])
 
ALTER TABLE [RH].[ReviewResume] CHECK CONSTRAINT [FK_ReviewResume_Review]
 
ALTER TABLE [RH].[ReviewSkills]  WITH CHECK ADD  CONSTRAINT [FK_ReviewSkills_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[ReviewSkills] CHECK CONSTRAINT [FK_ReviewSkills_Employee]
 
ALTER TABLE [RH].[ReviewSkills]  WITH CHECK ADD  CONSTRAINT [FK_ReviewSkills_Review] FOREIGN KEY([IdReview])
REFERENCES [RH].[Review] ([Id])
 
ALTER TABLE [RH].[ReviewSkills] CHECK CONSTRAINT [FK_ReviewSkills_Review]
 
ALTER TABLE [RH].[ReviewSkills]  WITH CHECK ADD  CONSTRAINT [FK_ReviewSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [RH].[ReviewSkills] CHECK CONSTRAINT [FK_ReviewSkills_Skills]
 
ALTER TABLE [RH].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_Employee]
 
ALTER TABLE [RH].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_Employee1] FOREIGN KEY([IdEmployeeTreated])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_Employee1]
 
ALTER TABLE [RH].[TimeSheetLine]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetLine_DayOff] FOREIGN KEY([IdDayOff])
REFERENCES [Shared].[DayOff] ([Id])
 
ALTER TABLE [RH].[TimeSheetLine] CHECK CONSTRAINT [FK_TimeSheetLine_DayOff]
 
ALTER TABLE [RH].[TimeSheetLine]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetLine_Leave] FOREIGN KEY([IdLeave])
REFERENCES [Payroll].[Leave] ([Id])
 
ALTER TABLE [RH].[TimeSheetLine] CHECK CONSTRAINT [FK_TimeSheetLine_Leave]
 
ALTER TABLE [RH].[TimeSheetLine]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetLine_Project] FOREIGN KEY([IdProject])
REFERENCES [RH].[Project] ([Id])
 
ALTER TABLE [RH].[TimeSheetLine] CHECK CONSTRAINT [FK_TimeSheetLine_Project]
 
ALTER TABLE [RH].[TimeSheetLine]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetLine_TimeSheet] FOREIGN KEY([IdTimeSheet])
REFERENCES [RH].[TimeSheet] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [RH].[TimeSheetLine] CHECK CONSTRAINT [FK_TimeSheetLine_TimeSheet]
 
ALTER TABLE [RH].[Training]  WITH CHECK ADD  CONSTRAINT [FK_Training_Supplier] FOREIGN KEY([IdSupplier])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [RH].[Training] CHECK CONSTRAINT [FK_Training_Supplier]
 
ALTER TABLE [RH].[TrainingByEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainngByEmployee_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TrainingByEmployee] CHECK CONSTRAINT [FK_TrainngByEmployee_Employee]
 
ALTER TABLE [RH].[TrainingByEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainngByEmployee_Training] FOREIGN KEY([IdTraining])
REFERENCES [RH].[Training] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[TrainingByEmployee] CHECK CONSTRAINT [FK_TrainngByEmployee_Training]
 
ALTER TABLE [RH].[TrainingCenter]  WITH CHECK ADD  CONSTRAINT [FK_TrainingCenter_TrainingCenterManager] FOREIGN KEY([IdTrainingCenterManager])
REFERENCES [RH].[TrainingCenterManager] ([Id])
 
ALTER TABLE [RH].[TrainingCenter] CHECK CONSTRAINT [FK_TrainingCenter_TrainingCenterManager]
 
ALTER TABLE [RH].[TrainingCenterRoom]  WITH CHECK ADD  CONSTRAINT [FK_TrainingCenterRoom_TrainingCenter] FOREIGN KEY([IdTrainingCenter])
REFERENCES [RH].[TrainingCenter] ([Id])
 
ALTER TABLE [RH].[TrainingCenterRoom] CHECK CONSTRAINT [FK_TrainingCenterRoom_TrainingCenter]
 
ALTER TABLE [RH].[TrainingExpectedSkills]  WITH CHECK ADD  CONSTRAINT [FK_TrainingExcpectedSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [RH].[TrainingExpectedSkills] CHECK CONSTRAINT [FK_TrainingExcpectedSkills_Skills]
 
ALTER TABLE [RH].[TrainingExpectedSkills]  WITH CHECK ADD  CONSTRAINT [FK_TrainingExpectedSkills_Training] FOREIGN KEY([IdTraining])
REFERENCES [RH].[Training] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[TrainingExpectedSkills] CHECK CONSTRAINT [FK_TrainingExpectedSkills_Training]
 
ALTER TABLE [RH].[TrainingRequest]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequest_Author] FOREIGN KEY([IdEmployeeAuthor])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TrainingRequest] CHECK CONSTRAINT [FK_TrainingRequest_Author]
 
ALTER TABLE [RH].[TrainingRequest]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequest_Collaborator] FOREIGN KEY([IdEmployeeCollaborator])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TrainingRequest] CHECK CONSTRAINT [FK_TrainingRequest_Collaborator]
 
ALTER TABLE [RH].[TrainingRequest]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequest_Training] FOREIGN KEY([IdTraining])
REFERENCES [RH].[Training] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[TrainingRequest] CHECK CONSTRAINT [FK_TrainingRequest_Training]
 
ALTER TABLE [RH].[TrainingRequest]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequest_TrainingSession] FOREIGN KEY([IdTrainingSession])
REFERENCES [RH].[TrainingSession] ([Id])
 
ALTER TABLE [RH].[TrainingRequest] CHECK CONSTRAINT [FK_TrainingRequest_TrainingSession]
 
ALTER TABLE [RH].[TrainingRequiredSkills]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequiredSkills_Skills] FOREIGN KEY([IdSkills])
REFERENCES [Payroll].[Skills] ([Id])
 
ALTER TABLE [RH].[TrainingRequiredSkills] CHECK CONSTRAINT [FK_TrainingRequiredSkills_Skills]
 
ALTER TABLE [RH].[TrainingRequiredSkills]  WITH CHECK ADD  CONSTRAINT [FK_TrainingRequiredSkills_Training] FOREIGN KEY([IdTraining])
REFERENCES [RH].[Training] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[TrainingRequiredSkills] CHECK CONSTRAINT [FK_TrainingRequiredSkills_Training]
 
ALTER TABLE [RH].[TrainingSeance]  WITH CHECK ADD  CONSTRAINT [FK_TrainingSeance_TrainingSession] FOREIGN KEY([IdTrainingSession])
REFERENCES [RH].[TrainingSession] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [RH].[TrainingSeance] CHECK CONSTRAINT [FK_TrainingSeance_TrainingSession]
 
ALTER TABLE [RH].[TrainingSession]  WITH CHECK ADD  CONSTRAINT [FK_TrainingSession_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [RH].[TrainingSession] CHECK CONSTRAINT [FK_TrainingSession_Employee]
 
ALTER TABLE [RH].[TrainingSession]  WITH CHECK ADD  CONSTRAINT [FK_TrainingSession_ExternalTrainer] FOREIGN KEY([IdExternalTrainer])
REFERENCES [RH].[ExternalTrainer] ([Id])
 
ALTER TABLE [RH].[TrainingSession] CHECK CONSTRAINT [FK_TrainingSession_ExternalTrainer]
 
ALTER TABLE [RH].[TrainingSession]  WITH CHECK ADD  CONSTRAINT [FK_TrainingSession_Training] FOREIGN KEY([IdTraining])
REFERENCES [RH].[Training] ([Id])
 
ALTER TABLE [RH].[TrainingSession] CHECK CONSTRAINT [FK_TrainingSession_Training]
 
ALTER TABLE [RH].[UserFileAccess]  WITH CHECK ADD  CONSTRAINT [FK_UserFileAccess_FileDrive] FOREIGN KEY([IdFile])
REFERENCES [RH].[FileDrive] ([Id])
 
ALTER TABLE [RH].[UserFileAccess] CHECK CONSTRAINT [FK_UserFileAccess_FileDrive]
 
ALTER TABLE [RH].[UserFileAccess]  WITH CHECK ADD  CONSTRAINT [FK_UserFileAccess_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[UserFileAccess] CHECK CONSTRAINT [FK_UserFileAccess_User]
 
ALTER TABLE [RH].[UserFileModification]  WITH CHECK ADD  CONSTRAINT [FK_UserFileModification_FileDrive] FOREIGN KEY([IdFile])
REFERENCES [RH].[FileDrive] ([Id])
 
ALTER TABLE [RH].[UserFileModification] CHECK CONSTRAINT [FK_UserFileModification_FileDrive]
 
ALTER TABLE [RH].[UserFileModification]  WITH CHECK ADD  CONSTRAINT [FK_UserFileModification_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [RH].[UserFileModification] CHECK CONSTRAINT [FK_UserFileModification_User]
 
ALTER TABLE [Sales].[BillingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BillingEmployee_BillingSession] FOREIGN KEY([IdBillingSession])
REFERENCES [Sales].[BillingSession] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[BillingEmployee] CHECK CONSTRAINT [FK_BillingEmployee_BillingSession]
 
ALTER TABLE [Sales].[BillingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BillingEmployee_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Sales].[BillingEmployee] CHECK CONSTRAINT [FK_BillingEmployee_Employee]
 
ALTER TABLE [Sales].[BillingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BillingEmployee_Project] FOREIGN KEY([IdProject])
REFERENCES [RH].[Project] ([Id])
 
ALTER TABLE [Sales].[BillingEmployee] CHECK CONSTRAINT [FK_BillingEmployee_Project]
 
ALTER TABLE [Sales].[BillingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_BillingEmployee_TimeSheet] FOREIGN KEY([IdTimeSheet])
REFERENCES [RH].[TimeSheet] ([Id])
 
ALTER TABLE [Sales].[BillingEmployee] CHECK CONSTRAINT [FK_BillingEmployee_TimeSheet]
 
ALTER TABLE [Sales].[DetailsSettlementMode]  WITH CHECK ADD  CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY([IdPaymentMethod])
REFERENCES [Payment].[PaymentMethod] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Sales].[DetailsSettlementMode] CHECK CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
 
ALTER TABLE [Sales].[DetailsSettlementMode]  WITH CHECK ADD  CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY([IdSettlementMode])
REFERENCES [Sales].[SettlementMode] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Sales].[DetailsSettlementMode] CHECK CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
 
ALTER TABLE [Sales].[DetailsSettlementMode]  WITH CHECK ADD  CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY([IdSettlementType])
REFERENCES [Sales].[SettlementType] ([Id])
ON DELETE SET NULL
 
ALTER TABLE [Sales].[DetailsSettlementMode] CHECK CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_BankAccount]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_Contact]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Currency] FOREIGN KEY([IdUsedCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_Currency]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_CurrencyRate] FOREIGN KEY([IdExchangeRate])
REFERENCES [Administration].[CurrencyRate] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_CurrencyRate]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DeliveryType] FOREIGN KEY([IdDeliveryType])
REFERENCES [Sales].[DeliveryType] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_DeliveryType]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DocumentStatus] FOREIGN KEY([IdDocumentStatus])
REFERENCES [Sales].[DocumentStatus] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_DocumentStatus]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_PaymentMethod] FOREIGN KEY([IdPaymentMethod])
REFERENCES [Payment].[PaymentMethod] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_PaymentMethod]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_PriceRequest] FOREIGN KEY([IdPriceRequest])
REFERENCES [Sales].[PriceRequest] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_PriceRequest]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Provisioning] FOREIGN KEY([IdProvision])
REFERENCES [Sales].[Provisioning] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_Provisioning]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_SettlementMode] FOREIGN KEY([IdSettlementMode])
REFERENCES [Sales].[SettlementMode] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_SettlementMode]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_Tiers]
 
ALTER TABLE [Sales].[Document]  WITH NOCHECK ADD  CONSTRAINT [FK_Document_User] FOREIGN KEY([IdValidator])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_User]
 
ALTER TABLE [Sales].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_User1] FOREIGN KEY([IdCreator])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_User1]
 
ALTER TABLE [Sales].[Document]  WITH NOCHECK ADD  CONSTRAINT [FK_Document_Vehicle] FOREIGN KEY([IdVehicle])
REFERENCES [Sales].[Vehicle] ([Id])
 
ALTER TABLE [Sales].[Document] CHECK CONSTRAINT [FK_Document_Vehicle]
 
ALTER TABLE [Sales].[DocumentExpenseLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentExpenseLine_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Sales].[DocumentExpenseLine] CHECK CONSTRAINT [FK_DocumentExpenseLine_Currency]
 
ALTER TABLE [Sales].[DocumentExpenseLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentExpenseLine_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[DocumentExpenseLine] CHECK CONSTRAINT [FK_DocumentExpenseLine_Document]
 
ALTER TABLE [Sales].[DocumentExpenseLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentExpenseLine_Expense] FOREIGN KEY([IdExpense])
REFERENCES [Sales].[Expense] ([Id])
 
ALTER TABLE [Sales].[DocumentExpenseLine] CHECK CONSTRAINT [FK_DocumentExpenseLine_Expense]
 
ALTER TABLE [Sales].[DocumentExpenseLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentExpenseLine_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Sales].[DocumentExpenseLine] CHECK CONSTRAINT [FK_DocumentExpenseLine_Taxe]
 
ALTER TABLE [Sales].[DocumentExpenseLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentExpenseLine_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[DocumentExpenseLine] CHECK CONSTRAINT [FK_DocumentExpenseLine_Tiers]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_Document]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_DocumentLine] FOREIGN KEY([IdDocumentLineAssociated])
REFERENCES [Sales].[DocumentLine] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_DocumentLine]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_DocumentLine2] FOREIGN KEY([IdDeliveryAssociated])
REFERENCES [Sales].[DocumentLine] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_DocumentLine2]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_Item]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_MeasureUnit] FOREIGN KEY([IdMeasureUnit])
REFERENCES [Inventory].[MeasureUnit] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_MeasureUnit]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_Prices] FOREIGN KEY([IdPrices])
REFERENCES [Sales].[Prices] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_Prices]
 
ALTER TABLE [Sales].[DocumentLine]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLine_Warehouse] FOREIGN KEY([IdWarehouse])
REFERENCES [Inventory].[Warehouse] ([Id])
 
ALTER TABLE [Sales].[DocumentLine] CHECK CONSTRAINT [FK_DocumentLine_Warehouse]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLineNegotiationOptions_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_Item]
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLineNegotiationOptions_User] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_User]
 
ALTER TABLE [Sales].[DocumentLinePrices]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLinePrices_DocumentLine] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[DocumentLinePrices] CHECK CONSTRAINT [FK_DocumentLinePrices_DocumentLine]
 
ALTER TABLE [Sales].[DocumentLinePrices]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLinePrices_Prices] FOREIGN KEY([IdPrices])
REFERENCES [Sales].[Prices] ([Id])
 
ALTER TABLE [Sales].[DocumentLinePrices] CHECK CONSTRAINT [FK_DocumentLinePrices_Prices]
 
ALTER TABLE [Sales].[DocumentLineTaxe]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLineTaxe_DocumentLine] FOREIGN KEY([IdDocumentLine])
REFERENCES [Sales].[DocumentLine] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[DocumentLineTaxe] CHECK CONSTRAINT [FK_DocumentLineTaxe_DocumentLine]
 
ALTER TABLE [Sales].[DocumentLineTaxe]  WITH CHECK ADD  CONSTRAINT [FK_DocumentLineTaxe_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Sales].[DocumentLineTaxe] CHECK CONSTRAINT [FK_DocumentLineTaxe_Taxe]
 
ALTER TABLE [Sales].[DocumentTaxsResume]  WITH CHECK ADD  CONSTRAINT [FK_DocumentTaxsResume_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Sales].[DocumentTaxsResume] CHECK CONSTRAINT [FK_DocumentTaxsResume_Document]
 
ALTER TABLE [Sales].[DocumentTaxsResume]  WITH CHECK ADD  CONSTRAINT [FK_DocumentTaxsResume_Taxe] FOREIGN KEY([Id_Tax])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Sales].[DocumentTaxsResume] CHECK CONSTRAINT [FK_DocumentTaxsResume_Taxe]
 
ALTER TABLE [Sales].[DocumentType]  WITH CHECK ADD  CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY([DefaultCodeDocumentTypeAssociated])
REFERENCES [Sales].[DocumentType] ([CodeType])
 
ALTER TABLE [Sales].[DocumentType] CHECK CONSTRAINT [FK_DocumentType_DocumentType]
 
ALTER TABLE [Sales].[DocumentTypeRelation]  WITH CHECK ADD  CONSTRAINT [FK_DocumentTypeRelation_DocumentType] FOREIGN KEY([CodeDocumentTypeAssociated])
REFERENCES [Sales].[DocumentType] ([CodeType])
 
ALTER TABLE [Sales].[DocumentTypeRelation] CHECK CONSTRAINT [FK_DocumentTypeRelation_DocumentType]
 
ALTER TABLE [Sales].[DocumentTypeRelation]  WITH CHECK ADD  CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation] FOREIGN KEY([CodeDocumentType])
REFERENCES [Sales].[DocumentType] ([CodeType])
 
ALTER TABLE [Sales].[DocumentTypeRelation] CHECK CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation]
 
ALTER TABLE [Sales].[DocumentWithholdingTax]  WITH NOCHECK ADD  CONSTRAINT [FK_DocumentWithholdingTax_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Sales].[DocumentWithholdingTax] CHECK CONSTRAINT [FK_DocumentWithholdingTax_Document]
 
ALTER TABLE [Sales].[DocumentWithholdingTax]  WITH NOCHECK ADD  CONSTRAINT [FK_DocumentWithholdingTax_WithholdingTax] FOREIGN KEY([IdWithholdingTax])
REFERENCES [Payment].[WithholdingTax] ([Id])
 
ALTER TABLE [Sales].[DocumentWithholdingTax] CHECK CONSTRAINT [FK_DocumentWithholdingTax_WithholdingTax]
 
ALTER TABLE [Sales].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[Expense] CHECK CONSTRAINT [FK_Expense_Item]
 
ALTER TABLE [Sales].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Sales].[Expense] CHECK CONSTRAINT [FK_Expense_Taxe]
 
ALTER TABLE [Sales].[FinancialCommitment]  WITH CHECK ADD  CONSTRAINT [FK_FinancialCommitment_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Sales].[FinancialCommitment] CHECK CONSTRAINT [FK_FinancialCommitment_Currency]
 
ALTER TABLE [Sales].[FinancialCommitment]  WITH CHECK ADD  CONSTRAINT [FK_FinancialCommitment_Document] FOREIGN KEY([IdDocument])
REFERENCES [Sales].[Document] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[FinancialCommitment] CHECK CONSTRAINT [FK_FinancialCommitment_Document]
 
ALTER TABLE [Sales].[FinancialCommitment]  WITH CHECK ADD  CONSTRAINT [FK_FinancialCommitment_DocumentStatus] FOREIGN KEY([IdStatus])
REFERENCES [Sales].[DocumentStatus] ([Id])
 
ALTER TABLE [Sales].[FinancialCommitment] CHECK CONSTRAINT [FK_FinancialCommitment_DocumentStatus]
 
ALTER TABLE [Sales].[FinancialCommitment]  WITH CHECK ADD  CONSTRAINT [FK_FinancialCommitment_PaymentMethod] FOREIGN KEY([IdPaymentMethod])
REFERENCES [Payment].[PaymentMethod] ([Id])
 
ALTER TABLE [Sales].[FinancialCommitment] CHECK CONSTRAINT [FK_FinancialCommitment_PaymentMethod]
 
ALTER TABLE [Sales].[FinancialCommitment]  WITH CHECK ADD  CONSTRAINT [FK_FinancialCommitment_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[FinancialCommitment] CHECK CONSTRAINT [FK_FinancialCommitment_Tiers]
 
ALTER TABLE [Sales].[PriceDetail]  WITH CHECK ADD  CONSTRAINT [FK_PriceDetail_Prices] FOREIGN KEY([IdPrices])
REFERENCES [Sales].[Prices] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[PriceDetail] CHECK CONSTRAINT [FK_PriceDetail_Prices]
 
ALTER TABLE [Sales].[PriceRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_PriceRequestDetail_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
 
ALTER TABLE [Sales].[PriceRequestDetail] CHECK CONSTRAINT [FK_PriceRequestDetail_Contact]
 
ALTER TABLE [Sales].[PriceRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_PriceRequestDetail_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Sales].[PriceRequestDetail] CHECK CONSTRAINT [FK_PriceRequestDetail_Item]
 
ALTER TABLE [Sales].[PriceRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_PriceRequestDetail_PriceRequest] FOREIGN KEY([IdPriceRequest])
REFERENCES [Sales].[PriceRequest] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[PriceRequestDetail] CHECK CONSTRAINT [FK_PriceRequestDetail_PriceRequest]
 
ALTER TABLE [Sales].[PriceRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_PriceRequestDetail_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[PriceRequestDetail] CHECK CONSTRAINT [FK_PriceRequestDetail_Tiers]
 
ALTER TABLE [Sales].[Prices]  WITH CHECK ADD  CONSTRAINT [FK_Prices_Currency] FOREIGN KEY([IdUsedCurrency])
REFERENCES [Administration].[Currency] ([Id])
ON DELETE SET DEFAULT
 
ALTER TABLE [Sales].[Prices] CHECK CONSTRAINT [FK_Prices_Currency]
 
ALTER TABLE [Sales].[Provisioning]  WITH CHECK ADD  CONSTRAINT [FK_Provisioning_ProvisioningOption] FOREIGN KEY([IdProvisioningOption])
REFERENCES [Sales].[ProvisioningOption] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Sales].[Provisioning] CHECK CONSTRAINT [FK_Provisioning_ProvisioningOption]
 
ALTER TABLE [Sales].[ProvisioningDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProvisioningDetails_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
 
ALTER TABLE [Sales].[ProvisioningDetails] CHECK CONSTRAINT [FK_ProvisioningDetails_Item]
 
ALTER TABLE [Sales].[ProvisioningDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProvisioningDetails_Provisioning] FOREIGN KEY([IdProvisioning])
REFERENCES [Sales].[Provisioning] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Sales].[ProvisioningDetails] CHECK CONSTRAINT [FK_ProvisioningDetails_Provisioning]
 
ALTER TABLE [Sales].[ProvisioningDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProvisioningDetails_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[ProvisioningDetails] CHECK CONSTRAINT [FK_ProvisioningDetails_Tiers]
 
ALTER TABLE [Sales].[PurchaseSettings]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseSetting_Company] FOREIGN KEY([Id])
REFERENCES [Shared].[Company] ([Id])
 
ALTER TABLE [Sales].[PurchaseSettings] CHECK CONSTRAINT [FK_PurchaseSetting_Company]
 
ALTER TABLE [Sales].[PurchaseSettings]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseSettings_User] FOREIGN KEY([IdPurchasingManager])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Sales].[PurchaseSettings] CHECK CONSTRAINT [FK_PurchaseSettings_User]
 
ALTER TABLE [Sales].[SaleSettings]  WITH CHECK ADD  CONSTRAINT [FK_SaleSetting_Company] FOREIGN KEY([Id])
REFERENCES [Shared].[Company] ([Id])
 
ALTER TABLE [Sales].[SaleSettings] CHECK CONSTRAINT [FK_SaleSetting_Company]
 
ALTER TABLE [Sales].[SearchItem]  WITH CHECK ADD  CONSTRAINT [FK_SearchItem_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[SearchItem] CHECK CONSTRAINT [FK_SearchItem_Tiers]
 
ALTER TABLE [Sales].[SearchItem]  WITH CHECK ADD  CONSTRAINT [FK_SearchItem_User] FOREIGN KEY([IdCashier])
REFERENCES [ERPSettings].[User] ([Id])
 
ALTER TABLE [Sales].[SearchItem] CHECK CONSTRAINT [FK_SearchItem_User]
 
ALTER TABLE [Sales].[TaxeGroupTiersConfig]  WITH CHECK ADD  CONSTRAINT [FK_TaxeTiersConfig_Taxe] FOREIGN KEY([IdTaxe])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Sales].[TaxeGroupTiersConfig] CHECK CONSTRAINT [FK_TaxeTiersConfig_Taxe]
 
ALTER TABLE [Sales].[TaxeGroupTiersConfig]  WITH CHECK ADD  CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers] FOREIGN KEY([IdTaxeGroupTiers])
REFERENCES [Sales].[TaxeGroupTiers] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[TaxeGroupTiersConfig] CHECK CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_Address] FOREIGN KEY([Id])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_Address]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT] FOREIGN KEY([IdPaymentCondition])
REFERENCES [Payment].[PaymentCondition] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER] FOREIGN KEY([IdTypeTiers])
REFERENCES [Sales].[TypeTiers] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_City]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_Country]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_Currency]
 
ALTER TABLE [Sales].[Tiers]  WITH NOCHECK ADD  CONSTRAINT [FK_Tiers_Phone] FOREIGN KEY([IdPhone])
REFERENCES [Shared].[Phone] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_Phone]
 
ALTER TABLE [Sales].[Tiers]  WITH NOCHECK ADD  CONSTRAINT [FK_Tiers_SalesPrice] FOREIGN KEY([IdSalesPrice])
REFERENCES [Sales].[SalesPrice] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_SalesPrice]
 
ALTER TABLE [Sales].[Tiers]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_TaxeGroupTiers] FOREIGN KEY([IdTaxeGroupTiers])
REFERENCES [Sales].[TaxeGroupTiers] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_TaxeGroupTiers]
 
ALTER TABLE [Sales].[Tiers]  WITH NOCHECK ADD  CONSTRAINT [FK_Tiers_TierCategory] FOREIGN KEY([IdTierCategory])
REFERENCES [Sales].[TierCategory] ([Id])
 
ALTER TABLE [Sales].[Tiers] CHECK CONSTRAINT [FK_Tiers_TierCategory]
 
ALTER TABLE [Sales].[Tiers_Provisioning]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_Provisioning_Provisioning] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[Tiers_Provisioning] CHECK CONSTRAINT [FK_Tiers_Provisioning_Provisioning]
 
ALTER TABLE [Sales].[Tiers_Provisioning]  WITH CHECK ADD  CONSTRAINT [FK_Tiers_Provisioning_Tiers_Provisioning] FOREIGN KEY([IdProvisioning])
REFERENCES [Sales].[Provisioning] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Sales].[Tiers_Provisioning] CHECK CONSTRAINT [FK_Tiers_Provisioning_Tiers_Provisioning]
 
ALTER TABLE [Sales].[TiersPrices]  WITH CHECK ADD  CONSTRAINT [FK_TiersPrices_Prices] FOREIGN KEY([IdPrices])
REFERENCES [Sales].[Prices] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[TiersPrices] CHECK CONSTRAINT [FK_TiersPrices_Prices]
 
ALTER TABLE [Sales].[TiersPrices]  WITH CHECK ADD  CONSTRAINT [FK_TiersPrices_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Sales].[TiersPrices] CHECK CONSTRAINT [FK_TiersPrices_Tiers]
 
ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_ModelOfItem] FOREIGN KEY([IdVehicleModel])
REFERENCES [Inventory].[ModelOfItem] ([Id])
 
ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_ModelOfItem]
 
ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Tiers]
 
ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_VehicleBrand] FOREIGN KEY([IdVehicleBrand])
REFERENCES [Inventory].[VehicleBrand] ([Id])
 
ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_VehicleBrand]
 
ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_VehicleEnergy] FOREIGN KEY([IdVehicleEnergy])
REFERENCES [Sales].[VehicleEnergy] ([Id])
 
ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_VehicleEnergy]
 
ALTER TABLE [Shared].[Address]  WITH NOCHECK ADD  CONSTRAINT [FK_Address_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Address_City]
 
ALTER TABLE [Shared].[Address]  WITH NOCHECK ADD  CONSTRAINT [FK_Address_Company] FOREIGN KEY([IdCompany])
REFERENCES [Shared].[Company] ([Id])
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Address_Company]
 
ALTER TABLE [Shared].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Office] FOREIGN KEY([IdOffice])
REFERENCES [Shared].[Office] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Address_Office]
 
ALTER TABLE [Shared].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_ZipCode] FOREIGN KEY([IdZipCode])
REFERENCES [Shared].[ZipCode] ([Id])
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Address_ZipCode]
 
ALTER TABLE [Shared].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Adress_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Adress_Tiers]
 
ALTER TABLE [Shared].[Address]  WITH NOCHECK ADD  CONSTRAINT [FK_Country_Address] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Shared].[Address] CHECK CONSTRAINT [FK_Country_Address]
 
ALTER TABLE [Shared].[Bank]  WITH CHECK ADD  CONSTRAINT [FK_Bank_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Shared].[Bank] CHECK CONSTRAINT [FK_Bank_Country]
 
ALTER TABLE [Shared].[Bank]  WITH NOCHECK ADD  CONSTRAINT [FK_Bank_Phone] FOREIGN KEY([IdPhone])
REFERENCES [Shared].[Phone] ([Id])
 
ALTER TABLE [Shared].[Bank] CHECK CONSTRAINT [FK_Bank_Phone]
 
ALTER TABLE [Shared].[BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_BankAccount_Bank] FOREIGN KEY([IdBank])
REFERENCES [Shared].[Bank] ([Id])
 
ALTER TABLE [Shared].[BankAccount] CHECK CONSTRAINT [FK_BankAccount_Bank]
 
ALTER TABLE [Shared].[BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_BankAccount_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Shared].[BankAccount] CHECK CONSTRAINT [FK_BankAccount_City]
 
ALTER TABLE [Shared].[BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_BankAccount_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
 
ALTER TABLE [Shared].[BankAccount] CHECK CONSTRAINT [FK_BankAccount_Country]
 
ALTER TABLE [Shared].[BankAccount]  WITH NOCHECK ADD  CONSTRAINT [FK_BankAccount_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Shared].[BankAccount] CHECK CONSTRAINT [FK_BankAccount_Currency]
 
ALTER TABLE [Shared].[BankAgency]  WITH CHECK ADD  CONSTRAINT [FK_BankAgency_Bank] FOREIGN KEY([IdBank])
REFERENCES [Shared].[Bank] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[BankAgency] CHECK CONSTRAINT [FK_BankAgency_Bank]
 
ALTER TABLE [Shared].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([IdCountry])
REFERENCES [Shared].[Country] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[City] CHECK CONSTRAINT [FK_City_Country]
 
ALTER TABLE [Shared].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Currency] FOREIGN KEY([IdCurrency])
REFERENCES [Administration].[Currency] ([Id])
 
ALTER TABLE [Shared].[Company] CHECK CONSTRAINT [FK_Company_Currency]
 
ALTER TABLE [Shared].[Company]  WITH NOCHECK ADD  CONSTRAINT [FK_Company_Taxe] FOREIGN KEY([IdDefaultTax])
REFERENCES [Shared].[Taxe] ([Id])
 
ALTER TABLE [Shared].[Company] CHECK CONSTRAINT [FK_Company_Taxe]
 
ALTER TABLE [Shared].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Address] FOREIGN KEY([IdAddress])
REFERENCES [Shared].[Address] ([Id])
 
ALTER TABLE [Shared].[Contact] CHECK CONSTRAINT [FK_Contact_Address]
 
ALTER TABLE [Shared].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_BankAgency] FOREIGN KEY([IdAgency])
REFERENCES [Shared].[BankAgency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Contact] CHECK CONSTRAINT [FK_Contact_BankAgency]
 
ALTER TABLE [Shared].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Company] FOREIGN KEY([IdCompany])
REFERENCES [Shared].[Company] ([Id])
 
ALTER TABLE [Shared].[Contact] CHECK CONSTRAINT [FK_Contact_Company]
 
ALTER TABLE [Shared].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Office] FOREIGN KEY([IdOffice])
REFERENCES [Shared].[Office] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Contact] CHECK CONSTRAINT [FK_Contact_Office]
 
ALTER TABLE [Shared].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Contact] CHECK CONSTRAINT [FK_Contact_Tiers]
 
ALTER TABLE [Shared].[ContactTypeDocument]  WITH CHECK ADD  CONSTRAINT [FK_ContactTypeDocument_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[ContactTypeDocument] CHECK CONSTRAINT [FK_ContactTypeDocument_Contact]
 
ALTER TABLE [Shared].[DateToRemember]  WITH CHECK ADD  CONSTRAINT [FK_DateToRemember_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
 
ALTER TABLE [Shared].[DateToRemember] CHECK CONSTRAINT [FK_DateToRemember_Contact]
 
ALTER TABLE [Shared].[DateToRemember]  WITH CHECK ADD  CONSTRAINT [FK_DateToRemember_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Shared].[DateToRemember] CHECK CONSTRAINT [FK_DateToRemember_Tiers]
 
ALTER TABLE [Shared].[DayOff]  WITH CHECK ADD  CONSTRAINT [FK_DayOff_Period] FOREIGN KEY([IdPeriod])
REFERENCES [Shared].[Period] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[DayOff] CHECK CONSTRAINT [FK_DayOff_Period]
 
ALTER TABLE [Shared].[Hours]  WITH CHECK ADD  CONSTRAINT [FK_Hours_Period] FOREIGN KEY([IdPeriod])
REFERENCES [Shared].[Period] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Hours] CHECK CONSTRAINT [FK_Hours_Period]
 
ALTER TABLE [Shared].[NewUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_Mail] FOREIGN KEY([IdEmail])
REFERENCES [Shared].[Email] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[NewUserEmail] CHECK CONSTRAINT [FK_Mail]
 
ALTER TABLE [Shared].[NewUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_NewUserEmail] FOREIGN KEY([IdUser])
REFERENCES [ERPSettings].[User] ([Id])
ON DELETE CASCADE
 
ALTER TABLE [Shared].[NewUserEmail] CHECK CONSTRAINT [FK_NewUserEmail]
 
ALTER TABLE [Shared].[Office]  WITH CHECK ADD  CONSTRAINT [FK_Office_Employee] FOREIGN KEY([IdOfficeManager])
REFERENCES [Payroll].[Employee] ([Id])
 
ALTER TABLE [Shared].[Office] CHECK CONSTRAINT [FK_Office_Employee]
 
ALTER TABLE [Shared].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Contact] FOREIGN KEY([IdContact])
REFERENCES [Shared].[Contact] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
 
ALTER TABLE [Shared].[Phone] CHECK CONSTRAINT [FK_Phone_Contact]
 
ALTER TABLE [Shared].[Taxe]  WITH CHECK ADD  CONSTRAINT [FK_Taxe_TaxeType] FOREIGN KEY([IdTaxeType])
REFERENCES [Shared].[TaxeType] ([Id])
 
ALTER TABLE [Shared].[Taxe] CHECK CONSTRAINT [FK_Taxe_TaxeType]
 
ALTER TABLE [Shared].[ZipCode]  WITH CHECK ADD  CONSTRAINT [FK_ZipCode_City] FOREIGN KEY([IdCity])
REFERENCES [Shared].[City] ([Id])
 
ALTER TABLE [Shared].[ZipCode] CHECK CONSTRAINT [FK_ZipCode_City]
 
ALTER TABLE [Treasury].[DetailReconciliation]  WITH CHECK ADD  CONSTRAINT [FK_DetailReconciliation] FOREIGN KEY([IdReconciliation])
REFERENCES [Treasury].[Reconciliation] ([Id])
 
ALTER TABLE [Treasury].[DetailReconciliation] CHECK CONSTRAINT [FK_DetailReconciliation]
 
ALTER TABLE [Treasury].[DetailReconciliation]  WITH CHECK ADD  CONSTRAINT [FK_DetailReconciliation3] FOREIGN KEY([IdDetailTimetable])
REFERENCES [Treasury].[DetailTimetable] ([Id])
 
ALTER TABLE [Treasury].[DetailReconciliation] CHECK CONSTRAINT [FK_DetailReconciliation3]
 
ALTER TABLE [Treasury].[DetailTimetable]  WITH CHECK ADD  CONSTRAINT [FK_DetailTimetable_PaymentType] FOREIGN KEY([IdPaymentType])
REFERENCES [Payment].[PaymentType] ([Id])
 
ALTER TABLE [Treasury].[DetailTimetable] CHECK CONSTRAINT [FK_DetailTimetable_PaymentType]
 
ALTER TABLE [Treasury].[DetailTimetable]  WITH CHECK ADD  CONSTRAINT [FK_DetailTimetable_Timetable] FOREIGN KEY([IdTimetable])
REFERENCES [Treasury].[Timetable] ([Id])
 
ALTER TABLE [Treasury].[DetailTimetable] CHECK CONSTRAINT [FK_DetailTimetable_Timetable]
 
ALTER TABLE [Treasury].[OperationCash]  WITH CHECK ADD  CONSTRAINT [FK_Operation_SessionCash] FOREIGN KEY([IdSession])
REFERENCES [Payment].[SessionCash] ([Id])
 
ALTER TABLE [Treasury].[OperationCash] CHECK CONSTRAINT [FK_Operation_SessionCash]
 
ALTER TABLE [Treasury].[ReceiptSpent]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptSpent_PaymentMethod] FOREIGN KEY([IdPaymentMethod])
REFERENCES [Payment].[PaymentMethod] ([Id])
 
ALTER TABLE [Treasury].[ReceiptSpent] CHECK CONSTRAINT [FK_ReceiptSpent_PaymentMethod]
 
ALTER TABLE [Treasury].[ReceiptSpent]  WITH CHECK ADD  CONSTRAINT [FK_RecipeSpent_PaymentDirection] FOREIGN KEY([IdPaymentDirection])
REFERENCES [Treasury].[PaymentDirection] ([Id])
 
ALTER TABLE [Treasury].[ReceiptSpent] CHECK CONSTRAINT [FK_RecipeSpent_PaymentDirection]
 
ALTER TABLE [Treasury].[ReceiptSpent]  WITH CHECK ADD  CONSTRAINT [FK_RecipeSpent_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Treasury].[ReceiptSpent] CHECK CONSTRAINT [FK_RecipeSpent_Tiers]
 
ALTER TABLE [Treasury].[Reconciliation]  WITH CHECK ADD  CONSTRAINT [FK_Reconciliation_BankAccount] FOREIGN KEY([IdBankAccount])
REFERENCES [Shared].[BankAccount] ([Id])
 
ALTER TABLE [Treasury].[Reconciliation] CHECK CONSTRAINT [FK_Reconciliation_BankAccount]
 
ALTER TABLE [Treasury].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Document] FOREIGN KEY([IdDeliveryForm])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Treasury].[Ticket] CHECK CONSTRAINT [FK_Ticket_Document]
 
ALTER TABLE [Treasury].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Document1] FOREIGN KEY([IdInvoice])
REFERENCES [Sales].[Document] ([Id])
 
ALTER TABLE [Treasury].[Ticket] CHECK CONSTRAINT [FK_Ticket_Document1]
 
ALTER TABLE [Treasury].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_SessionCash] FOREIGN KEY([IdSessionCash])
REFERENCES [Payment].[SessionCash] ([Id])
 
ALTER TABLE [Treasury].[Ticket] CHECK CONSTRAINT [FK_Ticket_SessionCash]
 
ALTER TABLE [Treasury].[TicketPayment]  WITH CHECK ADD  CONSTRAINT [FK_TicketPayment_PaymentType] FOREIGN KEY([IdPaymentType])
REFERENCES [Payment].[PaymentType] ([Id])
 
ALTER TABLE [Treasury].[TicketPayment] CHECK CONSTRAINT [FK_TicketPayment_PaymentType]
 
ALTER TABLE [Treasury].[TicketPayment]  WITH CHECK ADD  CONSTRAINT [FK_TicketPayment_Ticket] FOREIGN KEY([IdTicket])
REFERENCES [Treasury].[Ticket] ([Id])
 
ALTER TABLE [Treasury].[TicketPayment] CHECK CONSTRAINT [FK_TicketPayment_Ticket]
 
ALTER TABLE [Treasury].[Timetable]  WITH CHECK ADD  CONSTRAINT [FK_Timetable_PaymentType] FOREIGN KEY([IdPaymentType])
REFERENCES [Payment].[PaymentType] ([Id])
 
ALTER TABLE [Treasury].[Timetable] CHECK CONSTRAINT [FK_Timetable_PaymentType]
 
ALTER TABLE [Treasury].[Timetable]  WITH CHECK ADD  CONSTRAINT [FK_Timetable_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Treasury].[Timetable] CHECK CONSTRAINT [FK_Timetable_Tiers]