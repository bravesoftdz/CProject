object frmIngredient: TfrmIngredient
  Left = 0
  Top = 0
  Caption = #51116#47308
  ClientHeight = 354
  ClientWidth = 654
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
  object imgSquare: TImage
    Left = 421
    Top = 178
    Width = 85
    Height = 85
    Stretch = True
  end
  object btnSave: TButton
    Left = 552
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 552
    Top = 74
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cxDBLookupComboBox1: TcxDBLookupComboBox
    Left = 102
    Top = 21
    DataBinding.DataField = 'IngredientType'
    DataBinding.DataSource = frmRecipe.dsIngredient
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'CategoryCode'
    Properties.ListColumns = <
      item
        FieldName = 'CategoryName'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dmDB.dsIngredientType
    TabOrder = 2
    Width = 145
  end
  object cxLabel7: TcxLabel
    Left = 44
    Top = 23
    Caption = #51116#47308#51333#47448
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
    AnchorX = 100
  end
  object cxLabel1: TcxLabel
    Left = 66
    Top = 49
    Caption = '*Title'
    ParentFont = False
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -13
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = 8388863
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 100
  end
  object cxLabel2: TcxLabel
    Left = 57
    Top = 109
    Caption = #49324#50857#47049
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
    AnchorX = 100
  end
  object cxLabel3: TcxLabel
    Left = 226
    Top = 109
    Caption = #45800#50948
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
    AnchorX = 256
  end
  object cxTitle: TcxDBTextEdit
    Left = 102
    Top = 48
    DataBinding.DataField = 'Title'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 7
    Width = 301
  end
  object cxDBTextEdit2: TcxDBTextEdit
    Left = 102
    Top = 108
    DataBinding.DataField = 'Amount'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 8
    Width = 89
  end
  object cxDBTextEdit3: TcxDBTextEdit
    Left = 258
    Top = 108
    DataBinding.DataField = 'Unit'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 9
    Width = 145
  end
  object cxDBSpinEdit1: TcxDBSpinEdit
    Left = 102
    Top = 139
    DataBinding.DataField = 'Weight'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 10
    Width = 89
  end
  object cxLabel4: TcxLabel
    Left = 70
    Top = 140
    Caption = #47924#44172
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
    AnchorX = 100
  end
  object cxLabel5: TcxLabel
    Left = 194
    Top = 143
    Caption = 'g'
    Transparent = True
  end
  object btnLoadImage: TButton
    Left = 421
    Top = 269
    Width = 85
    Height = 25
    Caption = 'Load Image'
    TabOrder = 13
    OnClick = btnLoadImageClick
  end
  object btnClearImage: TButton
    Left = 421
    Top = 300
    Width = 85
    Height = 25
    Caption = 'Clear Image'
    TabOrder = 14
    OnClick = btnClearImageClick
  end
  object cxLabel6: TcxLabel
    Left = 70
    Top = 176
    Caption = #47924#44172
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
    AnchorX = 100
  end
  object cxDBMemo1: TcxDBMemo
    Left = 102
    Top = 170
    DataBinding.DataField = 'Contents'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 16
    Height = 155
    Width = 301
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 258
    Top = 139
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsIngredient
    TabOrder = 17
    Width = 109
  end
  object cxLabel8: TcxLabel
    Left = 224
    Top = 140
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
    AnchorX = 254
  end
  object cxLabel9: TcxLabel
    Left = 11
    Top = 78
    Caption = 'Linked Recipe'
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
    AnchorX = 98
  end
  object btnClearLink: TButton
    Left = 414
    Top = 50
    Width = 85
    Height = 25
    Caption = 'Clear Link'
    TabOrder = 20
    OnClick = btnClearLinkClick
  end
  object cxcboLinkedRecipe: TcxDBLookupComboBox
    Left = 102
    Top = 77
    DataBinding.DataField = 'LinkedRecipe'
    DataBinding.DataSource = frmRecipe.dsIngredient
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'Serial'
    Properties.ListColumns = <
      item
        FieldName = 'Title'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dmDB.dsMyRecipe
    Properties.ReadOnly = False
    Properties.OnChange = cxcboLinkedRecipePropertiesChange
    TabOrder = 21
    Width = 301
  end
end
