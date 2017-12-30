object CM: TCM
  OldCreateOrder = False
  Height = 728
  Width = 1004
  object SQLConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Port=222'
      'HostName=test.cookplay.net'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      'Filters={}')
    Connected = True
    Left = 42
    Top = 20
    UniqueId = '{99462119-7BE3-4DD0-A3CB-465C8878F7FC}'
  end
  object DSFindUser: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'EMAIL'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'PWD'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsFindUser'
    RemoteServer = DSProviderConnection
    Left = 44
    Top = 90
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection
    Left = 150
    Top = 18
  end
  object memUser: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 358
    Top = 170
    object memUserSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memUserNickname: TWideStringField
      FieldName = 'Nickname'
      Size = 10
    end
    object memUserID: TStringField
      FieldName = 'ID'
      Size = 100
    end
    object memUserPwd: TStringField
      FieldName = 'Pwd'
    end
    object memUserName: TWideStringField
      FieldName = 'Name'
    end
    object memUserNational: TStringField
      FieldName = 'National'
      Size = 3
    end
    object memUserBirthday: TStringField
      FieldName = 'Birthday'
      Size = 10
    end
    object memUserGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object memUserIP: TStringField
      FieldName = 'IP'
      Size = 100
    end
    object memUserEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object memUserIntroduction: TStringField
      FieldName = 'Introduction'
      Size = 200
    end
    object memUserPicture: TStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memUserSSO: TBooleanField
      FieldName = 'SSO'
    end
    object memUserCreatedDate: TDateTimeField
      FieldName = 'CreatedDate'
    end
    object memUserLastUpdatedDate: TDateTimeField
      FieldName = 'LastUpdatedDate'
    end
    object memUserWithdrawaldate: TDateTimeField
      FieldName = 'Withdrawaldate'
    end
    object memUserWithdrawal: TBooleanField
      FieldName = 'Withdrawal'
    end
    object memUserAgreeMarketing: TBooleanField
      FieldName = 'AgreeMarketing'
    end
    object memUserDeleted: TBooleanField
      FieldName = 'Deleted'
    end
    object memUserLevel: TStringField
      FieldName = 'Level'
      Size = 100
    end
  end
  object DSUserCount: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsUserCount'
    RemoteServer = DSProviderConnection
    Left = 38
    Top = 160
  end
  object DSSetup: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsSetup'
    RemoteServer = DSProviderConnection
    Left = 38
    Top = 222
  end
  object DSSetupInsert: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'UserSerial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AlaramOn'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsSetupInsert'
    RemoteServer = DSProviderConnection
    Left = 142
    Top = 224
  end
  object memCategory: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 446
    Top = 170
    object memCategorySerial: TLargeintField
      FieldName = 'Serial'
    end
    object memCategoryCategoryType: TWideStringField
      FieldName = 'CategoryType'
      Size = 50
    end
    object memCategoryCategoryCode: TSmallintField
      FieldName = 'CategoryCode'
    end
    object memCategoryCategoryName: TWideStringField
      FieldName = 'CategoryName'
      Size = 50
    end
    object memCategorySeq: TIntegerField
      FieldName = 'Seq'
    end
    object memCategoryComment: TWideStringField
      FieldName = 'Comment'
      Size = 50
    end
    object memCategoryDeleted: TBooleanField
      FieldName = 'Deleted'
    end
  end
  object DSCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsCategory'
    RemoteServer = DSProviderConnection
    Left = 40
    Top = 310
  end
  object DSRecipe: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'Serial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsRecipe'
    RemoteServer = DSProviderConnection
    Left = 40
    Top = 390
  end
  object memMyRecipe: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 530
    Top = 170
    object memMyRecipeSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMyRecipeUsers_Serial: TLargeintField
      FieldName = 'Users_Serial'
      Required = True
    end
    object memMyRecipeTitle: TWideStringField
      FieldName = 'Title'
      Required = True
      Size = 100
    end
    object memMyRecipeDescription: TWideStringField
      FieldName = 'Description'
      Size = 1000
    end
    object memMyRecipePictureType: TWideStringField
      FieldName = 'PictureType'
      Size = 100
    end
    object memMyRecipePicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memMyRecipePictureSquare: TWideStringField
      FieldName = 'PictureSquare'
      Size = 200
    end
    object memMyRecipePictureRectangle: TWideStringField
      FieldName = 'PictureRectangle'
      Size = 200
    end
    object memMyRecipeCategory: TWideStringField
      FieldName = 'Category'
      Size = 200
    end
    object memMyRecipeMakingLevel: TSmallintField
      FieldName = 'MakingLevel'
    end
    object memMyRecipeMakingTime: TSmallintField
      FieldName = 'MakingTime'
    end
    object memMyRecipeServings: TSmallintField
      FieldName = 'Servings'
    end
    object memMyRecipeHashcode: TWideStringField
      FieldName = 'Hashcode'
      Size = 200
    end
    object memMyRecipeCreatedDate: TDateTimeField
      FieldName = 'CreatedDate'
    end
    object memMyRecipeUpdatedDate: TDateTimeField
      FieldName = 'UpdatedDate'
    end
    object memMyRecipePublished: TBooleanField
      FieldName = 'Published'
    end
    object memMyRecipeDeleted: TBooleanField
      FieldName = 'Deleted'
    end
  end
  object DSMyRecipe: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsMyRecipe'
    RemoteServer = DSProviderConnection
    Left = 398
    Top = 390
  end
  object DSMyMethod: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
        Value = '-1'
      end>
    ProviderName = 'dsMyMethod'
    RemoteServer = DSProviderConnection
    Left = 490
    Top = 390
  end
  object DSMyIngredient: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
        Value = '-1'
      end>
    ProviderName = 'dsMyIngredient'
    RemoteServer = DSProviderConnection
    Left = 588
    Top = 394
    object DSMyIngredientSerial: TLargeintField
      FieldName = 'Serial'
      Origin = '`Serial`'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object DSMyIngredientRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
      Origin = 'Recipe_Serial'
    end
    object DSMyIngredientRecipeMethod_Serial: TLargeintField
      FieldName = 'RecipeMethod_Serial'
      Origin = 'RecipeMethod_Serial'
    end
    object DSMyIngredientLinkedRecipe: TLargeintField
      FieldName = 'LinkedRecipe'
      Origin = 'LinkedRecipe'
    end
    object DSMyIngredientSeq: TIntegerField
      FieldName = 'Seq'
      Origin = 'Seq'
    end
    object DSMyIngredientItemType: TSmallintField
      FieldName = 'ItemType'
      Origin = 'ItemType'
    end
    object DSMyIngredientItemWeightValue: TBCDField
      FieldName = 'ItemWeightValue'
      Origin = 'ItemWeightValue'
      Precision = 10
      Size = 1
    end
    object DSMyIngredientItemTimeValue: TWideStringField
      FieldName = 'ItemTimeValue'
      Origin = 'ItemTimeValue'
      Size = 8
    end
    object DSMyIngredientItemTemperatureValue: TBCDField
      FieldName = 'ItemTemperatureValue'
      Origin = 'ItemTemperatureValue'
      Precision = 10
      Size = 1
    end
    object DSMyIngredientItemUnit: TSmallintField
      FieldName = 'ItemUnit'
      Origin = 'ItemUnit'
    end
    object DSMyIngredientTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'Title'
      Size = 100
    end
    object DSMyIngredientAmount: TWideStringField
      FieldName = 'Amount'
      Origin = 'Amount'
      Size = 50
    end
    object DSMyIngredientUnit: TWideStringField
      FieldName = 'Unit'
      Origin = 'Unit'
      Size = 50
    end
  end
  object memMyMethod: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Serial'
        DataType = ftLargeint
      end
      item
        Name = 'Recipe_Serial'
        Attributes = [faRequired]
        DataType = ftLargeint
      end
      item
        Name = 'MethodType'
        DataType = ftSmallint
      end
      item
        Name = 'PictureType'
        DataType = ftSmallint
      end
      item
        Name = 'Picture'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'PictureRectangle'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'PictureSquare'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 1000
      end
      item
        Name = 'Seq'
        DataType = ftSmallint
      end
      item
        Name = 'StepSeq'
        DataType = ftSmallint
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 532
    Top = 232
    Content = {
      414442530F00DA25C5040000FF00010001FF02FF030400160000006D0065006D
      004D0079004D006500740068006F00640005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B04000C000000530065
      007200690061006C0005000C000000530065007200690061006C000C00010000
      000E000D000F000110000111000112000113000114000115000C000000530065
      007200690061006C00FEFF0B04001A0000005200650063006900700065005F00
      530065007200690061006C0005001A0000005200650063006900700065005F00
      530065007200690061006C000C00020000000E000D000F000111000113000114
      000115001A0000005200650063006900700065005F0053006500720069006100
      6C00FEFF0B0400140000004D006500740068006F006400540079007000650005
      00140000004D006500740068006F00640054007900700065000C00030000000E
      0016000F00011000011100011200011300011400011500140000004D00650074
      0068006F0064005400790070006500FEFF0B0400160000005000690063007400
      7500720065005400790070006500050016000000500069006300740075007200
      650054007900700065000C00040000000E0016000F0001100001110001120001
      1300011400011500160000005000690063007400750072006500540079007000
      6500FEFF0B04000E000000500069006300740075007200650005000E00000050
      006900630074007500720065000C00050000000E0017001800C80000000F0001
      10000111000112000113000114000115000E0000005000690063007400750072
      0065001900C8000000FEFF0B0400200000005000690063007400750072006500
      520065006300740061006E0067006C0065000500200000005000690063007400
      750072006500520065006300740061006E0067006C0065000C00060000000E00
      17001800C80000000F0001100001110001120001130001140001150020000000
      5000690063007400750072006500520065006300740061006E0067006C006500
      1900C8000000FEFF0B04001A0000005000690063007400750072006500530071
      00750061007200650005001A0000005000690063007400750072006500530071
      0075006100720065000C00070000000E0017001800C80000000F000110000111
      000112000113000114000115001A000000500069006300740075007200650053
      00710075006100720065001900C8000000FEFF0B040016000000440065007300
      6300720069007000740069006F006E0005001600000044006500730063007200
      69007000740069006F006E000C00080000000E0017001800E80300000F000110
      0001110001120001130001140001150016000000440065007300630072006900
      7000740069006F006E001900E8030000FEFF0B04000600000053006500710005
      00060000005300650071000C00090000000E0016000F00011000011100011200
      01130001140001150006000000530065007100FEFF0B04000E00000053007400
      6500700053006500710005000E00000053007400650070005300650071000C00
      0A0000000E0016000F000110000111000112000113000114000115000E000000
      5300740065007000530065007100FEFEFF1AFEFF1BFEFF1CFEFEFEFF1DFEFF1E
      FF1FFEFEFE0E004D0061006E0061006700650072001E00550070006400610074
      00650073005200650067006900730074007200790012005400610062006C0065
      004C006900730074000A005400610062006C00650008004E0061006D00650014
      0053006F0075007200630065004E0061006D0065000A00540061006200490044
      00240045006E0066006F0072006300650043006F006E00730074007200610069
      006E00740073001E004D0069006E0069006D0075006D00430061007000610063
      00690074007900180043006800650063006B004E006F0074004E0075006C006C
      00140043006F006C0075006D006E004C006900730074000C0043006F006C0075
      006D006E00100053006F007500720063006500490044000E006400740049006E
      0074003600340010004400610074006100540079007000650014005300650061
      00720063006800610062006C006500120041006C006C006F0077004E0075006C
      006C000800420061007300650014004F0041006C006C006F0077004E0075006C
      006C0012004F0049006E0055007000640061007400650010004F0049006E0057
      0068006500720065001A004F0072006900670069006E0043006F006C004E0061
      006D0065000E006400740049006E007400310036001800640074005700690064
      00650053007400720069006E0067000800530069007A006500140053006F0075
      00720063006500530069007A0065001C0043006F006E00730074007200610069
      006E0074004C00690073007400100056006900650077004C006900730074000E
      0052006F0077004C006900730074001800520065006C006100740069006F006E
      004C006900730074001C0055007000640061007400650073004A006F00750072
      006E0061006C000E004300680061006E00670065007300}
    object memMyMethodSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMyMethodRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
      Required = True
    end
    object memMyMethodMethodType: TSmallintField
      FieldName = 'MethodType'
    end
    object memMyMethodPictureType: TSmallintField
      FieldName = 'PictureType'
    end
    object memMyMethodPicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memMyMethodPictureRectangle: TWideStringField
      FieldName = 'PictureRectangle'
      Size = 200
    end
    object memMyMethodPictureSquare: TWideStringField
      FieldName = 'PictureSquare'
      Size = 200
    end
    object memMyMethodDescription: TWideStringField
      FieldName = 'Description'
      Size = 1000
    end
    object memMyMethodSeq: TSmallintField
      FieldName = 'Seq'
    end
    object memMyMethodStepSeq: TSmallintField
      FieldName = 'StepSeq'
    end
  end
  object memMyIngredient: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Serial'
        DataType = ftLargeint
      end
      item
        Name = 'Recipe_Serial'
        DataType = ftLargeint
      end
      item
        Name = 'RecipeMethod_Serial'
        DataType = ftLargeint
      end
      item
        Name = 'LinkedRecipe'
        DataType = ftLargeint
      end
      item
        Name = 'Seq'
        DataType = ftInteger
      end
      item
        Name = 'ItemType'
        DataType = ftSmallint
      end
      item
        Name = 'ItemWeightValue'
        DataType = ftBCD
        Precision = 10
        Size = 1
      end
      item
        Name = 'ItemTimeValue'
        DataType = ftWideString
        Size = 8
      end
      item
        Name = 'ItemTemperatureValue'
        DataType = ftBCD
        Precision = 10
        Size = 1
      end
      item
        Name = 'ItemUnit'
        DataType = ftSmallint
      end
      item
        Name = 'Title'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Amount'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Unit'
        DataType = ftWideString
        Size = 50
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 534
    Top = 296
    Content = {
      414442530F00DA2568060000FF00010001FF02FF0304001E0000006D0065006D
      004D00790049006E006700720065006400690065006E00740005000A00000054
      00610062006C006500060000000000070000080032000000090000FF0AFF0B04
      000C000000530065007200690061006C0005000C000000530065007200690061
      006C000C00010000000E000D000F000110000111000112000113000114000115
      000C000000530065007200690061006C00FEFF0B04001A000000520065006300
      6900700065005F00530065007200690061006C0005001A000000520065006300
      6900700065005F00530065007200690061006C000C00020000000E000D000F00
      0110000111000112000113000114000115001A00000052006500630069007000
      65005F00530065007200690061006C00FEFF0B04002600000052006500630069
      00700065004D006500740068006F0064005F00530065007200690061006C0005
      00260000005200650063006900700065004D006500740068006F0064005F0053
      0065007200690061006C000C00030000000E000D000F00011000011100011200
      011300011400011500260000005200650063006900700065004D006500740068
      006F0064005F00530065007200690061006C00FEFF0B0400180000004C006900
      6E006B00650064005200650063006900700065000500180000004C0069006E00
      6B00650064005200650063006900700065000C00040000000E000D000F000110
      00011100011200011300011400011500180000004C0069006E006B0065006400
      520065006300690070006500FEFF0B0400060000005300650071000500060000
      005300650071000C00050000000E0016000F0001100001110001120001130001
      140001150006000000530065007100FEFF0B0400100000004900740065006D00
      54007900700065000500100000004900740065006D0054007900700065000C00
      060000000E0017000F0001100001110001120001130001140001150010000000
      4900740065006D005400790070006500FEFF0B04001E0000004900740065006D
      00570065006900670068007400560061006C007500650005001E000000490074
      0065006D00570065006900670068007400560061006C00750065000C00070000
      000E00180019000A0000001A00010000000F0001100001110001120001130001
      14000115001E0000004900740065006D00570065006900670068007400560061
      006C00750065001B000A0000001C0001000000FEFF0B04001A00000049007400
      65006D00540069006D006500560061006C007500650005001A00000049007400
      65006D00540069006D006500560061006C00750065000C00080000000E001D00
      1E00080000000F000110000111000112000113000114000115001A0000004900
      740065006D00540069006D006500560061006C00750065001F0008000000FEFF
      0B0400280000004900740065006D00540065006D007000650072006100740075
      0072006500560061006C00750065000500280000004900740065006D00540065
      006D0070006500720061007400750072006500560061006C00750065000C0009
      0000000E00180019000A0000001A00010000000F000110000111000112000113
      00011400011500280000004900740065006D00540065006D0070006500720061
      007400750072006500560061006C00750065001B000A0000001C0001000000FE
      FF0B0400100000004900740065006D0055006E00690074000500100000004900
      740065006D0055006E00690074000C000A0000000E0017000F00011000011100
      011200011300011400011500100000004900740065006D0055006E0069007400
      FEFF0B04000A0000005400690074006C00650005000A0000005400690074006C
      0065000C000B0000000E001D001E00640000000F000110000111000112000113
      000114000115000A0000005400690074006C0065001F0064000000FEFF0B0400
      0C00000041006D006F0075006E00740005000C00000041006D006F0075006E00
      74000C000C0000000E001D001E00320000000F00011000011100011200011300
      0114000115000C00000041006D006F0075006E0074001F0032000000FEFF0B04
      000800000055006E006900740005000800000055006E00690074000C000D0000
      000E001D001E00320000000F0001100001110001120001130001140001150008
      00000055006E00690074001F0032000000FEFEFF20FEFF21FEFF22FEFEFEFF23
      FEFF24FF25FEFEFE0E004D0061006E0061006700650072001E00550070006400
      6100740065007300520065006700690073007400720079001200540061006200
      6C0065004C006900730074000A005400610062006C00650008004E0061006D00
      6500140053006F0075007200630065004E0061006D0065000A00540061006200
      49004400240045006E0066006F0072006300650043006F006E00730074007200
      610069006E00740073001E004D0069006E0069006D0075006D00430061007000
      61006300690074007900180043006800650063006B004E006F0074004E007500
      6C006C00140043006F006C0075006D006E004C006900730074000C0043006F00
      6C0075006D006E00100053006F007500720063006500490044000E0064007400
      49006E0074003600340010004400610074006100540079007000650014005300
      65006100720063006800610062006C006500120041006C006C006F0077004E00
      75006C006C000800420061007300650014004F0041006C006C006F0077004E00
      75006C006C0012004F0049006E0055007000640061007400650010004F004900
      6E00570068006500720065001A004F0072006900670069006E0043006F006C00
      4E0061006D0065000E006400740049006E007400330032000E00640074004900
      6E007400310036000A0064007400420043004400120050007200650063006900
      730069006F006E000A005300630061006C0065001E0053006F00750072006300
      650050007200650063006900730069006F006E00160053006F00750072006300
      65005300630061006C0065001800640074005700690064006500530074007200
      69006E0067000800530069007A006500140053006F0075007200630065005300
      69007A0065001C0043006F006E00730074007200610069006E0074004C006900
      73007400100056006900650077004C006900730074000E0052006F0077004C00
      6900730074001800520065006C006100740069006F006E004C00690073007400
      1C0055007000640061007400650073004A006F00750072006E0061006C000E00
      4300680061006E00670065007300}
    object memMyIngredientSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMyIngredientRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memMyIngredientRecipeMethod_Serial: TLargeintField
      FieldName = 'RecipeMethod_Serial'
    end
    object memMyIngredientLinkedRecipe: TLargeintField
      FieldName = 'LinkedRecipe'
    end
    object memMyIngredientSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memMyIngredientItemType: TSmallintField
      FieldName = 'ItemType'
    end
    object memMyIngredientItemWeightValue: TBCDField
      FieldName = 'ItemWeightValue'
      Precision = 10
      Size = 1
    end
    object memMyIngredientItemTimeValue: TWideStringField
      FieldName = 'ItemTimeValue'
      Size = 8
    end
    object memMyIngredientItemTemperatureValue: TBCDField
      FieldName = 'ItemTemperatureValue'
      Precision = 10
      Size = 1
    end
    object memMyIngredientItemUnit: TSmallintField
      FieldName = 'ItemUnit'
    end
    object memMyIngredientTitle: TWideStringField
      FieldName = 'Title'
      Size = 100
    end
    object memMyIngredientAmount: TWideStringField
      FieldName = 'Amount'
      Size = 50
    end
    object memMyIngredientUnit: TWideStringField
      FieldName = 'Unit'
      Size = 50
    end
  end
  object DSDeleteQue: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsDeleteQue'
    RemoteServer = DSProviderConnection
    Left = 266
    Top = 74
  end
  object DSRecipeBest: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsRecipeBest'
    RemoteServer = DSProviderConnection
    Left = 396
    Top = 470
  end
  object DSRecipeRecent: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsRecipRecent'
    RemoteServer = DSProviderConnection
    Left = 492
    Top = 470
  end
  object DSRecipeCount: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsRecipeCount'
    RemoteServer = DSProviderConnection
    Left = 148
    Top = 160
  end
  object DSvIngredientGroup: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsvIngredientGroup'
    RemoteServer = DSProviderConnection
    Left = 238
    Top = 390
  end
  object DSvRecipeComment: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
        Value = '-1'
      end>
    ProviderName = 'dsRecipeComment'
    RemoteServer = DSProviderConnection
    Left = 130
    Top = 390
  end
  object DSStep: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsStep'
    RemoteServer = DSProviderConnection
    Left = 44
    Top = 454
  end
  object DSIngredient: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'RecipeSerial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'StepSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsIngredient'
    RemoteServer = DSProviderConnection
    Left = 44
    Top = 522
  end
  object DSvMyStoryList: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsvStoryList'
    RemoteServer = DSProviderConnection
    Left = 392
    Top = 650
  end
  object DSStoryImages: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'StorySerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsStoryImages'
    RemoteServer = DSProviderConnection
    Left = 498
    Top = 652
  end
  object DSvStoryComment: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'StorySerial'
        ParamType = ptUnknown
        Value = '-1'
      end>
    ProviderName = 'dsvStoryComment'
    RemoteServer = DSProviderConnection
    Left = 602
    Top = 650
  end
  object DSvMyRecipeList: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsvRecipeList'
    RemoteServer = DSProviderConnection
    Left = 396
    Top = 580
  end
  object DSvMyBookmarkList: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'UserSerial'
        ParamType = ptUnknown
        Value = '-1'
      end>
    ProviderName = 'dsvBookmarkList'
    RemoteServer = DSProviderConnection
    Left = 276
    Top = 582
  end
  object DSStoryCount: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'StorySerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'DsStoryCount'
    RemoteServer = DSProviderConnection
    Left = 242
    Top = 158
  end
end
