unit uDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.Dialogs, dxmdaset;

type
  TdmDB = class(TDataModule)
    FDConnection: TFDConnection;
    tblCategory: TFDTable;
    dsCategory: TDataSource;
    tblCategoryType: TFDTable;
    dsCategoryType: TDataSource;
    tblRecipe: TFDTable;
    dsRecipe: TDataSource;
    tblRecipeIngredient: TFDTable;
    dsRecipeIngredient: TDataSource;
    tblRecipeMethod: TFDTable;
    dsRecipeMethod: TDataSource;
    tblUsers: TFDTable;
    dsUsers: TDataSource;
    sqlCategoryUser: TFDQuery;
    dsCategoryUserlevel: TDataSource;
    sqlCategoryPicture: TFDQuery;
    dsCategoryPicture: TDataSource;
    sqlCategoryRecipe0: TFDQuery;
    dsCategoryRecipe0: TDataSource;
    sqlCategoryRecipe1: TFDQuery;
    dsCategoryRecipe1: TDataSource;
    sqlCategoryRecipe2: TFDQuery;
    dsCategoryRecipe2: TDataSource;
    sqlCategoryRecipe3: TFDQuery;
    dsCategoryRecipe3: TDataSource;
    tblDeleteImageQue: TFDTable;
    sqlTemp: TFDQuery;
    sqlMakingLevel: TFDQuery;
    dsMakingLevel: TDataSource;
    sqlMakingTime: TFDQuery;
    dsMakingTime: TDataSource;
    sqlPictureType: TFDQuery;
    dsPictureType: TDataSource;
    sqlMyRecipe: TFDQuery;
    dsMyRecipe: TDataSource;
    sqlMe: TFDQuery;
    dsMe: TDataSource;
    sqlItemType: TFDQuery;
    dsItemType: TDataSource;
    sqlItemUnit: TFDQuery;
    dsItemUnit: TDataSource;
    sqlUser: TFDQuery;
    dsUser: TDataSource;
    sqlMethodType: TFDQuery;
    dsMethodType: TDataSource;
    sqlIngredientType: TFDQuery;
    dsIngredientType: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
    function GetLastID: LargeInt;
    procedure AddtoDeleteImageQue(bucketname, objectname: string);
    function GetPicturenameSquare(RecipeSerial: LargeInt): string;
    function FindSerial(FieldName: string; Serial: LargeInt; ATable: TdxMemData): Boolean;
    function FindUser(sID, sPassword: string): Boolean;
    function FindNickname(sNickname: string): Boolean;
    function FindID(sID: string): Boolean;
    procedure WriteLinkToFeed(UserSerial: LongInt; LinkedType: integer; LinkedSerial: LongInt);
    procedure DeleteRecipeRecommendation(aRecipeSerial: LargeInt);
    procedure DeleteRecipeComment(aRecipeSerial: LargeInt);
    procedure DeleteCookbookRecipe(aRecipeSerial: LargeInt);
    procedure DeleteFeed(feedtype: integer; memRecipeSerial:LargeInt);
  end;

var
  dmDB: TdmDB;

implementation
uses CookPlay.Global;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDB }

procedure TdmDB.AddtoDeleteImageQue(bucketname, objectname: string);
begin
  tblDeleteImageQue.Insert;
  tblDeleteImageQue.FieldByName('BucketName').AsString := bucketname;
  tblDeleteImageQue.FieldByName('ImageName').AsString := objectname;
  tblDeleteImageQue.FieldByName('CreatedDate').AsDateTime := now;
  tblDeleteImageQue.Post;
end;

procedure TdmDB.DeleteCookbookRecipe(aRecipeSerial: LargeInt);
begin
  sqlTemp.SQL.Text := 'DELETE FROM CookbookRecipe WHERE Recipe_Serial=' + aRecipeSerial.ToString;
  sqlTemp.ExecSQL;
end;

procedure TdmDB.DeleteFeed(feedtype: integer; memRecipeSerial: LargeInt);
begin
  try
    try
      sqlTemp.Close;
      sqlTemp.SQL.Text := 'DELETE FROM Feed WHERE FeedType=' + feedType.ToString + ' AND LinkedSerial=' + memRecipeSerial.ToString;
      sqlTemp.ExecSQL;
    except
      raise Exception.Create('Error - Write Link to Feed');
    end;
  finally
    sqlTemp.Close;
  end;
end;

procedure TdmDB.DeleteRecipeComment(aRecipeSerial: LargeInt);
begin
  sqlTemp.SQL.Text := 'DELETE FROM RecipeComment WHERE Recipe_Serial=' + aRecipeSerial.ToString;
  sqlTemp.ExecSQL;
end;

procedure TdmDB.DeleteRecipeRecommendation(aRecipeSerial: LargeInt);
begin
  sqlTemp.SQL.Text := 'DELETE FROM RecipeRecommendation WHERE Recipe_Serial=' + aRecipeSerial.ToString;
  sqlTemp.ExecSQL;
end;

function TdmDB.FindID(sID: string): Boolean;
begin
  try
    sqlTemp.Open('SELECT * FROM Users WHERE ID = ''' + sID + '''');
  finally
    result := not sqlTemp.Eof;
    sqlTemp.Close;
  end;
end;

function TdmDB.FindNickname(sNickname: string): Boolean;
begin
  try
    sqlTemp.Open('SELECT * FROM Users WHERE Nickname = ''' + sNickname + '''');
  finally
    result := not sqlTemp.Eof;
    sqlTemp.Close;
  end;
end;

function TdmDB.FindSerial(FieldName: string; Serial: LargeInt; ATable: TdxMemData): Boolean;
begin
  result := False;

  ATable.First;
  while not ATable.eof do
  begin
    if ATable.FieldByName(FieldName).AsLargeInt = Serial then
    begin
      result := true;
      break;
    end;
    ATable.Next;
  end;
end;

function TdmDB.FindUser(sID, sPassword: string): Boolean;
begin
  try
    sqlUser.Close;
    sqlUser.ParamByName('ID').AsString := sID;
    sqlUser.ParamByName('Password').AsString := sPassword;
    sqlUser.Open;
  finally
    result := not sqlUser.Eof;
  end;
end;

function TdmDB.GetLastID: LargeInt;
begin
  try
    try
      sqlTemp.Open('SELECT LAST_INSERT_ID() AS LastID');
      result := sqlTemp.FieldByName('LastID').AsLargeInt;
    except
      result := -1;
    end;
  finally
    sqlTemp.Close;
  end;
end;

function TdmDB.GetPicturenameSquare(RecipeSerial: LargeInt): string;
begin
  try
    sqlTemp.Open('SELECT PictureSquare FROM Recipe WHERE Serial = ' + RecipeSerial.ToString);
    if sqlTemp.Eof then
      result := ''
    else
      result := sqlTemp.FieldByName('PictureSquare').AsString;
  except
    result := '';
  end;
end;

procedure TdmDB.Init;
var
  cnt: integer;
begin

  FDConnection.Close;

  FDConnection.Params.Clear;
  FDConnection.DriverName := _SysInfo.Database.DriverName;

  FDConnection.Params.Add('CharacterSet=utf8');
  FDConnection.Params.Add('Server=' + _SysInfo.Database.Server);
  FDConnection.Params.Add('Database=' + _SysInfo.Database.Database);
  FDConnection.Params.Add('User_Name=' + _SysInfo.Database.UserID);
  FDConnection.Params.Add('Password=' + _SysInfo.Database.Password);
  FDConnection.Params.Add('Port=' + _SysInfo.Database.Port.ToString);

  FDConnection.Open();

  for cnt := 0 to dmDB.ComponentCount-1 do
    if dmDB.Components[cnt] is TFDTable then
      (dmDB.Components[cnt] as TFDTable).Active := True
    else if (dmDB.Components[cnt] is TFDQuery) and (not TFDQuery(dmDB.Components[cnt]).SQL.Text.IsEmpty) then
      (dmDB.Components[cnt] as TFDQuery).Active := True;
end;

procedure TdmDB.WriteLinkToFeed(UserSerial: Integer; LinkedType: integer;
  LinkedSerial: LongInt);
begin
  try
    try
      sqlTemp.Close;
      sqlTemp.SQL.Clear;
      sqltemp.SQL.Add('INSERT INTO Feed');
      sqlTemp.SQL.Add('(Users_Serial, FeedType, LinkedSerial)');
      sqlTemp.SQL.Add('Values');
      sqlTemp.SQL.Add('(' + UserSerial.ToString +
                      ', ' + LinkedType.ToString +
                      ', ' + LinkedSerial.ToString +
                      ')');

      sqlTemp.ExecSQL;
    except
      raise Exception.Create('Error - Write Link to Feed');
    end;
  finally
    sqlTemp.Close;
  end;
end;

end.
