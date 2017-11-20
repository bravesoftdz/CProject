object frmAddTime: TfrmAddTime
  Left = 0
  Top = 0
  Caption = #49884#44036
  ClientHeight = 170
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 17
  object cxLabel4: TcxLabel
    Left = 50
    Top = 23
    Caption = #49884#44036
    ParentFont = False
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -13
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 80
  end
  object cxTime: TcxDBTimeEdit
    Left = 80
    Top = 22
    DataBinding.DataField = 'TimeValue'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 1
    Width = 121
  end
  object btnSave: TButton
    Left = 32
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 134
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object cxLabel8: TcxLabel
    Left = 50
    Top = 54
    Caption = #49692#49436
    ParentFont = False
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -13
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 80
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 80
    Top = 53
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 5
    Width = 121
  end
end
