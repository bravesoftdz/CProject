object frmMethodSelectIngredient: TfrmMethodSelectIngredient
  Left = 0
  Top = 0
  Caption = #51116#47308#49440#53469
  ClientHeight = 143
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object cxLabel7: TcxLabel
    Left = 42
    Top = 23
    Caption = #51116#47308#49440#53469
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
  object btnSave: TButton
    Left = 130
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object Button2: TButton
    Left = 270
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
  object cxDBLookupComboBox1: TcxDBLookupComboBox
    Left = 104
    Top = 20
    DataBinding.DataField = 'RecipeIngredient_Serial'
    DataBinding.DataSource = frmRecipe.dsMethod
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'Serial'
    Properties.ListColumns = <
      item
        FieldName = 'Title'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsIngredient
    TabOrder = 3
    Width = 343
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 104
    Top = 51
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 4
    Width = 109
  end
  object cxLabel8: TcxLabel
    Left = 70
    Top = 55
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
    AnchorX = 100
  end
  object memIngredient: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 146
    Top = 2
    object memIngredientSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memIngredientRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memIngredientLinkedRecipe: TLargeintField
      FieldName = 'LinkedRecipe'
    end
    object memIngredientSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memIngredientIngredientType: TSmallintField
      FieldName = 'IngredientType'
    end
    object memIngredientTitle: TWideStringField
      FieldName = 'Title'
      Size = 100
    end
    object memIngredientAmount: TWideStringField
      FieldName = 'Amount'
      Size = 50
    end
    object memIngredientUnit: TWideStringField
      FieldName = 'Unit'
      Size = 50
    end
    object memIngredientWeightType: TSmallintField
      FieldName = 'WeightType'
    end
    object memIngredientWeight: TIntegerField
      FieldName = 'Weight'
    end
    object memIngredientPictureType: TSmallintField
      FieldName = 'PictureType'
    end
    object memIngredientPicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memIngredientPictureRectangle: TWideStringField
      FieldName = 'PictureRectangle'
      Size = 200
    end
    object memIngredientPictureSquare: TWideStringField
      FieldName = 'PictureSquare'
      Size = 200
    end
    object memIngredientContents: TWideStringField
      FieldName = 'Contents'
      Size = 1000
    end
  end
  object dsIngredient: TDataSource
    DataSet = memIngredient
    Left = 306
    Top = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 40
    Top = 84
  end
end
