object frmRecipe: TfrmRecipe
  Left = 0
  Top = 0
  Caption = 'Recipe'
  ClientHeight = 667
  ClientWidth = 1083
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1083
    Height = 306
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel1: TBevel
      Left = 422
      Top = 90
      Width = 101
      Height = 107
    end
    object imgRecipeSquare: TImage
      Left = 430
      Top = 102
      Width = 85
      Height = 85
      Stretch = True
    end
    object cxLabel1: TcxLabel
      Left = 56
      Top = 25
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
      AnchorX = 90
    end
    object cxLabel2: TcxLabel
      Left = 19
      Top = 90
      Caption = 'Description'
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 90
    end
    object btnLoadImage: TButton
      Left = 529
      Top = 127
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 2
      OnClick = btnLoadImageClick
    end
    object cxLabel5: TcxLabel
      Left = 31
      Top = 216
      Caption = 'Category'
      Style.TextColor = clRed
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 88
    end
    object btnClearImage: TButton
      Left = 529
      Top = 162
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 4
      OnClick = btnClearImageClick
    end
    object btnSave: TButton
      Left = 714
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 5
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 714
      Top = 118
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 6
      OnClick = btnCancelClick
    end
    object cxLabel3: TcxLabel
      Left = 58
      Top = 270
      Caption = #51064#48516
      Style.TextColor = clRed
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 88
    end
    object cxLabel4: TcxLabel
      Left = 251
      Top = 272
      Caption = #45212#51060#46020
      Style.TextColor = clRed
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 294
    end
    object cxLabel6: TcxLabel
      Left = 443
      Top = 272
      Caption = #50836#47532#49884#44036
      Style.TextColor = clRed
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 499
    end
    object cxMemoDescription: TcxMemo
      Left = 96
      Top = 89
      Lines.Strings = (
        'cxMemoDescription')
      Properties.MaxLength = 1000
      TabOrder = 10
      Height = 120
      Width = 317
    end
    object cxSpinServings: TcxSpinEdit
      Left = 96
      Top = 269
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 11
      Value = 1
      Width = 120
    end
    object cxcboMakingLevel: TcxLookupComboBox
      Left = 293
      Top = 269
      Properties.DropDownRows = 20
      Properties.KeyFieldNames = 'CategoryCode'
      Properties.ListColumns = <
        item
          FieldName = 'CategoryName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsMakingLevel
      TabOrder = 12
      Width = 120
    end
    object cxcboMakingTime: TcxLookupComboBox
      Left = 502
      Top = 269
      Properties.DropDownRows = 20
      Properties.KeyFieldNames = 'CategoryCode'
      Properties.ListColumns = <
        item
          FieldName = 'CategoryName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsMakingTime
      TabOrder = 13
      Width = 120
    end
    object cxchkPublished: TcxCheckBox
      Left = 714
      Top = 46
      Caption = 'Published'
      TabOrder = 14
      Transparent = True
    end
    object cxTxtTitle: TcxTextEdit
      Left = 96
      Top = 24
      Properties.MaxLength = 100
      TabOrder = 15
      Text = 'cxTxtTitle'
      Width = 526
    end
    object cxLabel7: TcxLabel
      Left = 20
      Top = 56
      Caption = 'Hash code'
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
      AnchorX = 88
    end
    object cxtxtHashcode: TcxTextEdit
      Left = 96
      Top = 55
      Properties.MaxLength = 200
      TabOrder = 17
      Text = 'cxTxtTitle'
      Width = 526
    end
    object cxcbo0: TcxCheckComboBox
      Left = 96
      Top = 212
      Properties.DropDownRows = 20
      Properties.Items = <
        item
          Description = 'safdsadf'
        end
        item
          Description = 'asdfa'
        end
        item
          Description = '12341234'
        end>
      Properties.OnChange = cxcbo0PropertiesChange
      Properties.OnClickCheck = cxcbo0PropertiesClickCheck
      TabOrder = 18
      Width = 155
    end
    object cxcbo1: TcxCheckComboBox
      Left = 258
      Top = 212
      Properties.DropDownRows = 20
      Properties.Items = <
        item
          Description = 'safdsadf'
        end
        item
          Description = 'asdfa'
        end
        item
          Description = '12341234'
        end>
      Properties.OnChange = cxcbo0PropertiesChange
      Properties.OnClickCheck = cxcbo0PropertiesClickCheck
      TabOrder = 19
      Width = 155
    end
    object cxcbo2: TcxCheckComboBox
      Left = 419
      Top = 212
      Properties.DropDownRows = 20
      Properties.Items = <
        item
          Description = 'safdsadf'
        end
        item
          Description = 'asdfa'
        end
        item
          Description = '12341234'
        end>
      Properties.OnChange = cxcbo0PropertiesChange
      Properties.OnClickCheck = cxcbo0PropertiesClickCheck
      TabOrder = 20
      Width = 155
    end
    object cxcbo3: TcxCheckComboBox
      Left = 580
      Top = 212
      Properties.DropDownRows = 20
      Properties.Items = <
        item
          Description = 'safdsadf'
        end
        item
          Description = 'asdfa'
        end
        item
          Description = '12341234'
        end>
      Properties.OnChange = cxcbo0PropertiesChange
      Properties.OnClickCheck = cxcbo0PropertiesClickCheck
      TabOrder = 21
      Width = 155
    end
    object cxtxtCategory: TcxTextEdit
      Left = 96
      Top = 238
      Properties.ReadOnly = True
      Style.TextColor = clGrayText
      TabOrder = 22
      Text = 'cxtxtCategory'
      Width = 639
    end
    object cxtxtCategoryTag: TcxTextEdit
      Left = 270
      Top = 243
      Properties.ReadOnly = True
      Style.TextColor = clGrayText
      TabOrder = 23
      Text = 'cxtxtCategoryTag'
      Visible = False
      Width = 639
    end
    object deleteRecipe: TButton
      Left = 636
      Top = 162
      Width = 153
      Height = 25
      Caption = 'Real - Delete Recipe'
      TabOrder = 24
      OnClick = deleteRecipeClick
    end
    object cxchkDeleted: TcxCheckBox
      Left = 714
      Top = 19
      Caption = 'Deleted'
      TabOrder = 25
      Transparent = True
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 306
    Width = 1083
    Height = 361
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 3
    Padding.Right = 3
    TabOrder = 1
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 10
      Top = 40
      Width = 1063
      Height = 314
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      Align = alClient
      TabOrder = 0
      object cxGMethod: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGMethodCustomDrawCell
        DataController.DataSource = dsMethod
        DataController.KeyFieldNames = 'Serial'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        EditForm.DefaultColumnCount = 4
        EditForm.DefaultStretch = fsHorizontal
        OptionsBehavior.EditAutoHeight = eahRow
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.ExpandButtonsForEmptyDetails = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.Indicator = True
        object cxGMethodRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object cxGMethodSerial: TcxGridDBColumn
          DataBinding.FieldName = 'Serial'
        end
        object cxGMethodRecipe_Serial: TcxGridDBColumn
          DataBinding.FieldName = 'Recipe_Serial'
          Visible = False
        end
        object cxGMethodMethodType: TcxGridDBColumn
          DataBinding.FieldName = 'MethodType'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'CategoryCode'
          Properties.ListColumns = <
            item
              FieldName = 'CategoryName'
            end>
          Properties.ListSource = dmDB.dsMethodType
          Width = 130
        end
        object cxGMethodStepSeq: TcxGridDBColumn
          DataBinding.FieldName = 'StepSeq'
          Width = 76
        end
        object cxGMethodSeq: TcxGridDBColumn
          DataBinding.FieldName = 'Seq'
          Width = 70
        end
        object cxGMethodDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 756
        end
        object cxGMethodPictureType: TcxGridDBColumn
          DataBinding.FieldName = 'PictureType'
          Visible = False
        end
        object cxGMethodPicture: TcxGridDBColumn
          DataBinding.FieldName = 'Picture'
          Visible = False
        end
        object cxGMethodPictureRectangle: TcxGridDBColumn
          DataBinding.FieldName = 'PictureRectangle'
          Visible = False
        end
        object cxGMethodPictureSquare: TcxGridDBColumn
          DataBinding.FieldName = 'PictureSquare'
          Visible = False
        end
        object cxGMethodNewPicture: TcxGridDBColumn
          DataBinding.FieldName = 'NewPicture'
          Visible = False
        end
        object cxGMethodPictureState: TcxGridDBColumn
          DataBinding.FieldName = 'PictureState'
          Visible = False
        end
        object cxGMethodStateBefore: TcxGridDBColumn
          DataBinding.FieldName = 'StateBefore'
          Visible = False
          Width = 245
        end
        object cxGMethodStateCur: TcxGridDBColumn
          DataBinding.FieldName = 'StateCur'
          Visible = False
          Width = 128
        end
      end
      object cxGIngredient: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGIngredientCustomDrawCell
        DataController.DataSource = dsIngredient
        DataController.DetailKeyFieldNames = 'RecipeMethod_Serial'
        DataController.KeyFieldNames = 'Serial'
        DataController.MasterKeyFieldNames = 'Serial'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGIngredientRecipeMethod_Serial: TcxGridDBColumn
          DataBinding.FieldName = 'RecipeMethod_Serial'
        end
        object cxGIngredientItemType: TcxGridDBColumn
          DataBinding.FieldName = 'ItemType'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'CategoryCode'
          Properties.ListColumns = <
            item
              FieldName = 'CategoryName'
            end>
          Properties.ListSource = dmDB.dsItemType
        end
        object cxGIngredientTitle: TcxGridDBColumn
          DataBinding.FieldName = 'Title'
          Width = 300
        end
        object cxGIngredientAmount: TcxGridDBColumn
          DataBinding.FieldName = 'Amount'
          Width = 50
        end
        object cxGIngredientUnit: TcxGridDBColumn
          DataBinding.FieldName = 'Unit'
          Width = 50
        end
        object cxGIngredientRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object cxGIngredientSeq: TcxGridDBColumn
          DataBinding.FieldName = 'Seq'
          SortIndex = 0
          SortOrder = soAscending
        end
        object cxGIngredientItemWeightValue: TcxGridDBColumn
          DataBinding.FieldName = 'ItemWeightValue'
        end
        object cxGIngredientItemTimeValue: TcxGridDBColumn
          DataBinding.FieldName = 'ItemTimeValue'
        end
        object cxGIngredientItemTemperatureValue: TcxGridDBColumn
          DataBinding.FieldName = 'ItemTemperatureValue'
        end
        object cxGIngredientItemUnit: TcxGridDBColumn
          DataBinding.FieldName = 'ItemUnit'
          Visible = False
        end
        object cxGIngredientLinkedRecipe: TcxGridDBColumn
          DataBinding.FieldName = 'LinkedRecipe'
        end
        object cxGIngredientSerial: TcxGridDBColumn
          DataBinding.FieldName = 'Serial'
          Visible = False
        end
        object cxGIngredientRecipe_Serial: TcxGridDBColumn
          DataBinding.FieldName = 'Recipe_Serial'
          Visible = False
        end
        object cxGIngredientNewPicture: TcxGridDBColumn
          DataBinding.FieldName = 'NewPicture'
          Visible = False
        end
        object cxGIngredientPictureState: TcxGridDBColumn
          DataBinding.FieldName = 'PictureState'
          Visible = False
        end
        object cxGIngredientStateBefore: TcxGridDBColumn
          DataBinding.FieldName = 'StateBefore'
          Visible = False
        end
        object cxGIngredientStateCur: TcxGridDBColumn
          DataBinding.FieldName = 'StateCur'
          Visible = False
        end
        object cxGIngredientUsed: TcxGridDBColumn
          DataBinding.FieldName = 'Used'
          Visible = False
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGMethod
        Options.DetailTabsPosition = dtpTop
        object cxGrid1Level1: TcxGridLevel
          Caption = #51116#47308','#50728#46020','#49884#44036
          GridView = cxGIngredient
          Options.DetailTabsPosition = dtpTop
        end
      end
    end
    object Panel3: TPanel
      Left = 3
      Top = 0
      Width = 1077
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object btnEditStep: TButton
        Left = 173
        Top = 6
        Width = 75
        Height = 25
        Caption = #49688#51221
        TabOrder = 0
        OnClick = btnEditStepClick
      end
      object btnDeleteStep: TButton
        Left = 254
        Top = 6
        Width = 75
        Height = 25
        Caption = #49325#51228
        TabOrder = 1
        OnClick = btnDeleteStepClick
      end
      object btnAddStep: TButton
        Left = 11
        Top = 6
        Width = 75
        Height = 25
        Caption = 'STEP '#52628#44032
        TabOrder = 2
        OnClick = btnAddStepClick
      end
      object btnAddIngredient: TButton
        Left = 360
        Top = 6
        Width = 75
        Height = 25
        Caption = #51116#47308#52628#44032
        TabOrder = 3
        OnClick = btnAddIngredientClick
      end
      object btnAddTime: TButton
        Left = 441
        Top = 6
        Width = 75
        Height = 25
        Caption = #49884#44036#52628#44032
        TabOrder = 4
        OnClick = btnAddIngredientClick
      end
      object btnAddTemperature: TButton
        Left = 522
        Top = 6
        Width = 75
        Height = 25
        Caption = #50728#46020#52628#44032
        TabOrder = 5
        OnClick = btnAddIngredientClick
      end
      object btnEditIngredient: TButton
        Left = 609
        Top = 6
        Width = 75
        Height = 25
        Caption = #49688#51221
        TabOrder = 6
        OnClick = btnEditIngredientClick
      end
      object btnDeleteIngredient: TButton
        Left = 690
        Top = 6
        Width = 75
        Height = 25
        Caption = #49325#51228
        TabOrder = 7
        OnClick = btnDeleteIngredientClick
      end
      object btnAddPicture: TButton
        Left = 92
        Top = 6
        Width = 75
        Height = 25
        Caption = #49324#51652#52628#44032
        Enabled = False
        TabOrder = 8
        OnClick = btnAddStepClick
      end
    end
  end
  object dsRecipe: TDataSource
    DataSet = memRecipe
    Left = 236
    Top = 382
  end
  object dsIngredient: TDataSource
    DataSet = memIngredient
    Left = 240
    Top = 494
  end
  object dsMethod: TDataSource
    DataSet = memMethod
    Left = 238
    Top = 438
  end
  object memRecipe: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    Left = 158
    Top = 382
    object memRecipeSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memRecipeUsers_Serial: TLargeintField
      FieldName = 'Users_Serial'
    end
    object memRecipeTitle: TWideStringField
      FieldName = 'Title'
      Size = 100
    end
    object memRecipeDescription: TWideStringField
      FieldName = 'Description'
      Size = 1000
    end
    object memRecipePictureType: TWideStringField
      FieldName = 'PictureType'
      Size = 100
    end
    object memRecipePicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memRecipePictureSquare: TWideStringField
      FieldName = 'PictureSquare'
      Size = 200
    end
    object memRecipePictureRectangle: TWideStringField
      FieldName = 'PictureRectangle'
      Size = 200
    end
    object memRecipeCategory: TWideStringField
      FieldName = 'Category'
      Size = 200
    end
    object memRecipeMakingLevel: TSmallintField
      FieldName = 'MakingLevel'
    end
    object memRecipeMakingTime: TSmallintField
      FieldName = 'MakingTime'
    end
    object memRecipeServings: TSmallintField
      FieldName = 'Servings'
    end
    object memRecipeHashcode: TWideStringField
      FieldName = 'Hashcode'
      Size = 200
    end
    object memRecipeCreatedDate: TDateTimeField
      FieldName = 'CreatedDate'
    end
    object memRecipeUpdatedDate: TDateTimeField
      FieldName = 'UpdatedDate'
    end
    object memRecipePublished: TBooleanField
      FieldName = 'Published'
    end
    object memRecipeDeleted: TBooleanField
      FieldName = 'Deleted'
    end
    object memRecipeNewPicture: TStringField
      FieldName = 'NewPicture'
      Size = 200
    end
    object memRecipePictureState: TStringField
      FieldName = 'PictureState'
    end
    object memRecipeStateCur: TStringField
      FieldName = 'StateCur'
    end
    object memRecipeStateBefore: TStringField
      FieldName = 'StateBefore'
    end
  end
  object memIngredient: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    SortedField = 'RecipeMethod_Serial'
    Left = 160
    Top = 502
    object memIngredientSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memIngredientRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memIngredientRecipeMethod_Serial: TLargeintField
      FieldName = 'RecipeMethod_Serial'
    end
    object memIngredientLinkedRecipe: TLargeintField
      FieldName = 'LinkedRecipe'
    end
    object memIngredientSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memIngredientItemType: TSmallintField
      FieldName = 'ItemType'
    end
    object memIngredientItemWeightValue: TIntegerField
      FieldName = 'ItemWeightValue'
    end
    object memIngredientItemTimeValue: TWideStringField
      FieldName = 'ItemTimeValue'
      Size = 8
    end
    object memIngredientItemTemperatureValue: TBCDField
      FieldName = 'ItemTemperatureValue'
    end
    object memIngredientItemUnit: TSmallintField
      FieldName = 'ItemUnit'
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
    object memIngredientNewPicture: TStringField
      FieldName = 'NewPicture'
      Size = 200
    end
    object memIngredientPictureState: TStringField
      FieldName = 'PictureState'
    end
    object memIngredientStateCur: TStringField
      FieldName = 'StateCur'
    end
    object memIngredientStateBefore: TStringField
      FieldName = 'StateBefore'
    end
  end
  object memMethod: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    SortedField = 'Seq'
    Left = 162
    Top = 442
    object memMethodSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMethodRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memMethodMethodType: TSmallintField
      FieldName = 'MethodType'
    end
    object memMethodPictureType: TSmallintField
      FieldName = 'PictureType'
    end
    object memMethodPicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memMethodPictureRectangle: TWideStringField
      FieldName = 'PictureRectangle'
      Size = 200
    end
    object memMethodPictureSquare: TWideStringField
      FieldName = 'PictureSquare'
      Size = 200
    end
    object memMethodDescription: TWideStringField
      FieldName = 'Description'
      Size = 1000
    end
    object memMethodSeq: TSmallintField
      FieldName = 'Seq'
    end
    object memMethodStepSeq: TSmallintField
      FieldName = 'StepSeq'
    end
    object memMethodNewPicture: TStringField
      FieldName = 'NewPicture'
      Size = 200
    end
    object memMethodPictureState: TStringField
      FieldName = 'PictureState'
    end
    object memMethodStateCur: TStringField
      FieldName = 'StateCur'
    end
    object memMethodStateBefore: TStringField
      FieldName = 'StateBefore'
    end
  end
  object sqlTemp: TFDQuery
    Connection = dmDB.FDConnection
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSeri' +
        'al ORDER BY Seq')
    Left = 156
    Top = 588
    ParamData = <
      item
        Name = 'RecipeSerial'
        ParamType = ptInput
      end>
  end
end
