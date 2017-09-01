object frmRecipe: TfrmRecipe
  Left = 0
  Top = 0
  Caption = 'Recipe'
  ClientHeight = 637
  ClientWidth = 826
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
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 223
    Width = 826
    Height = 414
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 407
    ClientRectLeft = 4
    ClientRectRight = 819
    ClientRectTop = 31
    object cxTabSheet1: TcxTabSheet
      Caption = #51116#47308
      ImageIndex = 0
    end
    object cxTabSheet2: TcxTabSheet
      Caption = #48169#48277
      ImageIndex = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 223
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object imgRecipeOrigin: TImage
      Left = 557
      Top = 53
      Width = 56
      Height = 46
      Stretch = True
    end
    object imgRecipeSquare: TImage
      Left = 421
      Top = 55
      Width = 85
      Height = 85
      Stretch = True
    end
    object imgRecipeRectangle: TImage
      Left = 619
      Top = 53
      Width = 80
      Height = 60
      Stretch = True
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 96
      Top = 24
      DataBinding.DataField = 'Title'
      DataBinding.DataSource = dsRecipe
      TabOrder = 0
      Width = 526
    end
    object cxLabel1: TcxLabel
      Left = 62
      Top = 25
      Caption = 'Title'
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 90
    end
    object cxLabel2: TcxLabel
      Left = 19
      Top = 56
      Caption = 'Description'
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 90
    end
    object cxDBMemo1: TcxDBMemo
      Left = 96
      Top = 55
      DataBinding.DataField = 'Description'
      DataBinding.DataSource = dsRecipe
      TabOrder = 3
      Height = 120
      Width = 319
    end
    object Button1: TButton
      Left = 547
      Top = 115
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 4
      OnClick = Button1Click
    end
    object cxDBLookupComboBox2: TcxDBLookupComboBox
      Left = 94
      Top = 181
      DataBinding.DataField = 'ItemCode0'
      DataBinding.DataSource = dsRecipe
      ParentShowHint = False
      Properties.DropDownRows = 15
      Properties.KeyFieldNames = 'ItemCode'
      Properties.ListColumns = <
        item
          FieldName = 'ItemName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsCategoryRecipe0
      ShowHint = False
      TabOrder = 5
      Width = 120
    end
    object cxLabel5: TcxLabel
      Left = 31
      Top = 182
      Caption = 'Category'
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 88
    end
    object cxDBLookupComboBox3: TcxDBLookupComboBox
      Left = 228
      Top = 181
      DataBinding.DataField = 'ItemCode1'
      DataBinding.DataSource = dsRecipe
      Properties.DropDownRows = 15
      Properties.KeyFieldNames = 'ItemCode'
      Properties.ListColumns = <
        item
          FieldName = 'ItemName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsCategoryRecipe1
      TabOrder = 7
      Width = 120
    end
    object cxDBLookupComboBox4: TcxDBLookupComboBox
      Left = 368
      Top = 181
      DataBinding.DataField = 'ItemCode2'
      DataBinding.DataSource = dsRecipe
      Properties.DropDownRows = 15
      Properties.KeyFieldNames = 'ItemCode'
      Properties.ListColumns = <
        item
          FieldName = 'ItemName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsCategoryRecipe2
      TabOrder = 8
      Width = 120
    end
    object cxDBLookupComboBox5: TcxDBLookupComboBox
      Left = 502
      Top = 181
      DataBinding.DataField = 'ItemCode3'
      DataBinding.DataSource = dsRecipe
      Properties.DropDownRows = 15
      Properties.KeyFieldNames = 'ItemCode'
      Properties.ListColumns = <
        item
          FieldName = 'ItemName'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.dsCategoryRecipe3
      TabOrder = 9
      Width = 120
    end
    object Button2: TButton
      Left = 547
      Top = 150
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 10
    end
    object btnSave: TButton
      Left = 714
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 11
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 714
      Top = 118
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 12
      OnClick = btnCancelClick
    end
    object cxLabel3: TcxLabel
      Left = 658
      Top = 182
      Caption = #51064#48516
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      AnchorX = 688
    end
    object cxDBSpinEdit1: TcxDBSpinEdit
      Left = 694
      Top = 181
      DataBinding.DataField = 'Servings'
      DataBinding.DataSource = dsRecipe
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 14
      Width = 95
    end
  end
  object dsRecipe: TDataSource
    DataSet = memRecipe
    Left = 132
    Top = 292
  end
  object dsIngredient: TDataSource
    DataSet = memIngredient
    Left = 134
    Top = 354
  end
  object dsMethod: TDataSource
    DataSet = memMethod
    OnDataChange = dsMethodDataChange
    Left = 130
    Top = 424
  end
  object DataSource1: TDataSource
    DataSet = memMethodItem
    Left = 132
    Top = 490
  end
  object memRecipe: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    Left = 56
    Top = 292
    object memRecipeSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memRecipeUsers_Nickname: TWideStringField
      FieldName = 'Users_Nickname'
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
    object memRecipeItemCode0: TWideStringField
      FieldName = 'ItemCode0'
      Size = 100
    end
    object memRecipeItemCode1: TWideStringField
      FieldName = 'ItemCode1'
      Size = 100
    end
    object memRecipeItemCode2: TWideStringField
      FieldName = 'ItemCode2'
      Size = 100
    end
    object memRecipeItemCode3: TWideStringField
      FieldName = 'ItemCode3'
      Size = 100
    end
    object memRecipeMakingLevel: TShortintField
      FieldName = 'MakingLevel'
    end
    object memRecipeMakingTime: TShortintField
      FieldName = 'MakingTime'
    end
    object memRecipeServings: TShortintField
      FieldName = 'Servings'
    end
    object memRecipeHashcode: TWideStringField
      FieldName = 'Hashcode'
      Size = 200
    end
    object memRecipeCreatedDate: TDateTimeField
      FieldName = 'CreatedDate'
    end
    object memRecipePublished: TBooleanField
      FieldName = 'Published'
    end
    object memRecipeDeleted: TBooleanField
      FieldName = 'Deleted'
    end
  end
  object memIngredient: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    Left = 58
    Top = 352
    object memIngredientSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memIngredientRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memIngredientSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memIngredientIngredientType: TShortintField
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
    object memIngredientPictureType: TShortintField
      FieldName = 'PictureType'
    end
    object memIngredientPicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
    object memIngredientContents: TWideStringField
      FieldName = 'Contents'
      Size = 1000
    end
  end
  object memMethod: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    Left = 60
    Top = 424
    object memMethodSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMethodRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
    end
    object memMethodSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memMethodDescription: TWideStringField
      FieldName = 'Description'
      Size = 1000
    end
    object memMethodPictureType: TShortintField
      FieldName = 'PictureType'
    end
    object memMethodPicture: TWideStringField
      FieldName = 'Picture'
      Size = 200
    end
  end
  object memMethodItem: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Option = poNone
    SortOptions = []
    Left = 60
    Top = 486
    object memMethodItemSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMethodItemRecipeMethod_Serial: TLargeintField
      FieldName = 'RecipeMethod_Serial'
    end
    object memMethodItemSeq: TIntegerField
      FieldName = 'Seq'
    end
    object memMethodItemMethodType: TShortintField
      FieldName = 'MethodType'
    end
    object memMethodItemItemCode: TShortintField
      FieldName = 'ItemCode'
    end
  end
  object sqlTemp: TFDQuery
    Connection = dmDB.FDConnection
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSeri' +
        'al ORDER BY Seq')
    Left = 58
    Top = 560
    ParamData = <
      item
        Name = 'RecipeSerial'
        ParamType = ptInput
      end>
  end
end
