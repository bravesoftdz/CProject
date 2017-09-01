unit uDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Dialogs, Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI;

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
    tblRecipeMethodItem: TFDTable;
    dsRecipeMethodItem: TDataSource;
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
    procedure tblCategoryBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
  end;

var
  dmDB: TdmDB;

implementation
uses CookPlay.Global;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDB }

procedure TdmDB.Init;
var
  cnt: integer;
begin

  FDConnection.Close;

  FDConnection.Params.Clear;
  FDConnection.DriverName := oSysInfo.Database.DriverName;

  FDConnection.Params.Add('CharacterSet=utf8');
  FDConnection.Params.Add('Server=' + oSysInfo.Database.Server);
  FDConnection.Params.Add('Database=' + oSysInfo.Database.Database);
  FDConnection.Params.Add('User_Name=' + oSysInfo.Database.UserID);
  FDConnection.Params.Add('Password=' + oSysInfo.Database.Password);
  FDConnection.Params.Add('Port=' + oSysInfo.Database.Port.ToString);

  FDConnection.Open();

  for cnt := 0 to dmDB.ComponentCount-1 do
    if dmDB.Components[cnt] is TFDTable then
      (dmDB.Components[cnt] as TFDTable).Active := True
    else if dmDB.Components[cnt] is TFDQuery then
      (dmDB.Components[cnt] as TFDQuery).Active := True;
end;

procedure TdmDB.tblCategoryBeforePost(DataSet: TDataSet);
begin
  tblCategory.FieldByName('ItemCode').AsString :=
    tblCategory.FieldByName('CategoryType').AsString +
    tblCategory.FieldByName('CategoryCode').AsString;
end;

end.
