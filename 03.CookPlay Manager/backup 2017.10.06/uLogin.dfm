object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #47196#44536#51064
  ClientHeight = 99
  ClientWidth = 370
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
  object cxLabel1: TcxLabel
    Left = 85
    Top = 20
    Caption = 'ID'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 102
  end
  object cxLabel2: TcxLabel
    Left = 41
    Top = 52
    Caption = 'Password'
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 102
  end
  object cxID: TcxTextEdit
    Left = 104
    Top = 16
    TabOrder = 2
    Text = 'cxID'
    Width = 121
  end
  object cxPassword: TcxTextEdit
    Left = 104
    Top = 51
    Properties.EchoMode = eemPassword
    Properties.PasswordChar = '*'
    TabOrder = 3
    Text = 'cxTextEdit1'
    OnKeyDown = cxPasswordKeyDown
    Width = 121
  end
  object btnLogin: TButton
    Left = 252
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 4
    OnClick = btnLoginClick
  end
  object Button2: TButton
    Left = 252
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 5
    OnClick = Button2Click
  end
end
