object frmAddTime: TfrmAddTime
  Left = 0
  Top = 0
  Caption = #49884#44036
  ClientHeight = 210
  ClientWidth = 254
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
  object btnSave: TButton
    Left = 38
    Top = 148
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 140
    Top = 148
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object cxLabel8: TcxLabel
    Left = 50
    Top = 96
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
  object cxTime: TcxTimeEdit
    Left = 80
    Top = 22
    TabOrder = 4
    Width = 121
  end
  object cxDBSpinEdit1: TcxDBSpinEdit
    Left = 80
    Top = 95
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 5
    Width = 121
  end
  object cxLabel1: TcxLabel
    Left = 50
    Top = 57
    Caption = #49444#47749
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
  object cxTitle: TcxTextEdit
    Left = 80
    Top = 56
    TabOrder = 7
    Text = 'cxTitle'
    Width = 121
  end
end
