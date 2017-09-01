object dmDB: TdmDB
  OldCreateOrder = False
  Height = 607
  Width = 814
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=cookplay'
      'Password=cookpassword'
      'User_Name=root'
      'Server=db2.cookplay.net'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 42
    Top = 34
  end
  object tblCategory: TFDTable
    BeforePost = tblCategoryBeforePost
    IndexFieldNames = 'CategoryType;CategoryCode'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'Category'
    TableName = 'Category'
    Left = 138
    Top = 104
  end
  object dsCategory: TDataSource
    DataSet = tblCategory
    Left = 136
    Top = 158
  end
  object tblCategoryType: TFDTable
    IndexFieldNames = 'CategoryType'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'CategoryType'
    TableName = 'CategoryType'
    Left = 38
    Top = 102
  end
  object dsCategoryType: TDataSource
    DataSet = tblCategoryType
    Left = 40
    Top = 156
  end
  object tblRecipe: TFDTable
    Active = True
    IndexFieldNames = 'Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'cookplay.Recipe'
    TableName = 'cookplay.Recipe'
    Left = 48
    Top = 260
  end
  object dsRecipe: TDataSource
    DataSet = tblRecipe
    Left = 46
    Top = 314
  end
  object tblRecipeIngredient: TFDTable
    IndexFieldNames = 'Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'RecipeIngredient'
    TableName = 'RecipeIngredient'
    Left = 134
    Top = 258
  end
  object dsRecipeIngredient: TDataSource
    DataSet = tblRecipeIngredient
    Left = 132
    Top = 312
  end
  object tblRecipeMethod: TFDTable
    IndexFieldNames = 'Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'RecipeMethod'
    TableName = 'RecipeMethod'
    Left = 236
    Top = 258
  end
  object dsRecipeMethod: TDataSource
    DataSet = tblRecipeMethod
    Left = 234
    Top = 312
  end
  object tblRecipeMethodItem: TFDTable
    IndexFieldNames = 'Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'RecipeMethodItem'
    TableName = 'RecipeMethodItem'
    Left = 344
    Top = 256
  end
  object dsRecipeMethodItem: TDataSource
    DataSet = tblRecipeMethodItem
    Left = 342
    Top = 310
  end
  object tblUsers: TFDTable
    IndexFieldNames = 'Nickname'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'cookplay.Users'
    TableName = 'cookplay.Users'
    Left = 418
    Top = 102
  end
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 418
    Top = 156
  end
  object sqlCategoryUser: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'USER'#39)
    Left = 538
    Top = 100
  end
  object dsCategoryUserlevel: TDataSource
    DataSet = sqlCategoryUser
    Left = 540
    Top = 160
  end
  object sqlCategoryPicture: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'PICTURE'#39' order by seq')
    Left = 42
    Top = 386
  end
  object dsCategoryPicture: TDataSource
    DataSet = sqlCategoryPicture
    Left = 44
    Top = 446
  end
  object sqlCategoryRecipe0: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'RECIPEA'#39' order by seq')
    Left = 148
    Top = 384
  end
  object dsCategoryRecipe0: TDataSource
    DataSet = sqlCategoryRecipe0
    Left = 148
    Top = 444
  end
  object sqlCategoryRecipe1: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'RECIPEB'#39' order by seq')
    Left = 274
    Top = 382
  end
  object dsCategoryRecipe1: TDataSource
    DataSet = sqlCategoryRecipe1
    Left = 274
    Top = 442
  end
  object sqlCategoryRecipe2: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'RECIPEC'#39' order by seq')
    Left = 396
    Top = 386
  end
  object dsCategoryRecipe2: TDataSource
    DataSet = sqlCategoryRecipe2
    Left = 396
    Top = 446
  end
  object sqlCategoryRecipe3: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from Category where categorytype='#39'RECIPED'#39' order by seq')
    Left = 506
    Top = 388
  end
  object dsCategoryRecipe3: TDataSource
    DataSet = sqlCategoryRecipe3
    Left = 506
    Top = 448
  end
end
