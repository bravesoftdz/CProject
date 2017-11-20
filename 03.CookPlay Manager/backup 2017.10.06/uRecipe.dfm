object frmRecipe: TfrmRecipe
  Left = 0
  Top = 0
  Caption = 'Recipe'
  ClientHeight = 667
  ClientWidth = 827
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
  object SpeedButton1: TSpeedButton
    Left = 188
    Top = 428
    Width = 23
    Height = 22
  end
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 306
    Width = 827
    Height = 361
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabSheet2
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 354
    ClientRectLeft = 4
    ClientRectRight = 820
    ClientRectTop = 31
    object cxTabSheet1: TcxTabSheet
      Caption = #51116#47308
      ImageIndex = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 816
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnIngredientInsert: TButton
          Left = 15
          Top = 10
          Width = 75
          Height = 25
          Caption = #52628#44032
          TabOrder = 0
          OnClick = btnIngredientInsertClick
        end
        object btnIngredientUpdate: TButton
          Left = 102
          Top = 10
          Width = 75
          Height = 25
          Caption = #49688#51221
          TabOrder = 1
          OnClick = btnIngredientUpdateClick
        end
        object btnIngredientDelete: TButton
          Left = 192
          Top = 10
          Width = 75
          Height = 25
          Caption = #49325#51228
          TabOrder = 2
          OnClick = btnIngredientDeleteClick
        end
      end
      object cxGrid2: TcxGrid
        AlignWithMargins = True
        Left = 7
        Top = 48
        Width = 802
        Height = 268
        Margins.Left = 7
        Margins.Top = 7
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alClient
        TabOrder = 1
        object cxgRecipeIngredient: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeIngredient
          DataController.DetailKeyFieldNames = 'Recipe_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxgRecipeIngredientSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxgRecipeIngredientRecipe_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxgRecipeIngredientSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxgRecipeIngredientIngredientType: TcxGridDBColumn
            DataBinding.FieldName = 'IngredientType'
          end
          object cxgRecipeIngredientTitle: TcxGridDBColumn
            DataBinding.FieldName = 'Title'
          end
          object cxgRecipeIngredientAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
          end
          object cxgRecipeIngredientUnit: TcxGridDBColumn
            DataBinding.FieldName = 'Unit'
          end
          object cxgRecipeIngredientWeight: TcxGridDBColumn
            DataBinding.FieldName = 'Weight'
          end
          object cxgRecipeIngredientPictureType: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxgRecipeIngredientPicture: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
          object cxgRecipeIngredientContents: TcxGridDBColumn
            DataBinding.FieldName = 'Contents'
          end
        end
        object cxGrid2DBTableView2: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeMethod
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object cxGrid2DBTableView2Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGrid2DBTableView2Recipe_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxGrid2DBTableView2Seq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGrid2DBTableView2Description: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object cxGrid2DBTableView2PictureType: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxGrid2DBTableView2Picture: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
        end
        object cxGrid2DBTableView3: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxgRecipeMethod: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeMethod
          DataController.DetailKeyFieldNames = 'Recipe_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxgRecipeMethodSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxgRecipeMethodRecipe_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxgRecipeMethodSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxgRecipeMethodDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object cxgRecipeMethodPictureType: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxgRecipeMethodPicture: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
        end
        object cxgRecipeMethodItem: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'RecipeMethod_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxgRecipeMethodItemSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxgRecipeMethodItemRecipeMethod_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeMethod_Serial'
          end
          object cxgRecipeMethodItemSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxgRecipeMethodItemMethodType: TcxGridDBColumn
            DataBinding.FieldName = 'MethodType'
          end
          object cxgRecipeMethodItemItemCode: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
          end
          object cxgRecipeMethodItemItemValue: TcxGridDBColumn
            DataBinding.FieldName = 'ItemValue'
          end
        end
        object cxGridLevel1: TcxGridLevel
          Options.DetailTabsPosition = dtpTop
        end
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = #48169#48277
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 816
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnMethodUpdate: TButton
          Left = 624
          Top = 8
          Width = 75
          Height = 25
          Caption = #49688#51221
          TabOrder = 0
          OnClick = btnMethodUpdateClick
        end
        object btnMethodDelete: TButton
          Left = 716
          Top = 8
          Width = 75
          Height = 25
          Caption = #49325#51228
          TabOrder = 1
          OnClick = btnMethodDeleteClick
        end
        object btnAddExplain: TButton
          Left = 7
          Top = 8
          Width = 75
          Height = 25
          Caption = #49444#47749#52628#44032
          TabOrder = 2
          OnClick = btnAddExplainClick
        end
        object btnSelectIngredient: TButton
          Left = 252
          Top = 8
          Width = 93
          Height = 25
          Caption = #51116#47308#49440#53469#52628#44032
          TabOrder = 3
          OnClick = btnAddExplainClick
        end
        object btnAddTime: TButton
          Left = 351
          Top = 8
          Width = 75
          Height = 25
          Caption = #49884#44036#52628#44032
          TabOrder = 4
          OnClick = btnAddExplainClick
        end
        object btnAddTemperature: TButton
          Left = 432
          Top = 8
          Width = 75
          Height = 25
          Caption = #50728#46020#52628#44032
          TabOrder = 5
          OnClick = btnAddExplainClick
        end
        object btnSelectRecipe: TButton
          Left = 88
          Top = 8
          Width = 75
          Height = 25
          Caption = #47112#49884#54588#50672#44208
          Enabled = False
          TabOrder = 6
          OnClick = btnAddExplainClick
        end
        object btnAddIngredient: TButton
          Left = 171
          Top = 8
          Width = 75
          Height = 25
          Caption = #51116#47308#52628#44032
          TabOrder = 7
          OnClick = btnAddExplainClick
        end
      end
      object cxGrid1: TcxGrid
        AlignWithMargins = True
        Left = 7
        Top = 48
        Width = 802
        Height = 268
        Margins.Left = 7
        Margins.Top = 7
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alClient
        TabOrder = 1
        object cxGMethod: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGMethodCustomDrawCell
          DataController.DataSource = dsMethod
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
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object cxGMethodRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object cxGMethodSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
          end
          object cxGMethodRecipe_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
            Visible = False
          end
          object cxGMethodSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
            Width = 59
          end
          object cxGMethodExplainSeq: TcxGridDBColumn
            DataBinding.FieldName = 'ExplainSeq'
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
            Width = 86
          end
          object cxGMethodDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 207
          end
          object cxGMethodRecipeIngredient_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeIngredient_Serial'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'Serial'
            Properties.ListColumns = <
              item
                FieldName = 'Title'
              end>
            Properties.ListSource = dsIngredient
            Width = 150
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
          object cxGMethodWeightType: TcxGridDBColumn
            DataBinding.FieldName = 'WeightType'
            Visible = False
            Width = 40
          end
          object cxGMethodWeightValue: TcxGridDBColumn
            DataBinding.FieldName = 'WeightValue'
            Width = 100
          end
          object cxGMethodTimeType: TcxGridDBColumn
            DataBinding.FieldName = 'TimeType'
            Visible = False
            Width = 40
          end
          object cxGMethodTimeValue: TcxGridDBColumn
            DataBinding.FieldName = 'TimeValue'
            Width = 100
          end
          object cxGMethodTemperatureType: TcxGridDBColumn
            DataBinding.FieldName = 'TemperatureType'
            Visible = False
            Width = 38
          end
          object cxGMethodTemperatureValue: TcxGridDBColumn
            DataBinding.FieldName = 'TemperatureValue'
            Width = 100
          end
          object cxGMethodLinkedRecipe: TcxGridDBColumn
            DataBinding.FieldName = 'LinkedRecipe'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'Serial'
            Properties.ListColumns = <
              item
                FieldName = 'Title'
              end>
            Properties.ListSource = dmDB.dsMyRecipe
            Width = 150
          end
          object cxGMethodStateCur: TcxGridDBColumn
            DataBinding.FieldName = 'StateCur'
            Width = 75
          end
          object cxGMethodStateBefore: TcxGridDBColumn
            DataBinding.FieldName = 'StateBefore'
            Visible = False
          end
        end
        object cxGridDBTableView2: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeIngredient
          DataController.DetailKeyFieldNames = 'Recipe_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxGridDBColumn20: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGridDBColumn21: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxGridDBColumn22: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGridDBColumn23: TcxGridDBColumn
            DataBinding.FieldName = 'IngredientType'
          end
          object cxGridDBColumn24: TcxGridDBColumn
            DataBinding.FieldName = 'Title'
          end
          object cxGridDBColumn25: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
          end
          object cxGridDBColumn26: TcxGridDBColumn
            DataBinding.FieldName = 'Unit'
          end
          object cxGridDBColumn27: TcxGridDBColumn
            DataBinding.FieldName = 'Weight'
          end
          object cxGridDBColumn28: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxGridDBColumn29: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
          object cxGridDBColumn30: TcxGridDBColumn
            DataBinding.FieldName = 'Contents'
          end
        end
        object cxGridDBTableView3: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeMethod
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object cxGridDBColumn31: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGridDBColumn32: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxGridDBColumn33: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGridDBColumn34: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object cxGridDBColumn35: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxGridDBColumn36: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
        end
        object cxGridDBTableView4: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxGridDBTableView5: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipeMethod
          DataController.DetailKeyFieldNames = 'Recipe_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxGridDBColumn37: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGridDBColumn38: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxGridDBColumn39: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGridDBColumn40: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object cxGridDBColumn41: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
          end
          object cxGridDBColumn42: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
          end
        end
        object cxGridDBTableView6: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'RecipeMethod_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          object cxGridDBColumn43: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGridDBColumn44: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeMethod_Serial'
          end
          object cxGridDBColumn45: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGridDBColumn46: TcxGridDBColumn
            DataBinding.FieldName = 'MethodType'
          end
          object cxGridDBColumn47: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
          end
          object cxGridDBColumn48: TcxGridDBColumn
            DataBinding.FieldName = 'ItemValue'
          end
        end
        object cxgMethodItem: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'RecipeMethod_Serial'
          DataController.MasterKeyFieldNames = 'Serial'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgMethodItemRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object cxgMethodItemSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
          end
          object cxgMethodItemRecipeMethod_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeMethod_Serial'
            Visible = False
          end
          object cxgMethodItemRecipeIngredient_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeIngredient_Serial'
            Visible = False
          end
          object cxgMethodItemSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxgMethodItemMethodType: TcxGridDBColumn
            DataBinding.FieldName = 'MethodType'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'CategoryCode'
            Properties.ListColumns = <
              item
                FieldName = 'CategoryName'
              end>
            Properties.ListSource = dmDB.dsMethodType
          end
          object cxgMethodItemItemCode: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
            Visible = False
          end
          object cxgMethodItemItemValue: TcxGridDBColumn
            DataBinding.FieldName = 'ItemValue'
          end
        end
        object cxGIngredient: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsIngredient
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object cxGIngredientRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object cxGIngredientSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
          end
          object cxGIngredientRecipe_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Recipe_Serial'
          end
          object cxGIngredientRecipeMethod_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'RecipeMethod_Serial'
          end
          object cxGIngredientLinkedRecipe: TcxGridDBColumn
            DataBinding.FieldName = 'LinkedRecipe'
          end
          object cxGIngredientSeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
          end
          object cxGIngredientItemType: TcxGridDBColumn
            DataBinding.FieldName = 'ItemType'
          end
          object cxGIngredientItemValue: TcxGridDBColumn
            DataBinding.FieldName = 'ItemValue'
          end
          object cxGIngredientItemUnit: TcxGridDBColumn
            DataBinding.FieldName = 'ItemUnit'
          end
          object cxGIngredientIngredientType: TcxGridDBColumn
            DataBinding.FieldName = 'IngredientType'
          end
          object cxGIngredientTitle: TcxGridDBColumn
            DataBinding.FieldName = 'Title'
          end
          object cxGIngredientAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
          end
          object cxGIngredientUnit: TcxGridDBColumn
            DataBinding.FieldName = 'Unit'
          end
          object cxGIngredientNewPicture: TcxGridDBColumn
            DataBinding.FieldName = 'NewPicture'
          end
          object cxGIngredientPictureState: TcxGridDBColumn
            DataBinding.FieldName = 'PictureState'
          end
          object cxGIngredientStateCur: TcxGridDBColumn
            DataBinding.FieldName = 'StateCur'
          end
          object cxGIngredientStateBefore: TcxGridDBColumn
            DataBinding.FieldName = 'StateBefore'
          end
          object cxGIngredientUsed: TcxGridDBColumn
            DataBinding.FieldName = 'Used'
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGMethod
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGIngredient
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 827
    Height = 306
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object imgRecipeSquare: TImage
      Left = 419
      Top = 103
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
      Left = 515
      Top = 128
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
      Left = 515
      Top = 163
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
    object cxchkDeleted: TcxCheckBox
      Left = 714
      Top = 19
      Caption = 'Deleted'
      TabOrder = 14
      Transparent = True
    end
    object cxchkPublished: TcxCheckBox
      Left = 714
      Top = 46
      Caption = 'Published'
      TabOrder = 15
      Transparent = True
    end
    object cxTxtTitle: TcxTextEdit
      Left = 96
      Top = 24
      Properties.MaxLength = 100
      TabOrder = 16
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
      TabOrder = 18
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
      TabOrder = 19
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
      TabOrder = 20
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
      TabOrder = 21
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
      TabOrder = 22
      Width = 155
    end
    object cxtxtCategory: TcxTextEdit
      Left = 96
      Top = 238
      Properties.ReadOnly = True
      Style.TextColor = clGrayText
      TabOrder = 23
      Text = 'cxtxtCategory'
      Width = 639
    end
    object cxtxtCategoryTag: TcxTextEdit
      Left = 270
      Top = 243
      Properties.ReadOnly = True
      Style.TextColor = clGrayText
      TabOrder = 24
      Text = 'cxtxtCategoryTag'
      Visible = False
      Width = 639
    end
  end
  object dsRecipe: TDataSource
    DataSet = memRecipe
    Left = 248
    Top = 408
  end
  object dsIngredient: TDataSource
    DataSet = memIngredient
    Left = 246
    Top = 466
  end
  object dsMethod: TDataSource
    DataSet = memMethod
    Left = 244
    Top = 536
  end
  object memRecipe: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    Persistent.Data = {
      5665728FC2F5285C8FFE3F11000000080000001500070053657269616C000800
      000015000D0055736572735F53657269616C0064000000140006005469746C65
      00E803000014000C004465736372697074696F6E006400000014000C00506963
      747572655479706500C8000000140008005069637475726500C800000014000E
      005069637475726553717561726500C800000014001100506963747572655265
      6374616E676C6500C80000001400090043617465676F7279000200000002000C
      004D616B696E674C6576656C000200000002000B004D616B696E6754696D6500
      020000000200090053657276696E677300C80000001400090048617368636F64
      6500080000000B000C00437265617465644461746500080000000B000C005570
      646174656444617465000200000005000A005075626C69736865640002000000
      0500080044656C65746564000154000000000000000101000000000000000107
      0000007200650063006900700065003100010000000001010000003000012200
      000031003500300034003800320034003600320032005F003200300031003700
      30003900300037005F003200320035003000340031005F003300350030002E00
      6A0070006700012300000031003500300034003800320034003600320032005F
      00320030003100370030003900300037005F003200320035003000340031005F
      0033003500300053002E006A0070006700012300000031003500300034003800
      320034003600320032005F00320030003100370030003900300037005F003200
      320035003000340031005F0033003500300052002E006A007000670000010000
      01000001010001000000000100D857EEBAF0CC420100D09C23E9F0CC42010100
      0101000155000000000000000101000000000000000107000000520065006300
      6900700065003200010000000001010000003000000000000100000100000101
      0001000000000100BCAC27BCF0CC420100F49623E9F0CC420101000101000156
      0000000000000001010000000000000001070000005200650063006900700065
      0033000100000000010100000030000000000001000001000001010001000000
      00010080B028BCF0CC420100189123E9F0CC4201010001010001570000000000
      0000010300000000000000010A000000DCC2D0C65CD5200014BCC0C97DB77CCE
      6DAD18C20117000000ECC584B9D0C5200039BA44C7200018C2200088C794B220
      00DCC2D0C65CD5200014BCC0C97DB720007CCE6DAD18C2010100000030000122
      00000031003500300035003200320037003100300032005F0032003000310037
      0030003900310032005F003100340034003500340031005F003300340034002E
      0070006E00670001230000003100350030003500320032003700310030003200
      5F00320030003100370030003900310032005F00310034003400350034003100
      5F0033003400340053002E006A00700067000123000000310035003000350032
      00320037003100300032005F00320030003100370030003900310032005F0031
      00340034003500340031005F0033003400340052002E006A0070006700010900
      000030002C003100300032002C00330030003000010000010300010100010000
      000001009805EDC6F0CC420100DC012FCCF0CC42010100010000015800000000
      000000010300000000000000010A000000DCC2D0C65CD5200014BCC0C97DB77C
      CE6DAD18C20117000000ECC584B9D0C5200039BA44C7200018C2200088C794B2
      2000DCC2D0C65CD5200014BCC0C97DB720007CCE6DAD18C20101000000300001
      2200000031003500300035003200320037003100300032005F00320030003100
      370030003900310032005F003100340034003500340031005F00330034003400
      2E0070006E006700012300000031003500300035003200320037003100300032
      005F00320030003100370030003900310032005F003100340034003500340031
      005F0033003400340053002E006A007000670001230000003100350030003500
      3200320037003100300032005F00320030003100370030003900310032005F00
      3100340034003500340031005F0033003400340052002E006A00700067000109
      00000030002C003100300032002C003300300030000100000103000101000100
      00000001009805EDC6F0CC420100481222E9F0CC420101000101000159000000
      0000000001010000000000000001070000007200650063006900700065003400
      0100000000010100000030000122000000310035003000340038003200340036
      00320032005F00320030003100370030003900300037005F0032003200350030
      00340031005F003300350030002E006A00700067000123000000310035003000
      34003800320034003600320032005F0032003000310037003000390030003700
      5F003200320035003000340031005F0033003500300053002E006A0070006700
      012300000031003500300034003800320034003600320032005F003200300031
      00370030003900300037005F003200320035003000340031005F003300350030
      0052002E006A00700067000001000001000001010001000000000100D857EEBA
      F0CC420100DC2322E9F0CC42010100010100015A000000000000000101000000
      0000000001070000005200650063006900700065003200010000000001010000
      0030000000000001000001000001010001000000000100BCAC27BCF0CC420100
      AC2B22E9F0CC42010100010100015B0000000000000001010000000000000001
      0700000052006500630069007000650033000100000000010100000030000000
      00000100000100000101000100000000010080B028BCF0CC420100883122E9F0
      CC42010100010100015C00000000000000010100000000000000010700000072
      0065006300690070006500350001000000000101000000300001220000003100
      3500300034003800320034003600320032005F00320030003100370030003900
      300037005F003200320035003000340031005F003300350030002E006A007000
      6700012300000031003500300034003800320034003600320032005F00320030
      003100370030003900300037005F003200320035003000340031005F00330035
      00300053002E006A007000670001230000003100350030003400380032003400
      3600320032005F00320030003100370030003900300037005F00320032003500
      3000340031005F0033003500300052002E006A00700067000001000001000001
      010001000000000100D857EEBAF0CC420100643722E9F0CC4201010001010001
      5D00000000000000010100000000000000010700000052006500630069007000
      6500320001000000000101000000300000000000010000010000010100010000
      00000100BCAC27BCF0CC420100343F22E9F0CC42010100010100015E00000000
      0000000101000000000000000107000000520065006300690070006500330001
      0000000001010000003000000000000100000100000101000100000000010080
      B028BCF0CC420100104522E9F0CC42010100010100015F000000000000000103
      00000000000000010A000000DCC2D0C65CD5200014BCC0C97DB77CCE6DAD18C2
      0117000000ECC584B9D0C5200039BA44C7200018C2200088C794B22000DCC2D0
      C65CD5200014BCC0C97DB720007CCE6DAD18C201010000003000012200000031
      003500300035003200320037003100300032005F003200300031003700300039
      00310032005F003100340034003500340031005F003300340034002E0070006E
      006700012300000031003500300035003200320037003100300032005F003200
      30003100370030003900310032005F003100340034003500340031005F003300
      3400340053002E006A0070006700012300000031003500300035003200320037
      003100300032005F00320030003100370030003900310032005F003100340034
      003500340031005F0033003400340052002E006A007000670001090000003000
      2C003100300032002C0033003000300001000001030001010001000000000100
      9805EDC6F0CC420100D44E22E9F0CC4201010001010001600000000000000001
      0300000000000000010A000000DCC2D0C65CD5200014BCC0C97DB77CCE6DAD18
      C20117000000ECC584B9D0C5200039BA44C7200018C2200088C794B22000DCC2
      D0C65CD5200014BCC0C97DB720007CCE6DAD18C2010100000030000122000000
      31003500300035003200320037003100300032005F0032003000310037003000
      3900310032005F003100340034003500340031005F003300340034002E007000
      6E006700012300000031003500300035003200320037003100300032005F0032
      0030003100370030003900310032005F003100340034003500340031005F0033
      003400340053002E006A00700067000123000000310035003000350032003200
      37003100300032005F00320030003100370030003900310032005F0031003400
      34003500340031005F0033003400340052002E006A0070006700010900000030
      002C003100300032002C00330030003000010000010300010100010000000001
      009805EDC6F0CC4201008C5A22E9F0CC42010100010100016100000000000000
      0101000000000000000107000000520065006300690070006500330001000000
      0001010000003000000000000100000100000101000100000000010080B028BC
      F0CC420100506422E9F0CC420101000101000162000000000000000101000000
      0000000001070000005200650063006900700065003200010000000001010000
      0030000000000001000001000001010001000000000100BCAC27BCF0CC420100
      2C6A22E9F0CC4201010001010001630000000000000001010000000000000001
      0800000072006500630069007000650031003000010000000001010000003000
      012200000031003500300034003800320034003600320032005F003200300031
      00370030003900300037005F003200320035003000340031005F003300350030
      002E006A00700067000123000000310035003000340038003200340036003200
      32005F00320030003100370030003900300037005F0032003200350030003400
      31005F0033003500300053002E006A0070006700012300000031003500300034
      003800320034003600320032005F00320030003100370030003900300037005F
      003200320035003000340031005F0033003500300052002E006A007000670000
      01000001000001010001000000000100D857EEBAF0CC420100087022E9F0CC42
      0101000101000167000000000000000101000000000000000104000000650073
      0072003100010000000001010000003000000000000100000100000101000100
      0000000100C45C1DD7F0CC420100D87722E9F0CC420101000101000168000000
      00000000010300000000000000010A0000001CACB4C65CD52000CCB950B484BC
      2FC104C8E8AC0113000000CCB950B484BC2FC1200004C8E8AC58C72000ACC7CC
      B87CB9200000C944BE69D5C8B2E4B22E00010100000030000122000000310035
      00300035003900320030003400380034005F0032003000310037003000390032
      0030005F003100350032003800320035005F003000360034002E0070006E0067
      00012300000031003500300035003900320030003400380034005F0032003000
      3100370030003900320030005F003100350032003800320035005F0030003600
      340053002E006A00700067000123000000310035003000350039003200300034
      00380034005F00320030003100370030003900320030005F0031003500320038
      00320035005F0030003600340052002E006A0070006700010D00000034002C00
      3100300037002C003200310033002C0033003000300001000001010001020001
      000000000100501B97DBF0CC420100608B22E9F0CC4201010001010001690000
      0000000000010300000000000000010A0000001CACB4C65CD52000CCB950B484
      BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950B404C838BB
      10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44C72000CCB9
      E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007DC28CAC2000
      CCB9E4B418C2200088C7B5C2C8B2E4B22E000101000000300001220000003100
      3500300035003900320030003400380034005F00320030003100370030003900
      320030005F003100350034003500330034005F003000380034002E0070006E00
      6700012300000031003500300035003900320030003400380034005F00320030
      003100370030003900320030005F003100350034003500330034005F00300038
      00340053002E006A007000670001230000003100350030003500390032003000
      3400380034005F00320030003100370030003900320030005F00310035003400
      3500330034005F0030003800340052002E006A0070006700010D00000034002C
      003100300037002C003200310033002C00330030003000010000010100010200
      01000000000100501B97DBF0CC420100F49C22E9F0CC42010100010100016A00
      000000000000010300000000000000010A0000001CACB4C65CD52000CCB950B4
      84BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950B404C838
      BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44C72000CC
      B9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007DC28CAC20
      00CCB9E4B418C2200088C7B5C2C8B2E4B22E0001010000003000012200000031
      003500300035003900320030003400380034005F003200300031003700300039
      00320030005F003100350034003500330037005F003600380032002E0070006E
      006700012300000031003500300035003900320030003400380034005F003200
      30003100370030003900320030005F003100350034003500330037005F003600
      3800320053002E006A0070006700012300000031003500300035003900320030
      003400380034005F00320030003100370030003900320030005F003100350034
      003500330037005F0036003800320052002E006A0070006700010D0000003400
      2C003100300037002C003200310033002C003300300030000100000101000102
      0001000000000100501B97DBF0CC420100C4A422E9F0CC42010100010100016B
      00000000000000010300000000000000010A0000001CACB4C65CD52000CCB950
      B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950B404C8
      38BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44C72000
      CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007DC28CAC
      2000CCB9E4B418C2200088C7B5C2C8B2E4B22E00010100000030000122000000
      31003500300035003900320030003400380034005F0032003000310037003000
      3900320030005F003100350034003700330036005F003100380039002E007000
      6E006700012300000031003500300035003900320030003400380034005F0032
      0030003100370030003900320030005F003100350034003700330036005F0031
      003800390053002E006A00700067000123000000310035003000350039003200
      30003400380034005F00320030003100370030003900320030005F0031003500
      34003700330036005F0031003800390052002E006A0070006700010D00000034
      002C003100300037002C003200310033002C0033003000300001000001010001
      020001000000000100501B97DBF0CC4201007CB022E9F0CC4201010001010001
      6C00000000000000010300000000000000010A0000001CACB4C65CD52000CCB9
      50B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950B404
      C838BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44C720
      00CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007DC28C
      AC2000CCB9E4B418C2200088C7B5C2C8B2E4B22E000101000000300001220000
      0031003500300035003900320030003400380034005F00320030003100370030
      003900320030005F003100350034003800320034005F003500350030002E0070
      006E006700012300000031003500300035003900320030003400380034005F00
      320030003100370030003900320030005F003100350034003800320034005F00
      35003500300053002E006A007000670001230000003100350030003500390032
      0030003400380034005F00320030003100370030003900320030005F00310035
      0034003800320034005F0035003500300052002E006A0070006700010D000000
      34002C003100300037002C003200310033002C00330030003000010000010100
      01020001000000000100501B97DBF0CC4201004CB822E9F0CC42010100010100
      016D00000000000000010300000000000000010A0000001CACB4C65CD52000CC
      B950B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950B4
      04C838BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44C7
      2000CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007DC2
      8CAC2000CCB9E4B418C2200088C7B5C2C8B2E4B22E0001010000003000012200
      000031003500300035003900320030003400380034005F003200300031003700
      30003900320030005F003100350034003900340034005F003600360033002E00
      70006E006700012300000031003500300035003900320030003400380034005F
      00320030003100370030003900320030005F003100350034003900340034005F
      0036003600330053002E006A0070006700012300000031003500300035003900
      320030003400380034005F00320030003100370030003900320030005F003100
      350034003900340034005F0036003600330052002E006A0070006700010D0000
      0034002C003100300037002C003200310033002C003300300030000100000101
      0001020001000000000100501B97DBF0CC4201001CC022E9F0CC420101000101
      00016E00000000000000010300000000000000010A0000001CACB4C65CD52000
      CCB950B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB950
      B404C838BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC44
      C72000CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020007D
      C28CAC2000CCB9E4B418C2200088C7B5C2C8B2E4B22E00010100000030000122
      00000031003500300035003900320030003400380034005F0032003000310037
      0030003900320030005F003100350035003000320032005F003900330031002E
      0070006E00670001230000003100350030003500390032003000340038003400
      5F00320030003100370030003900320030005F00310035003500300032003200
      5F0039003300310053002E006A00700067000123000000310035003000350039
      00320030003400380034005F00320030003100370030003900320030005F0031
      00350035003000320032005F0039003300310052002E006A0070006700010D00
      000034002C003100300037002C003200310033002C0033003000300001000001
      010001020001000000000100501B97DBF0CC420100ECC722E9F0CC4201010001
      0100016F00000000000000010300000000000000010A0000001CACB4C65CD520
      00CCB950B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CCB9
      50B404C838BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8AC
      44C72000CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B02000
      7DC28CAC2000CCB9E4B418C2200088C7B5C2C8B2E4B22E000101000000300001
      2200000031003500300035003900320030003400380034005F00320030003100
      370030003900320030005F003100350035003000330032005F00320030003600
      2E0070006E006700012300000031003500300035003900320030003400380034
      005F00320030003100370030003900320030005F003100350035003000330032
      005F0032003000360053002E006A007000670001230000003100350030003500
      3900320030003400380034005F00320030003100370030003900320030005F00
      3100350035003000330032005F0032003000360052002E006A0070006700010D
      00000034002C003100300037002C003200310033002C00330030003000010000
      01010001020001000000000100501B97DBF0CC420100A4D322E9F0CC42010100
      010100017000000000000000010300000000000000010A0000001CACB4C65CD5
      2000CCB950B484BC2FC104C8E8AC0133000000C9B0D9B3CCB950B45CB82000CC
      B950B404C838BB10C82000BBBAC0C94AC540C72000CCB950B484BC2FC104C8E8
      AC44C72000CCB9E4B4B4C5F4BC38C194C67E0020003100300084BD74C7B4B020
      007DC28CAC2000CCB9E4B418C2200088C7B5C2C8B2E4B22E0001010000003000
      012200000031003500300035003900320030003400380034005F003200300031
      00370030003900320030005F003100350035003000350037005F003700320036
      002E0070006E0067000123000000310035003000350039003200300034003800
      34005F00320030003100370030003900320030005F0031003500350030003500
      37005F0037003200360053002E006A0070006700012300000031003500300035
      003900320030003400380034005F00320030003100370030003900320030005F
      003100350035003000350037005F0037003200360052002E006A007000670001
      0D00000034002C003100300037002C003200310033002C003300300030000100
      0001010001020001000000000100501B97DBF0CC42010074DB22E9F0CC420101
      00010100017100000000000000010300000000000000010900000004ACE8B25C
      D5200010AC90C7A8BADDB275BE011900000044C568CEDDC2ACC0200000B3A9C6
      3CC75CB8200048C531C1DEB9A4CD78C7200010AC90C7A8BADDB275BE85C7C8B2
      E4B22E0001010000003000011B0000003100310033005F003200300031003700
      30003900320030005F003100350035003900320036005F003300360038002E00
      70006E006700011C0000003100310033005F0032003000310037003000390032
      0030005F003100350035003900320036005F0033003600380053002E006A0070
      006700011C0000003100310033005F0032003000310037003000390032003000
      5F003100350035003900320036005F0033003600380052002E006A0070006700
      000100000100000101000100000000010090CEA8DBF0CC4201007420AADBF0CC
      42010100010000017200000000000000010300000000000000010700000038D6
      15BCC8C0B0C613C80CCC1CAC0110000000BCC570D0DCC2D0C65CD5200038D615
      BCC8C0B0C613C80CCC1CAC08C694C67E00010100000030000122000000310035
      00300035003900320035003800310037005F0032003000310037003000390032
      0030005F003100360035003000310030005F003100350032002E0070006E0067
      00012300000031003500300035003900320035003800310037005F0032003000
      3100370030003900320030005F003100360035003000310030005F0031003500
      320053002E006A00700067000123000000310035003000350039003200350038
      00310037005F00320030003100370030003900320030005F0031003600350030
      00310030005F0031003500320052002E006A0070006700010D00000032002C00
      3100300031002C003200310031002C0033003000300001010001010001020001
      00000000010054CBBFDBF0CC42010054CBBFDBF0CC4201010001000001730000
      00000000000103000000000000000104000000B4C535BBB0C6D9B30129000000
      C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1B581AD69D5
      74C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134BB20008BC8
      3CC7C8B22000CCB9E4B4B4C5F4BC38C194C60101000000300001220000003100
      3500300035003900320037003700310034005F00320030003100370030003900
      320030005F003100370033003300340031005F003200380036002E0070006E00
      6700012300000031003500300035003900320037003700310034005F00320030
      003100370030003900320030005F003100370033003300340031005F00320038
      00360053002E006A007000670001230000003100350030003500390032003700
      3700310034005F00320030003100370030003900320030005F00310037003300
      3300340031005F0032003800360052002E006A0070006700010D00000032002C
      003100300031002C003200310031002C00330030003000010100010200010200
      010000000001006844CEDBF0CC4201006844CEDBF0CC42010100010000017400
      0000000000000103000000000000000104000000B4C535BBB0C6D9B301290000
      00C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1B581AD69
      D574C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134BB20008B
      C83CC7C8B22000CCB9E4B4B4C5F4BC38C194C601010000003000012200000031
      003500300035003900320037003700310034005F003200300031003700300039
      00320030005F003100370033003300340034005F003300380032002E0070006E
      006700012300000031003500300035003900320037003700310034005F003200
      30003100370030003900320030005F003100370033003300340034005F003300
      3800320053002E006A0070006700012300000031003500300035003900320037
      003700310034005F00320030003100370030003900320030005F003100370033
      003300340034005F0033003800320052002E006A0070006700010D0000003200
      2C003100300031002C003200310031002C003300300030000101000102000102
      00010000000001006844CEDBF0CC4201009CFE22E9F0CC420101000101000175
      000000000000000103000000000000000104000000B4C535BBB0C6D9B3012900
      0000C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1B581AD
      69D574C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134BB2000
      8BC83CC7C8B22000CCB9E4B4B4C5F4BC38C194C6010100000030000122000000
      31003500300035003900320037003700310034005F0032003000310037003000
      3900320030005F003100370034003000330038005F003800330038002E007000
      6E006700012300000031003500300035003900320037003700310034005F0032
      0030003100370030003900320030005F003100370034003000330038005F0038
      003300380053002E006A00700067000123000000310035003000350039003200
      37003700310034005F00320030003100370030003900320030005F0031003700
      34003000330038005F0038003300380052002E006A0070006700010D00000032
      002C003100300031002C003200310031002C0033003000300001010001020001
      0200010000000001006844CEDBF0CC420100480C23E9F0CC4201010001010001
      76000000000000000103000000000000000104000000B4C535BBB0C6D9B30129
      000000C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1B581
      AD69D574C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134BB20
      008BC83CC7C8B22000CCB9E4B4B4C5F4BC38C194C60101000000300001220000
      0031003500300035003900320037003700310034005F00320030003100370030
      003900320030005F003100370034003000350033005F003700300039002E0070
      006E006700012300000031003500300035003900320037003700310034005F00
      320030003100370030003900320030005F003100370034003000350033005F00
      37003000390053002E006A007000670001230000003100350030003500390032
      0037003700310034005F00320030003100370030003900320030005F00310037
      0034003000350033005F0037003000390052002E006A0070006700010D000000
      32002C003100300031002C003200310031002C00330030003000010100010200
      010200010000000001006844CEDBF0CC4201000C1623E9F0CC42010100010100
      0177000000000000000103000000000000000104000000B4C535BBB0C6D9B301
      29000000C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1B5
      81AD69D574C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134BB
      20008BC83CC7C8B22000CCB9E4B4B4C5F4BC38C194C601010000003000012200
      000031003500300035003900320037003700310034005F003200300031003700
      30003900320030005F003100370034003100300032005F003900360035002E00
      70006E006700012300000031003500300035003900320037003700310034005F
      00320030003100370030003900320030005F003100370034003100300032005F
      0039003600350053002E006A0070006700012300000031003500300035003900
      320037003700310034005F00320030003100370030003900320030005F003100
      370034003100300032005F0039003600350052002E006A0070006700010D0000
      0032002C003100300031002C003200310031002C003300300030000101000102
      00010200010000000001006844CEDBF0CC420100DC1D23E9F0CC420101000101
      000178000000000000000103000000000000000104000000B4C535BBB0C6D9B3
      0129000000C4CA43AE5CD52000B4C535BBFCAC2000B0C6D9B374C7200030CCA1
      B581AD69D574C708C694C620000D000A0094CDB4C6A8ACB8C6D0C5200008B134
      BB20008BC83CC7C8B22000CCB9E4B4B4C5F4BC38C194C6010100000030000122
      00000031003500300035003900320037003700310034005F0032003000310037
      0030003900320030005F003100370034003100330031005F003800360032002E
      0070006E00670001230000003100350030003500390032003700370031003400
      5F00320030003100370030003900320030005F00310037003400310033003100
      5F0038003600320053002E006A00700067000123000000310035003000350039
      00320037003700310034005F00320030003100370030003900320030005F0031
      00370034003100330031005F0038003600320052002E006A0070006700010D00
      000032002C003100300031002C003200310031002C0033003000300001010001
      0200010200010000000001006844CEDBF0CC420100942923E9F0CC4201010001
      0100017E0000000000000001030000000000000001050000007CB774BA53B074
      C730AE01090000007CB774BA44C7200053B0ECC5FCC838C194C6010100000030
      0000000000010000010000010100010000000001002C0DB8DDF0CC4201002C0D
      B8DDF0CC42010100010000017F00000000000000010300000000000000010600
      00007CB774BA53B074C730AE320001080000007CB774BA44C753B0ECC5FCC838
      C194C601010000003000000000000100000100000101000100000000010024B5
      B8DDF0CC42010024B5B8DDF0CC42010100010000018000000000000000010300
      00000000000001060000007CB774BA53B074C730AE330001040000007CB774BA
      7CB774BA01010000003000000000010D00000030002C003100300033002C0032
      00300036002C003300300030000100000100000101000100000000010018B1B9
      DDF0CC420100ECDBBADDF0CC4201010001000001810000000000000001030000
      0000000000010400000024C6D5C9B4C525BC0113000000B5D124C6D5C9B4C55C
      B8200074AC15ACDDC2200025BC44C72000CCB9E4B4B4C5F4BC38C194C6010100
      00003000000000010D00000033002C003100300035002C003200300030002C00
      33003000350001000001020001010001000000000100F075BDDDF0CC420100F0
      75BDDDF0CC420101000100000182000000000000000101000000000000000105
      0000007400650073007400310001000000000101000000300000000000010000
      010000010100010000000001000CAB1FE9F0CC420100A87923E9F0CC42010100
      0101000183000000000000000101000000000000000105000000740065007300
      7400320001000000000101000000300000000000010000010000010100010000
      00000100A88B20E9F0CC420100608523E9F0CC42010100010100}
    SortOptions = []
    Left = 170
    Top = 408
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
    object memRecipeUsed: TBooleanField
      FieldName = 'Used'
    end
  end
  object memIngredient: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0C000000080000001500070053657269616C000800
      000015000E005265636970655F53657269616C00080000001500140052656369
      70654D6574686F645F53657269616C000800000015000D004C696E6B65645265
      636970650004000000030004005365710002000000020009004974656D547970
      65002200000008000A004974656D56616C75650002000000020009004974656D
      556E6974000200000002000F00496E6772656469656E74547970650064000000
      140006005469746C65003200000014000700416D6F756E740032000000140005
      00556E6974000147000000000000000183000000000000000000000000000000
      0001FFFFFFFFFFFFFFFF0100000000010000010A020000000000000000000000
      0000000000000000000000000000000000000000000100000100000101000000
      3100000001450000000000000001820000000000000000000000000000000001
      FFFFFFFFFFFFFFFF0100000000010000010A0200000000000000000000000000
      0000000000000000000000000000000000000001000001000001010000003100
      000001440000000000000001810000000000000000000000000000000001FFFF
      FFFFFFFFFFFF0100000000010000010A02000000000000000000000000000000
      0000000000000000000000000000000000010000010000010300000024C6D5C9
      B4C5010100000031000102000000C8B9ACB90141000000000000000180000000
      0000000000000000000000000001FFFFFFFFFFFFFFFF0100000000010000010A
      0200000000000000000000000000000000000000000000000000000000000000
      0001000001000001010000003CBB010100000032000101000000F5CE01400000
      0000000000017F0000000000000000000000000000000001FFFFFFFFFFFFFFFF
      0100000000010000010A02000000000000000000000000000000000000000000
      000000000000000000000001000001000001010000003CBB0103000000330035
      00300001010000006700013F00000000000000017E0000000000000000000000
      000000000001FFFFFFFFFFFFFFFF0100000000010000010A0200000000000000
      0000000000000000000000000000000000000000000000000001000001000001
      010000003CBB0103000000330035003000010100000067000130000000000000
      0001730000000000000000000000000000000001FFFFFFFFFFFFFFFF01000000
      00010000010A0200000000000000000000000000000000000000000000000000
      000000000000000100000100000102000000B4C535BB01010000003500010100
      0000A5C7012D0000000000000001720000000000000000000000000000000001
      FFFFFFFFFFFFFFFF0100000000010000010A0200000000000000000000000000
      00000000000000000000000000000000000000010000010000010300000060C5
      38D615BC010300000031002F00320001010000001CAC012A0000000000000001
      710000000000000000000000000000000001FFFFFFFFFFFFFFFF010000000001
      0000010A02000000000000000000000000000000000000000000000000000000
      000000000001000001000001050000006C006B003B006C006B000000011F0000
      000000000001680000000000000000000000000000000001FFFFFFFFFFFFFFFF
      0100000000010000010A02000000000000000000000000000000000000000000
      00000000000000000000000100000100000104000000C9B0D9B3CCB950B40101
      000000360001010000001CAC0119000000000000000157000000000000000000
      0000000000000001FFFFFFFFFFFFFFFF0100000000010000010A020000000000
      0000000000000000000000000000000000000000000000000000000100000100
      00010300000014BCC0C97DB70102000000320030000101000000670001120000
      000000000001540000000000000000000000000000000001FFFFFFFFFFFFFFFF
      0100000000010000010A02000000000000000000000000000000000000000000
      000000000000000000000001000001000001020000008CC108AE010100000031
      0001010000007400010F00000000000000015600000000000000000000000000
      00000001FFFFFFFFFFFFFFFF0100000000010000010A02000000000000000000
      0000000000000000000000000000000000000000000000010000010000010500
      0000720065007300740072000000010E00000000000000015500000000000000
      0000000000000000000154000000000000000100000000010000010A02000000
      0000000000000000000000000000000000000000000000000000000000010000
      0100000107000000520065006300690070006500320000000146000000000000
      0001820000000000000000000000000000000001FFFFFFFFFFFFFFFF01010000
      00010000010A0200000000000000000000000000000000000000000000000000
      0000000000000001000001000001010000003300000001420000000000000001
      800000000000000000000000000000000001FFFFFFFFFFFFFFFF010100000001
      0000010A02000000000000000000000000000000000000000000000000000000
      00000000000100000100000102000000C4AC80B7010100000031000101000000
      1CAC01310000000000000001730000000000000000000000000000000001FFFF
      FFFFFFFFFFFF0101000000010000010A02000000000000000000000000000000
      0000000000000000000000000000000000010000010000010200000065C413AC
      010100000031000101000000E8B2012E00000000000000017200000000000000
      00000000000000000001FFFFFFFFFFFFFFFF0101000000010000010A02000000
      0000000000000000000000000000000000000000000000000000000000010000
      0100000104000000ADCC91C5E0AC94CD0101000000320001010000001CAC012B
      0000000000000001710000000000000000000000000000000001FFFFFFFFFFFF
      FFFF0101000000010000010A0200000000000000000000000000000000000000
      00000000000000000000000000010000010000010200000010AC90C701010000
      00320001010000001CAC011A0000000000000001570000000000000000000000
      000000000001FFFFFFFFFFFFFFFF0101000000010000010A0200000000000000
      0000000000000000000000000000000000000000000000000001000001000001
      010000000CD30101000000310001010000001CAC011100000000000000015400
      00000000000000000000000000000001FFFFFFFFFFFFFFFF0101000000010000
      010A020000000000000000000000000000000000000000000000000000000000
      00000001000001000001030000008CC1E0AC30AE010300000032003000300001
      0100000067000143000000000000000180000000000000000000000000000000
      0001FFFFFFFFFFFFFFFF0102000000010000010A020000000000000000000000
      0000000000000000000000000000000000000000000100000101000102000000
      61C513C801010000003100010100000074000132000000000000000173000000
      0000000000000000000000000001FFFFFFFFFFFFFFFF0102000000010000010A
      0200000000000000000000000000000000000000000000000000000000000000
      00010000010000010200000020C780BD01010000003100010100000009BD012F
      0000000000000001720000000000000000000000000000000001FFFFFFFFFFFF
      FFFF0102000000010000010A0200000000000000000000000000000000000000
      000000000000000000000000000100000101000103000000C8C0B0C613C80101
      0000003100010200000018C200C8012C00000000000000017100000000000000
      00000000000000000001FFFFFFFFFFFFFFFF0102000000010000010A02000000
      0000000000000000000000000000000000000000000000000000000000010000
      0100000103000000A0BC74C7E8CE010100000033000101000000BDCA011B0000
      000000000001570000000000000000000000000000000001FFFFFFFFFFFFFFFF
      0102000000010000010A02000000000000000000000000000000000000000000
      00000000000000000000000100000100000105000000E4B2DCC2C8B96DAD3CBB
      0101000000310001010000006700010D00000000000000015400000000000000
      00000000000000000001FFFFFFFFFFFFFFFF0102000000010000010A02000000
      0000000000000000000000000000000000000000000000000000000000010000
      010100010200000024C1D5D00101000000310001010000005400010C00000000
      0000000154000000000000000000000000000000000156000000000000000103
      000000010000010A020000000000000000000000000000000000000000000000
      0000000000000000000100000100000104000000610061006100310000000118
      0000000000000001540000000000000000000000000000000001FFFFFFFFFFFF
      FFFF0104000000010000010A0200000000000000000000000000000000000000
      0000000000000000000000000001000001000001080000006100640073006600
      73006400610066000101000000310001010000003500011C0000000000000001
      5400000000000000000000000000000000015500000000000000010500000001
      0000010A02000000000000000000000000000000000000000000000000000000
      0000000000010000010000010700000052006500630069007000650032000000
      011D0000000000000001540000000000000000000000000000000001FFFFFFFF
      FFFFFFFF0106000000010000010A020000000000000000000000000000000000
      000000000000000000000000000000010000010000010C000000610073006400
      6600730061006400660073006400610066000000}
    SortOptions = []
    SortedField = 'Seq'
    Left = 170
    Top = 464
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
    object memIngredientItemValue: TBCDField
      FieldName = 'ItemValue'
    end
    object memIngredientItemUnit: TSmallintField
      FieldName = 'ItemUnit'
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
    object memIngredientUsed: TBooleanField
      FieldName = 'Used'
    end
  end
  object memMethod: TdxMemData
    Indexes = <>
    Persistent.Option = poNone
    Persistent.Data = {
      5665728FC2F5285C8FFE3F09000000080000001500070053657269616C000800
      000015000E005265636970655F53657269616C000200000002000C0050696374
      7572655479706500C8000000140008005069637475726500C800000014001100
      5069637475726552656374616E676C6500C800000014000E0050696374757265
      53717561726500E803000014000C004465736372697074696F6E000200000002
      000400536571000200000002000B004578706C61696E53657100014400000000
      0000000183000000000000000100000000000101000000310001000001010001
      3E00000000000000018200000000000000010000000000010100000031000100
      0001010001340000000000000001810000000000000001000001220000003100
      3500300035003900390032003600320030005F00320030003100370030003900
      320031005F003100310032003300350037005F003500330039002E0070006E00
      6700012300000031003500300035003900390032003600320030005F00320030
      003100370030003900320031005F003100310032003300350037005F00350033
      00390052002E006A007000670001230000003100350030003500390039003200
      3600320030005F00320030003100370030003900320031005F00310031003200
      3300350037005F0035003300390053002E006A0070006700012900000024C6D5
      C9B4C52000DDC03CBB200010B694B2200074D5D9B3DCC2A8D0200024C6D5C9B4
      C57CB9200000C944BE69D5C8B2E4B22E000D000A0048C5D0C52000B4B0A5C744
      C720001CC870AC74D5FCC838C194C6010000010100012C000000000000000180
      0000000000000001000000000001090000003CBB44C7200023B1B4C5FCC838C1
      94C62000010000010100012900000000000000017F0000000000000001000000
      0000010D0000007CB774BA3CBB44C7200023B1B4C5FCC838C194C620000D000A
      00010000010100012700000000000000017E0000000000000001000000000001
      080000003CBB44C7200023B1B4C5FCC838C194C6010000010100011E00000000
      0000000172000000000000000100000122000000310035003000350039003200
      35003800310037005F00320030003100370030003900320030005F0031003600
      35003000310030005F003900360030002E0070006E0067000123000000310035
      00300035003900320035003800310037005F0032003000310037003000390032
      0030005F003100360035003000310030005F0039003600300052002E006A0070
      006700012300000031003500300035003900320035003800310037005F003200
      30003100370030003900320030005F003100360035003000310030005F003900
      3600300053002E006A0070006700011800000060C538D615BCFCAC200084BC2F
      C12000ADCC91C5E0AC94CD20004DD6E0AC94CD7CB9200000C944BE74D5FCC838
      C194C6010000010100011800000000000000017100000000000000010000011B
      0000003100310033005F00320030003100370030003900320030005F00310035
      0035003900320037005F003100300039002E0070006E006700011C0000003100
      310033005F00320030003100370030003900320030005F003100350035003900
      320037005F0031003000390052002E006A0070006700011C0000003100310033
      005F00320030003100370030003900320030005F003100350035003900320037
      005F0031003000390053002E006A0070006700010D00000010AC90C740C62000
      C4AC80B744C72000B6C044C5FCC838C194C6010000010100010F000000000000
      0001570000000000000001000001220000003100350030003500320032003700
      3100300032005F00320030003100370030003900310032005F00310034003400
      3500340034005F003300310033002E006A007000670001230000003100350030
      0035003200320037003100300032005F00320030003100370030003900310032
      005F003100340034003500340034005F0033003100330052002E006A00700067
      00012300000031003500300035003200320037003100300032005F0032003000
      3100370030003900310032005F003100340034003500340034005F0033003100
      330053002E006A0070006700010E00000014BCC0C97DB744C7200068AE57B074
      C720003BC5B4C5FCC838C194C601000001010001020000000000000001540000
      0000000000010000011A000000380034005F0032003000310037003000390030
      0038005F003100380031003000330033005F003100390039002E006A00700067
      00011B000000380034005F00320030003100370030003900300038005F003100
      380031003000330033005F0031003900390052002E006A0070006700011B0000
      00380034005F00320030003100370030003900300038005F0031003800310030
      00330033005F0031003900390053002E006A0070006700010500000061007300
      6400660061000100000101000145000000000000000183000000000000000100
      0000000000010100010000013F00000000000000018200000000000000010000
      0000000101000000320001010001020001350000000000000001810000000000
      000001000000000000010100010000012D000000000000000180000000000000
      0001000000000000010100010000012A00000000000000017F00000000000000
      01000000000000010100010000012800000000000000017E0000000000000001
      000000000000010100010000011F000000000000000172000000000000000100
      0000000000010100010000011900000000000000017100000000000000010000
      0000000001010001000001100000000000000001570000000000000001000000
      000000010100010000010300000000000000015400000000000000010000011A
      000000380034005F00320030003100370030003900300038005F003200300031
      003400300037005F003900370034002E0070006E006700011B00000038003400
      5F00320030003100370030003900300038005F00320030003100340030003700
      5F0039003700340052002E006A0070006700011B000000380034005F00320030
      003100370030003900300038005F003200300031003400300037005F00390037
      00340053002E006A0070006700010F0000006100730066006400730061006400
      6600610066006400610073006400660001010001020001460000000000000001
      8300000000000000010000000000000102000100000140000000000000000182
      0000000000000001000000000000010200010000013600000000000000018100
      0000000000000100000122000000310035003000350039003900320036003200
      30005F00320030003100370030003900320031005F0031003100320033003500
      37005F003900300036002E0070006E0067000123000000310035003000350039
      00390032003600320030005F00320030003100370030003900320031005F0031
      00310032003300350037005F0039003000360052002E006A0070006700012300
      000031003500300035003900390032003600320030005F003200300031003700
      30003900320031005F003100310032003300350037005F003900300036005300
      2E006A0070006700013200000068AE57B088D72000E4B2ECB4B4C5C4C9200024
      C6D5C9B4C5200048C5D0C5200025BC44C7200044CCCCC623B1B4C5FCC838C194
      C620000D000A0058D7ECB798B024C6C0C94AC58CAC200018CD18CD88D7200023
      B1B4C5FCC8DCC274BA20008BC844C594C6010200010200012E00000000000000
      01800000000000000001000000000000010200010000012B0000000000000001
      7F00000000000000010000000000000102000100000120000000000000000172
      0000000000000001000000000000010200010000011A00000000000000017100
      0000000000000100000000000001020001000001110000000000000001570000
      0000000000010000000000000102000100000106000000000000000154000000
      0000000001000000000001050000007300640066007300610001020001030001
      4100000000000000018200000000000000010000000000000103000100000137
      0000000000000001810000000000000001000000000000010300010000012F00
      0000000000000180000000000000000100000000000001030001000001210000
      000000000001720000000000000001000000000000010300010000011B000000
      0000000001710000000000000001000000000000010300010000011200000000
      0000000157000000000000000100000000000001030001000001090000000000
      0000015400000000000000010000000000000103000100000142000000000000
      0001820000000000000001000000000000010400010000013800000000000000
      0181000000000000000100000122000000310035003000350039003900320036
      00320030005F00320030003100370030003900320031005F0031003100320033
      00350038005F003300370038002E0070006E0067000123000000310035003000
      35003900390032003600320030005F0032003000310037003000390032003100
      5F003100310032003300350038005F0033003700380052002E006A0070006700
      012300000031003500300035003900390032003600320030005F003200300031
      00370030003900320031005F003100310032003300350038005F003300370038
      0053002E006A0070006700011800000025BC74C72000C8C0B4C598B000ACC0C9
      20004AC58CAC200074C764C4DCC28CAC5CB82000E0AC15C874D50DC9C8B2E4B2
      0104000103000130000000000000000180000000000000000100000000000001
      0400010000012200000000000000017200000000000000010000000000011300
      000060C538D615BC44C7200039BA30AE8BC840C720006CD030AE5CB8200098C7
      7CB7FCC838C194C6010400010200011C00000000000000017100000000000000
      010000011B0000003100310033005F0032003000310037003000390032003000
      5F003100350035003900320037005F003500320034002E0070006E006700011C
      0000003100310033005F00320030003100370030003900320030005F00310035
      0035003900320037005F0035003200340052002E006A0070006700011C000000
      3100310033005F00320030003100370030003900320030005F00310035003500
      3900320037005F0035003200340053002E006A0070006700010F000000A0BC74
      C7E8CE44C7200078B187B978B187B920006CADCCC60DC9C8B2E4B20104000102
      0001130000000000000001570000000000000001000000000000010400010000
      010A000000000000000154000000000000000100000000000001040001000001
      4300000000000000018200000000000000010000000000010100000033000105
      0001030001390000000000000001810000000000000001000001220000003100
      3500300035003900390032003600320030005F00320030003100370030003900
      320031005F003100310032003300350038005F003800330031002E0070006E00
      6700012300000031003500300035003900390032003600320030005F00320030
      003100370030003900320031005F003100310032003300350038005F00380033
      00310052002E006A007000670001230000003100350030003500390039003200
      3600320030005F00320030003100370030003900320031005F00310031003200
      3300350038005F0038003300310053002E006A0070006700012100000004ACA5
      C72C002000C8B998B22C00200061C513C82C00200024C1D5D044C720001EC140
      C7200091C550B1A5C744C7200000C944BE74D5FCC838C194C620000D000A0001
      0500010400013100000000000000018000000000000000010000000000000105
      0001000001230000000000000001720000000000000001000000000000010500
      010000011D000000000000000171000000000000000100000000000001050001
      0000011400000000000000015700000000000000010000012200000031003500
      300035003200320037003100300032005F003200300031003700300039003100
      32005F003100340034003500340036005F003200330039002E0070006E006700
      012300000031003500300035003200320037003100300032005F003200300031
      00370030003900310032005F003100340034003500340036005F003200330039
      0052002E006A0070006700012300000031003500300035003200320037003100
      300032005F00320030003100370030003900310032005F003100340034003500
      340036005F0032003300390053002E006A0070006700010400000053B074C738
      C194C6010500010200010B000000000000000154000000000000000100000000
      0000010500010000013A00000000000000018100000000000000010000000000
      010F00000091C550B1A5C7FCAC200024C6D5C9B4C57CB9200070C824B80DC9C8
      B2E4B20106000105000132000000000000000180000000000000000100000000
      0000010600010000012400000000000000017200000000000000010000012200
      000031003500300035003900320035003800310037005F003200300031003700
      30003900320030005F003100360035003000310031005F003600300037002E00
      70006E006700012300000031003500300035003900320035003800310037005F
      00320030003100370030003900320030005F003100360035003000310031005F
      0036003000370052002E006A0070006700012300000031003500300035003900
      320035003800310037005F00320030003100370030003900320030005F003100
      360035003000310031005F0036003000370053002E006A007000670001160000
      003CBB3300F5CED0C52000C8C0B0C613C820005CD518C200C87CB92000ECB4CD
      BF200023B1B4C50DC9C8B2E4B201060001030001170000000000000001540000
      0000000000010000000000000106000100000116000000000000000157000000
      0000000001000000000000010600010000013B00000000000000018100000000
      0000000100000000000001070001000001330000000000000001800000000000
      0000010000000000000107000100000125000000000000000172000000000000
      0001000000000000010700010000013C00000000000000018100000000000000
      010000000000013100000098C72000CCB324B8FCC870BA200091C550B174C720
      00A4C270BAE4B48CAC200070C824B8FCC8E0AC20007DC5200035007E00360084
      BD200024C6D5C9B4C500AC2000E4B275C7E0AC0D000A0091C550B174C7200078
      C844C5E4B474BA200044C631C101080001060001260000000000000001720000
      0000000000010000012200000031003500300035003900320035003800310037
      005F00320030003100370030003900320030005F003100360035003000310031
      005F003900300039002E0070006E006700012300000031003500300035003900
      320035003800310037005F00320030003100370030003900320030005F003100
      360035003000310031005F0039003000390052002E006A007000670001230000
      0031003500300035003900320035003800310037005F00320030003100370030
      003900320030005F003100360035003000310031005F0039003000390053002E
      006A00700067000130000000C8C0B0C613C844C7200023B140C7200021C718C2
      00AC200053B030AEDCC291C758D574BA20000D000A00ADCC91C5E0AC94CD7CB9
      20001CC878C65CD5200098B038BAC0C9200000C944BE5CD52000ACC7CCB87CB9
      200023B1B4C50DC9C8B2E4B2010800010400013D000000000000000181000000
      0000000001000001220000003100350030003500390039003200360032003000
      5F00320030003100370030003900320031005F00310031003200330035003900
      5F003200370036002E0070006E00670001230000003100350030003500390039
      0032003600320030005F00320030003100370030003900320031005F00310031
      0032003300350039005F0032003700360052002E006A00700067000123000000
      31003500300035003900390032003600320030005F0032003000310037003000
      3900320031005F003100310032003300350039005F0032003700360053002E00
      6A0070006700011D00000039BA30AE8BC840C720006CD030AE5CB8200090C774
      B974BA200090C1D8B211C800B3A9C63CC75CB8C4B3200090C1C9C0C6C5B5C2C8
      B2E4B22E00010900010700}
    SortOptions = []
    SortedField = 'Seq'
    Left = 172
    Top = 536
    object memMethodSerial: TLargeintField
      FieldName = 'Serial'
    end
    object memMethodRecipe_Serial: TLargeintField
      FieldName = 'Recipe_Serial'
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
    object memMethodExplainSeq: TSmallintField
      FieldName = 'ExplainSeq'
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
    object memMethodUsed: TBooleanField
      FieldName = 'Used'
    end
  end
  object sqlTemp: TFDQuery
    Connection = dmDB.FDConnection
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSeri' +
        'al ORDER BY Seq')
    Left = 170
    Top = 612
    ParamData = <
      item
        Name = 'RecipeSerial'
        ParamType = ptInput
      end>
  end
end
