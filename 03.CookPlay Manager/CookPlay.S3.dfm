object dmS3: TdmS3
  OldCreateOrder = False
  Height = 215
  Width = 301
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
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 
      'All (*.png;*.jpg;*.jpeg;*.gif;*.tif;*.tiff;*.gif;*.png;*.jpg;*.j' +
      'peg;*.bmp;*.jpg;*.jpeg;*.gif)|*.png;*.jpg;*.jpeg;*.gif;*.tif;*.t' +
      'iff;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.jpg;*.jpeg'
    Left = 59
    Top = 87
  end
end
