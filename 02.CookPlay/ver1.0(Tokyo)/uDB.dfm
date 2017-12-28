object DM: TDM
  OldCreateOrder = False
  Height = 461
  Width = 776
  object SQLCon_DS: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=test.cookplay.net'
      'Port=212'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 44
    Top = 38
    UniqueId = '{29F1C009-4AB5-4490-83EA-A57F15DD90CC}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods'
    SQLConnection = SQLCon_DS
    Left = 168
    Top = 38
  end
end
