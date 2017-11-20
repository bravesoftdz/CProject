object dmS3: TdmS3
  OldCreateOrder = False
  Height = 283
  Width = 393
  object AmazonConnectionInfo: TAmazonConnectionInfo
    AccountName = 'AKIAJWOBLS6AE22TOJ5Q'
    AccountKey = 'eAH5RV/Uiptek941wGhJTPU9RXoTbcc3CengOOIT'
    Protocol = 'https'
    TableEndpoint = 'sdb.amazonaws.com'
    QueueEndpoint = 'queue.amazonaws.com'
    StorageEndpoint = 's3.amazonaws.com'
    Left = 62
    Top = 24
  end
  object NetHTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 183
    Top = 23
  end
end
