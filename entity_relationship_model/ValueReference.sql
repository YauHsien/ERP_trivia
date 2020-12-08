USE [ERP_trial]
GO
/****** Object:  Table [dbo].[BookkeepingEntry]    Script Date: 2020/12/8 下午 05:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookkeepingEntry](
	[Id] [uniqueidentifier] NOT NULL,
	[ValueRef] [uniqueidentifier] NOT NULL,
	[DebtAccount] [nchar](4) NOT NULL,
	[CreditAccount] [nchar](4) NOT NULL,
 CONSTRAINT [PK_BookkeepingEntry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerOrderItem]    Script Date: 2020/12/8 下午 05:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderItem](
	[Id] [uniqueidentifier] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[Sku] [nvarchar](32) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[PriceValueRef] [uniqueidentifier] NOT NULL,
	[CostValueRef] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CustomerOrderItem1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValueEntity]    Script Date: 2020/12/8 下午 05:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValueEntity](
	[Id] [uniqueidentifier] NOT NULL,
	[Value] [money] NOT NULL,
 CONSTRAINT [PK_ValueEntity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_ValueEntity] UNIQUE NONCLUSTERED 
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValueReference]    Script Date: 2020/12/8 下午 05:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValueReference](
	[Id] [uniqueidentifier] NOT NULL,
	[ValueEntityId] [uniqueidentifier] NOT NULL,
	[SourceTableId] [int] NOT NULL,
 CONSTRAINT [PK_ValueReference] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BookkeepingEntry] ADD  CONSTRAINT [DF_BookkeepingEntry_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[CustomerOrderItem] ADD  CONSTRAINT [DF_CustomerOrderItem1_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[CustomerOrderItem] ADD  CONSTRAINT [DF_CustomerOrderItem1_DateTime]  DEFAULT (sysdatetime()) FOR [DateTime]
GO
ALTER TABLE [dbo].[ValueEntity] ADD  CONSTRAINT [DF_ValueEntity_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[ValueEntity] ADD  CONSTRAINT [DF_ValueEntity_Value]  DEFAULT ((0)) FOR [Value]
GO
ALTER TABLE [dbo].[ValueReference] ADD  CONSTRAINT [DF_ValueReference_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[BookkeepingEntry]  WITH CHECK ADD  CONSTRAINT [FK_BookkeepingEntry_ValueReference] FOREIGN KEY([ValueRef])
REFERENCES [dbo].[ValueReference] ([Id])
GO
ALTER TABLE [dbo].[BookkeepingEntry] CHECK CONSTRAINT [FK_BookkeepingEntry_ValueReference]
GO
ALTER TABLE [dbo].[CustomerOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderItem_ValueReference] FOREIGN KEY([PriceValueRef])
REFERENCES [dbo].[ValueReference] ([Id])
GO
ALTER TABLE [dbo].[CustomerOrderItem] CHECK CONSTRAINT [FK_CustomerOrderItem_ValueReference]
GO
ALTER TABLE [dbo].[CustomerOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderItem_ValueReference1] FOREIGN KEY([CostValueRef])
REFERENCES [dbo].[ValueReference] ([Id])
GO
ALTER TABLE [dbo].[CustomerOrderItem] CHECK CONSTRAINT [FK_CustomerOrderItem_ValueReference1]
GO
ALTER TABLE [dbo].[ValueReference]  WITH CHECK ADD  CONSTRAINT [FK_ValueReference_ValueEntity] FOREIGN KEY([ValueEntityId])
REFERENCES [dbo].[ValueEntity] ([Id])
GO
ALTER TABLE [dbo].[ValueReference] CHECK CONSTRAINT [FK_ValueReference_ValueEntity]
GO
