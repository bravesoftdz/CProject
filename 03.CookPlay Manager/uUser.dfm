object frmUser: TfrmUser
  Left = 0
  Top = 0
  Caption = #49324#50857#51088
  ClientHeight = 507
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object imgUserPicture: TImage
    Left = 385
    Top = 28
    Width = 70
    Height = 70
    Stretch = True
  end
  object cxLabel1: TcxLabel
    Left = 41
    Top = 29
    Caption = '*Nickname'
    ParentFont = False
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -13
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clPurple
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel2: TcxLabel
    Left = 87
    Top = 68
    Caption = '*ID'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel3: TcxLabel
    Left = 49
    Top = 101
    Caption = 'Password'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel4: TcxLabel
    Left = 65
    Top = 139
    Caption = '*Name'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel5: TcxLabel
    Left = 50
    Top = 177
    Caption = '*National'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel6: TcxLabel
    Left = 51
    Top = 213
    Caption = '*Birthday'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel7: TcxLabel
    Left = 56
    Top = 249
    Caption = '*Gender'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel8: TcxLabel
    Left = 95
    Top = 285
    Caption = 'IP'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel9: TcxLabel
    Left = 69
    Top = 321
    Caption = '*Email'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxLabel10: TcxLabel
    Left = 32
    Top = 359
    Caption = 'Introduction'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 110
  end
  object cxDBCheckBox1: TcxDBCheckBox
    Left = 374
    Top = 138
    Caption = 'SSO'
    DataBinding.DataField = 'SSO'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 10
    Transparent = True
  end
  object cxLabel11: TcxLabel
    Left = 280
    Top = 177
    Caption = '*Created Date'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 368
  end
  object cxDBDateEdit1: TcxDBDateEdit
    Left = 374
    Top = 176
    DataBinding.DataField = 'CreatedDate'
    DataBinding.DataSource = dmDB.dsUsers
    Properties.Kind = ckDateTime
    TabOrder = 12
    Width = 175
  end
  object cxdbNickName: TcxDBTextEdit
    Left = 116
    Top = 28
    DataBinding.DataField = 'Nickname'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 13
    Width = 121
  end
  object cxDBTextEdit2: TcxDBTextEdit
    Left = 116
    Top = 64
    DataBinding.DataField = 'ID'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 14
    Width = 121
  end
  object cxDBTextEdit3: TcxDBTextEdit
    Left = 116
    Top = 100
    DataBinding.DataField = 'Pwd'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 15
    Width = 121
  end
  object cxDBTextEdit4: TcxDBTextEdit
    Left = 116
    Top = 138
    DataBinding.DataField = 'Name'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 16
    Width = 121
  end
  object cxDBTextEdit5: TcxDBTextEdit
    Left = 116
    Top = 176
    DataBinding.DataField = 'National'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 17
    Width = 121
  end
  object cxDBTextEdit7: TcxDBTextEdit
    Left = 116
    Top = 248
    DataBinding.DataField = 'Gender'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 18
    Width = 121
  end
  object cxDBTextEdit8: TcxDBTextEdit
    Left = 116
    Top = 284
    DataBinding.DataField = 'IP'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 19
    Width = 121
  end
  object cxDBTextEdit9: TcxDBTextEdit
    Left = 116
    Top = 320
    DataBinding.DataField = 'Email'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 20
    Width = 211
  end
  object cxDBMemo1: TcxDBMemo
    Left = 116
    Top = 359
    DataBinding.DataField = 'Introduction'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 21
    Height = 89
    Width = 185
  end
  object cxLabel12: TcxLabel
    Left = 247
    Top = 213
    Caption = '*Last Updated Date'
    Style.TextColor = clPurple
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 368
  end
  object cxDBDateEdit2: TcxDBDateEdit
    Left = 374
    Top = 212
    DataBinding.DataField = 'LastUpdatedDate'
    DataBinding.DataSource = dmDB.dsUsers
    Properties.Kind = ckDateTime
    TabOrder = 23
    Width = 175
  end
  object cxDBDateEdit3: TcxDBDateEdit
    Left = 374
    Top = 248
    DataBinding.DataField = 'WithdrawalDate'
    DataBinding.DataSource = dmDB.dsUsers
    Properties.Kind = ckDateTime
    TabOrder = 24
    Width = 173
  end
  object cxLabel13: TcxLabel
    Left = 270
    Top = 249
    Caption = 'WithdrawalDate'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 368
  end
  object cxDBCheckBox2: TcxDBCheckBox
    Left = 374
    Top = 284
    Caption = 'Withdrawal'
    DataBinding.DataField = 'Withdrawal'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 26
    Transparent = True
  end
  object cxLabel14: TcxLabel
    Left = 335
    Top = 321
    Caption = 'Level'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 368
  end
  object cxDBLookupComboBox1: TcxDBLookupComboBox
    Left = 374
    Top = 320
    DataBinding.DataField = 'Level'
    DataBinding.DataSource = dmDB.dsUsers
    Properties.KeyFieldNames = 'ItemCode'
    Properties.ListColumns = <
      item
        FieldName = 'ItemName'
      end>
    Properties.ListSource = dmDB.dsCategoryUserlevel
    TabOrder = 28
    Width = 145
  end
  object cxDBCheckBox3: TcxDBCheckBox
    Left = 374
    Top = 359
    Caption = 'Deleted'
    DataBinding.DataField = 'Deleted'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 29
    Transparent = True
  end
  object btnSave: TButton
    Left = 650
    Top = 50
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 30
    OnClick = btnSaveClick
  end
  object Button2: TButton
    Left = 650
    Top = 84
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 31
    OnClick = Button2Click
  end
  object cxDBDateEdit4: TcxDBDateEdit
    Left = 116
    Top = 212
    DataBinding.DataField = 'Birthday'
    DataBinding.DataSource = dmDB.dsUsers
    TabOrder = 32
    Width = 121
  end
  object btnLoadUserPicture: TButton
    Left = 474
    Top = 28
    Width = 111
    Height = 25
    Caption = #49324#51652' '#48520#47084#50724#44592
    TabOrder = 33
    OnClick = btnLoadUserPictureClick
  end
  object btnClearUserPicture: TButton
    Left = 474
    Top = 59
    Width = 111
    Height = 25
    Caption = 'Clear'
    TabOrder = 34
    OnClick = btnClearUserPictureClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.png;*.jpg;*.jpeg;*.gif;*.tif;*.tiff;*.gif;*.png;*.jpg;*.j' +
      'peg;*.bmp;*.jpg;*.jpeg;*.gif)|*.png;*.jpg;*.jpeg;*.gif;*.tif;*.t' +
      'iff;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.jpg;*.jpeg'
    Left = 612
    Top = 304
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 270
    Top = 38
  end
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 618
    Top = 202
  end
end
