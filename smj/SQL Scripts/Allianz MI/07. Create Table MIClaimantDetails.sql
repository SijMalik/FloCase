/****** Object:  Table [dbo].[MIClaimantDetails]    Script Date: 05/08/2012 15:52:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MIClaimantDetails](
	[MIClaimantDetails_MIClaimantDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[MIClaimantDetails_CaseID] [int] NOT NULL,
	[MIClaimantDetails_ContactID] [int] NOT NULL,
	[MIClaimantDetails_ClaimantSolicitorFirm] [varchar](50) NULL,
	[MIClaimantDetails_ClaimantSolicitorOffice] [varchar](50) NULL,
	[MIClaimantDetails_DamagesSettledDate] [smalldatetime] NULL,
	[MIClaimantDetails_CostsSettledDate] [smalldatetime] NULL,
	[MIClaimantDetails_ModeOfSettlement] [varchar](10) NULL,
	[MIClaimantDetails_TotalDamagesPaid] [money] NULL,
	[MIClaimantDetails_GeneralDamagesPaid] [money] NULL,
	[MIClaimantDetails_TotalSpecialDamagesPaid] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidCRU] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidNHS] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidAmb] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidPropertyDamage] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidCreditHire] [money] NULL,
	[MIClaimantDetails_SpecialDamagesPaidExcluding] [money] NULL,
	[MIClaimantDetails_TotalTPCostsClaimed] [money] NULL,
	[MIClaimantDetails_TotalTPCostsPaid] [money] NULL,
	[MIClaimantDetails_DamagesRecovered] [money] NULL,
	[MIClaimantDetails_CostsRecovered] [money] NULL,
	[MIClaimantDetails_SplitLiability] [varchar](10) NULL,
	[MIClaimantDetails_AllianzLiabilityDefendant] [money] NULL,
	[MIClaimantDetails_ContributoryNegligence] [varchar](10) NULL,
	[MIClaimantDetails_AllianzLiabilityContribNeg] [money] NULL,
	[CreateUser] [varchar](255) NULL,
	[CreateDate] [smalldatetime] NULL,
	[Inactive] [int] NULL,
 CONSTRAINT [PK_MIClaimantDetails] PRIMARY KEY CLUSTERED 
(
	[MIClaimantDetails_MIClaimantDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO