object frmAddTemperature: TfrmAddTemperature
  Left = 0
  Top = 0
  Caption = #50728#46020
  ClientHeight = 150
  ClientWidth = 257
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
  object cxLabel5: TcxLabel
    Left = 50
    Top = 26
    Caption = #50728#46020
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
  object cxTemperature: TcxDBCurrencyEdit
    Left = 80
    Top = 22
    DataBinding.DataField = 'TemperatureValue'
    DataBinding.DataSource = frmRecipe.dsMethod
    Properties.AssignedValues.MinValue = True
    Properties.DecimalPlaces = 1
    Properties.DisplayFormat = ',0.;-,0.'
    Properties.EditFormat = '000.0'
    Properties.MaxValue = 999.000000000000000000
    Properties.UseDisplayFormatWhenEditing = True
    Properties.UseLeftAlignmentOnEditing = False
    Properties.OnValidate = cxTemperaturePropertiesValidate
    TabOrder = 1
    Width = 125
  end
  object btnCancel: TButton
    Left = 140
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnSave: TButton
    Left = 38
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 80
    Top = 53
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 4
    Width = 125
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
  object cxLabel1: TcxLabel
    Left = 206
    Top = 26
    Caption = #176'C'
    Transparent = True
  end
end
