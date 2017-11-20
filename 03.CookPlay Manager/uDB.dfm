object dmDB: TdmDB
  OldCreateOrder = False
  Height = 637
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
    Left = 44
    Top = 34
  end
  object tblCategory: TFDTable
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
    Filter = 'Deleted=0'
    IndexFieldNames = 'Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'Recipe'
    TableName = 'Recipe'
    Left = 48
    Top = 260
  end
  object dsRecipe: TDataSource
    DataSet = tblRecipe
    Left = 46
    Top = 314
  end
  object tblRecipeIngredient: TFDTable
    Active = True
    IndexFieldNames = 'RecipeMethod_Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'RecipeIngredient'
    TableName = 'RecipeIngredient'
    Left = 136
    Top = 258
  end
  object dsRecipeIngredient: TDataSource
    DataSet = tblRecipeIngredient
    Left = 132
    Top = 312
  end
  object tblRecipeMethod: TFDTable
    Active = True
    IndexFieldNames = 'Recipe_Serial'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'RecipeMethod'
    TableName = 'RecipeMethod'
    Left = 238
    Top = 258
  end
  object dsRecipeMethod: TDataSource
    DataSet = tblRecipeMethod
    Left = 234
    Top = 312
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
      
        'select * from Category where categorytype='#39'RECIPEC'#39' and category' +
        'code<100 order by seq')
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
      
        'select * from Category where categorytype='#39'RECIPEC'#39' and category' +
        'code>=100 and categorycode<200 order by seq')
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
      
        'select * from Category where categorytype='#39'RECIPEC'#39' and category' +
        'code>=200 and categorycode<300 order by seq')
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
      
        'select * from Category where categorytype='#39'RECIPEC'#39' and category' +
        'code>=300 and categorycode<400 order by seq')
    Left = 506
    Top = 388
  end
  object dsCategoryRecipe3: TDataSource
    DataSet = sqlCategoryRecipe3
    Left = 506
    Top = 448
  end
  object tblDeleteImageQue: TFDTable
    IndexFieldNames = 'ImageName'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'DeleteImageQue'
    TableName = 'DeleteImageQue'
    Left = 662
    Top = 278
  end
  object sqlTemp: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '')
    Left = 666
    Top = 346
  end
  object sqlMakingLevel: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'MakingLevel'#39' and dele' +
        'ted=0 order by seq')
    Left = 44
    Top = 502
  end
  object dsMakingLevel: TDataSource
    DataSet = sqlMakingLevel
    Left = 44
    Top = 562
  end
  object sqlMakingTime: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'MakingTime'#39' and delet' +
        'ed=0 order by seq')
    Left = 146
    Top = 506
  end
  object dsMakingTime: TDataSource
    DataSet = sqlMakingTime
    Left = 146
    Top = 566
  end
  object sqlPictureType: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'PictureType'#39' and dele' +
        'ted=0 order by seq')
    Left = 272
    Top = 506
  end
  object dsPictureType: TDataSource
    DataSet = sqlPictureType
    Left = 272
    Top = 566
  end
  object sqlMyRecipe: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select *'
      '  from Recipe'
      
        ' where Deleted=0 and Users_Serial = :UserSerial and Serial <> :R' +
        'ecipeSerial'
      ' order by Title')
    Left = 512
    Top = 252
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end
      item
        Name = 'RECIPESERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsMyRecipe: TDataSource
    DataSet = sqlMyRecipe
    Left = 512
    Top = 312
  end
  object sqlMe: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select *'
      '  from Users'
      ' where Serial = :UserSerial')
    Left = 318
    Top = 100
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '1'
      end>
  end
  object dsMe: TDataSource
    DataSet = sqlMe
    Left = 318
    Top = 160
  end
  object sqlItemType: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'ItemType'#39' and deleted' +
        '=0 order by seq')
    Left = 506
    Top = 510
  end
  object dsItemType: TDataSource
    DataSet = sqlItemType
    Left = 506
    Top = 570
  end
  object sqlItemUnit: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'ItemUnit'#39' and deleted' +
        '=0 order by seq')
    Left = 612
    Top = 508
  end
  object dsItemUnit: TDataSource
    DataSet = sqlItemUnit
    Left = 612
    Top = 568
  end
  object sqlUser: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *'
      '  FROM Users'
      ' WHERE ID = :ID AND PWD = :Password')
    Left = 418
    Top = 250
    ParamData = <
      item
        Name = 'ID'
        DataType = ftWideString
        ParamType = ptInput
        Value = '1'
      end
      item
        Name = 'PASSWORD'
        DataType = ftWideString
        ParamType = ptInput
        Value = '1'
      end>
  end
  object dsUser: TDataSource
    DataSet = sqlUser
    Left = 418
    Top = 310
  end
  object sqlMethodType: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'MethodType'#39' and delet' +
        'ed=0 order by seq')
    Left = 688
    Top = 508
  end
  object dsMethodType: TDataSource
    DataSet = sqlMethodType
    Left = 688
    Top = 568
  end
  object sqlIngredientType: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select * from Category where categorytype='#39'ItemType'#39' and Categor' +
        'yCode < 2 and deleted=0 order by seq')
    Left = 398
    Top = 504
  end
  object dsIngredientType: TDataSource
    DataSet = sqlIngredientType
    Left = 398
    Top = 564
  end
end
