object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Cookplay Platform Manager'
  ClientHeight = 647
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object cxPageMain: TcxPageControl
    Left = 0
    Top = 0
    Width = 994
    Height = 647
    Align = alClient
    TabOrder = 0
    Visible = False
    Properties.ActivePage = cxTabSheet4
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 640
    ClientRectLeft = 4
    ClientRectRight = 987
    ClientRectTop = 31
    object cxTabSheet4: TcxTabSheet
      Caption = 'Recipe'
      ImageIndex = 3
      object cxGrid2: TcxGrid
        AlignWithMargins = True
        Left = 7
        Top = 48
        Width = 969
        Height = 554
        Margins.Left = 7
        Margins.Top = 7
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alClient
        TabOrder = 0
        object cxgRecipe: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsRecipe
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          EditForm.DefaultColumnCount = 4
          EditForm.DefaultStretch = fsHorizontal
          OptionsBehavior.EditAutoHeight = eahRow
          OptionsBehavior.EditMode = emInplaceEditForm
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object cxgRecipeSerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeUsers_Serial: TcxGridDBColumn
            DataBinding.FieldName = 'Users_Serial'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeUserName: TcxGridDBColumn
            DataBinding.FieldName = 'UserName'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeNickname: TcxGridDBColumn
            DataBinding.FieldName = 'Nickname'
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeTitle: TcxGridDBColumn
            DataBinding.FieldName = 'Title'
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipePictureType: TcxGridDBColumn
            DataBinding.FieldName = 'PictureType'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipePicture: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeCategory0: TcxGridDBColumn
            DataBinding.FieldName = 'Category0'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeCategory1: TcxGridDBColumn
            DataBinding.FieldName = 'Category1'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeCategory2: TcxGridDBColumn
            DataBinding.FieldName = 'Category2'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeCategory3: TcxGridDBColumn
            DataBinding.FieldName = 'Category3'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeItemName0: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName0'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeItemName1: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName1'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeItemName2: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName2'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeItemName3: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName3'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeMakingLevel: TcxGridDBColumn
            DataBinding.FieldName = 'MakingLevel'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeMakingTime: TcxGridDBColumn
            DataBinding.FieldName = 'MakingTime'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeServings: TcxGridDBColumn
            DataBinding.FieldName = 'Servings'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeHashcode: TcxGridDBColumn
            DataBinding.FieldName = 'Hashcode'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipeCreatedDate: TcxGridDBColumn
            DataBinding.FieldName = 'CreatedDate'
            HeaderAlignmentHorz = taCenter
          end
          object cxgRecipePublished: TcxGridDBColumn
            DataBinding.FieldName = 'Published'
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxgRecipeDeleted: TcxGridDBColumn
            DataBinding.FieldName = 'Deleted'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
        end
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
          DataController.DataSource = dmDB.dsRecipeMethodItem
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
          GridView = cxgRecipe
          object cxGrid2Level1: TcxGridLevel
            GridView = cxgRecipeIngredient
          end
          object cxGrid2Level4: TcxGridLevel
            GridView = cxgRecipeMethod
            object cxGrid2Level2: TcxGridLevel
              GridView = cxgRecipeMethodItem
            end
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object btnRecipeAdd: TButton
          Left = 7
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 0
          OnClick = btnRecipeAddClick
        end
        object btnRecipeUpdate: TButton
          Left = 88
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Update'
          TabOrder = 1
          OnClick = btnRecipeUpdateClick
        end
      end
    end
    object cxTabSheet7: TcxTabSheet
      Caption = 'Category'
      ImageIndex = 4
      object cxGrid3: TcxGrid
        AlignWithMargins = True
        Left = 7
        Top = 36
        Width = 969
        Height = 566
        Margins.Left = 7
        Margins.Top = 7
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alClient
        TabOrder = 0
        object cxgCategory: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsCategory
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          DataController.OnDetailExpanding = cxgCategoryDataControllerDetailExpanding
          EditForm.DefaultColumnCount = 4
          EditForm.MasterRowDblClickAction = dcaShowEditForm
          EditForm.DefaultStretch = fsHorizontal
          OptionsBehavior.EditMode = emInplaceEditForm
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object cxgCategorySerial: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgCategoryCategoryType: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryType'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'CategoryType'
            Properties.ListColumns = <
              item
                FieldName = 'CategoryName'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dmDB.dsCategoryType
            GroupIndex = 0
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxgCategoryCategoryCode: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryCode'
            HeaderAlignmentHorz = taCenter
            Width = 300
          end
          object cxgCategorySeq: TcxGridDBColumn
            DataBinding.FieldName = 'Seq'
            SortIndex = 1
            SortOrder = soAscending
            Width = 150
          end
          object cxgCategoryItemCode: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
          end
          object cxgCategoryItemName: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName'
            HeaderAlignmentHorz = taCenter
          end
          object cxgCategoryComment: TcxGridDBColumn
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
          end
          object cxgCategoryDeleted: TcxGridDBColumn
            DataBinding.FieldName = 'Deleted'
            HeaderAlignmentHorz = taCenter
            Width = 180
          end
        end
        object cxgCategoryDetail: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CategoryType;CategoryCode'
          DataController.MasterKeyFieldNames = 'CategoryType;CategoryCode'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          EditForm.DefaultStretch = fsHorizontal
          NewItemRow.Visible = True
          OptionsBehavior.EditMode = emInplaceEditForm
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridDBColumn6: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
          end
          object cxGridDBColumn7: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryType'
            Visible = False
          end
          object cxGridDBColumn8: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryCode'
            Visible = False
          end
          object cxGridDBColumn9: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
          end
          object cxGridDBColumn10: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName'
          end
        end
        object cxGridLevel3: TcxGridLevel
          GridView = cxgCategory
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object chkCategoryAllowInsert: TCheckBox
          Left = 7
          Top = 9
          Width = 97
          Height = 17
          Caption = 'Allow Insert'
          TabOrder = 0
          OnClick = chkCategoryAllowInsertClick
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Users'
      ImageIndex = 2
      object cxGrid1: TcxGrid
        AlignWithMargins = True
        Left = 7
        Top = 48
        Width = 969
        Height = 554
        Margins.Left = 7
        Margins.Top = 7
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alClient
        TabOrder = 0
        object cxGUser: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dmDB.dsUsers
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          DataController.OnDetailExpanding = cxgCategoryDataControllerDetailExpanding
          EditForm.DefaultColumnCount = 4
          EditForm.DefaultStretch = fsHorizontal
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object cxGUserNickname: TcxGridDBColumn
            DataBinding.FieldName = 'Nickname'
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 150
          end
          object cxGUserID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object cxGUserPwd: TcxGridDBColumn
            DataBinding.FieldName = 'Pwd'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object cxGUserNational: TcxGridDBColumn
            DataBinding.FieldName = 'National'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserBirthday: TcxGridDBColumn
            DataBinding.FieldName = 'Birthday'
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object cxGUserGender: TcxGridDBColumn
            DataBinding.FieldName = 'Gender'
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserIP: TcxGridDBColumn
            DataBinding.FieldName = 'IP'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserEmail: TcxGridDBColumn
            DataBinding.FieldName = 'Email'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserIntroduction: TcxGridDBColumn
            DataBinding.FieldName = 'Introduction'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserPicture: TcxGridDBColumn
            DataBinding.FieldName = 'Picture'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserSSO: TcxGridDBColumn
            DataBinding.FieldName = 'SSO'
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserCreatedDate: TcxGridDBColumn
            DataBinding.FieldName = 'CreatedDate'
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object cxGUserLastUpdatedDate: TcxGridDBColumn
            DataBinding.FieldName = 'LastUpdatedDate'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserWithdrawalDate: TcxGridDBColumn
            DataBinding.FieldName = 'WithdrawalDate'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGUserDeleted: TcxGridDBColumn
            DataBinding.FieldName = 'Deleted'
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object cxGUserLevel: TcxGridDBColumn
            DataBinding.FieldName = 'Level'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'ItemCode'
            Properties.ListColumns = <
              item
                FieldName = 'ItemName'
              end>
            Properties.ListSource = dmDB.dsCategory
            HeaderAlignmentHorz = taCenter
            Width = 55
          end
        end
        object cxGridDBTableView2: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CategoryType;CategoryCode'
          DataController.MasterKeyFieldNames = 'CategoryType;CategoryCode'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          EditForm.DefaultStretch = fsHorizontal
          NewItemRow.Visible = True
          OptionsBehavior.EditMode = emInplaceEditForm
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridDBColumn16: TcxGridDBColumn
            DataBinding.FieldName = 'Serial'
            Visible = False
          end
          object cxGridDBColumn17: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryType'
            Visible = False
          end
          object cxGridDBColumn18: TcxGridDBColumn
            DataBinding.FieldName = 'CategoryCode'
            Visible = False
          end
          object cxGridDBColumn19: TcxGridDBColumn
            DataBinding.FieldName = 'ItemCode'
          end
          object cxGridDBColumn20: TcxGridDBColumn
            DataBinding.FieldName = 'ItemName'
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGUser
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object btnUserAdd: TButton
          Left = 7
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 0
          OnClick = btnUserAddClick
        end
        object btnUserUpdate: TButton
          Left = 88
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Update'
          TabOrder = 1
          OnClick = btnUserUpdateClick
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 574
    Top = 2
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object Setup1: TMenuItem
      Caption = 'Setup'
      object mDatabse: TMenuItem
        Caption = 'Databse'
        OnClick = mDatabseClick
      end
    end
  end
  object dxSkinController1: TdxSkinController
    NativeStyle = False
    SkinName = 'Caramel'
    Left = 648
    Top = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 726
    Top = 4
  end
end
