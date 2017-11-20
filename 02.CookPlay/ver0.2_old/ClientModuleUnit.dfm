object CM: TCM
  OldCreateOrder = False
  Height = 642
  Width = 415
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
    Left = 40
    Top = 20
  end
  object DSFindUser: TClientDataSet
    Active = True
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
    Left = 42
    Top = 90
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection
    Left = 134
    Top = 20
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
    Left = 134
    Top = 88
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
  object DSCount: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftLargeint
        Name = 'UserSerial'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsCount'
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
    Left = 136
    Top = 220
  end
end
