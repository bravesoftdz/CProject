object frmSetup: TfrmSetup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Database '#49444#51221
  ClientHeight = 341
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 30
    Width = 59
    Height = 13
    Caption = 'Driver Name'
  end
  object edtServer: TLabeledEdit
    Left = 24
    Top = 98
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Server'
    TabOrder = 0
    Text = 'db2.cookplay.net'
  end
  object edtUserID: TLabeledEdit
    Left = 24
    Top = 194
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'userID'
    TabOrder = 1
    Text = 'root'
  end
  object edtPassword: TLabeledEdit
    Left = 24
    Top = 244
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 2
    Text = 'cookpassword'
  end
  object edtPort: TLabeledEdit
    Left = 24
    Top = 294
    Width = 121
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'Port'
    NumbersOnly = True
    TabOrder = 3
    Text = '3306'
  end
  object btnSave: TButton
    Left = 192
    Top = 49
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 192
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 5
    OnClick = btnCloseClick
  end
  object edtDatabase: TLabeledEdit
    Left = 24
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Database'
    TabOrder = 6
    Text = 'cookplay'
  end
  object cboDrivername: TComboBox
    Left = 24
    Top = 46
    Width = 121
    Height = 21
    Style = csDropDownList
    DropDownCount = 2
    ItemIndex = 0
    TabOrder = 7
    Text = 'MySQL'
    Items.Strings = (
      'MySQL'
      'MSSQL')
  end
end
