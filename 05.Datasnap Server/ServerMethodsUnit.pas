unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, FireDAC.Comp.DataSet;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    sqlFindUser: TFDQuery;
    dsFindUser: TDataSetProvider;
    sqlUserCount: TFDQuery;
    dsUserCount: TDataSetProvider;
    sqlSetup: TFDQuery;
    dsSetup: TDataSetProvider;
    sqlSetupInsert: TFDQuery;
    dsSetupInsert: TDataSetProvider;
    sqlCategory: TFDQuery;
    dsCategory: TDataSetProvider;
    sqlMyRecipe: TFDQuery;
    dsMyRecipe: TDataSetProvider;
    sqlQuery: TFDQuery;
    sqlMyMethod: TFDQuery;
    dsMyMethod: TDataSetProvider;
    sqlMyIngredient: TFDQuery;
    dsMyIngredient: TDataSetProvider;
    sqlDeleteQue: TFDQuery;
    dsDeleteQue: TDataSetProvider;
    sqlRecipeBest: TFDQuery;
    dsRecipeBest: TDataSetProvider;
    sqlRecipeRecent: TFDQuery;
    dsRecipRecent: TDataSetProvider;
    sqlRecipeCount: TFDQuery;
    dsRecipeCount: TDataSetProvider;
    sqlRecipe: TFDQuery;
    dsRecipe: TDataSetProvider;
    sqlvIngredientGroup: TFDQuery;
    dsvIngredientGroup: TDataSetProvider;
    sqlvRecipeComment: TFDQuery;
    dsRecipeComment: TDataSetProvider;
    sqlStep: TFDQuery;
    dsStep: TDataSetProvider;
    sqlIngredient: TFDQuery;
    dsIngredient: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetQueryLargeInt(AQuery, AFieldName: string): LargeInt;
    function GetQueryString(AQuery, AFieldName: string): string;
    function UpdateQuery(aQuery: string): Boolean;
    function GetCount(aQuery: string): integer;
    function LastInsertID: LargeInt;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetCount(aQuery: string): integer;
var
  BeforeActive: Boolean;
begin
  BeforeActive := FDConnection1.Connected;

  if not BeforeActive then
    FDConnection1.Connected := True;

  try
    sqlQuery.Open(AQuery);
  finally
    if sqlQuery.IsEmpty then
      result := 0
    else
      result := sqlQuery.RecordCount;

    sqlQuery.Close;
  end;

  FDConnection1.Connected := BeforeActive;
end;

function TServerMethods1.GetQueryLargeInt(AQuery, AFieldName: string): LargeInt;
var
  BeforeActive: Boolean;
begin
  BeforeActive := FDConnection1.Connected;

  if not BeforeActive then
    FDConnection1.Connected := True;

  try
    sqlQuery.Open(AQuery);
  finally
    if sqlQuery.IsEmpty then
      result := -1
    else
      result := sqlQuery.FieldByName(AFieldName).AsLargeInt;

    sqlQuery.Close;
  end;

  FDConnection1.Connected := BeforeActive;
end;

function TServerMethods1.GetQueryString(AQuery, AFieldName: string): string;
var
  BeforeActive: Boolean;
begin
  BeforeActive := FDConnection1.Connected;

  if not BeforeActive then
    FDConnection1.Connected := True;

  try
    sqlQuery.Open(AQuery);
  finally
    if sqlQuery.IsEmpty then
      result := ''
    else
      result := sqlQuery.FieldByName(AFieldName).AsString;

    sqlQuery.Close;
  end;

  FDConnection1.Connected := BeforeActive;
end;

function TServerMethods1.LastInsertID: LargeInt;
var
  BeforeActive: Boolean;
begin
  BeforeActive := FDConnection1.Connected;

  if not BeforeActive then
    FDConnection1.Connected := True;

  try
    sqlQuery.Close;
    sqlQuery.Open('SELECT LAST_INSERT_ID() AS LASTID');
  finally
    if sqlQuery.IsEmpty then
      result := -1
    else
      result := sqlQuery.FieldByName('LASTID').AsLargeInt;

    sqlQuery.Close;
  end;

  FDConnection1.Connected := BeforeActive;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.UpdateQuery(aQuery: string): Boolean;
var
  BeforeActive: Boolean;
begin
  BeforeActive := FDConnection1.Connected;

  if not BeforeActive then
    FDConnection1.Connected := True;

  try
    try
      sqlQuery.SQL.Text := aQuery;
      sqlQuery.ExecSQL;

      result := sqlQuery.RowsAffected > 0;
    except
      result := False;
    end;
  finally
    sqlQuery.Close;
  end;

  FDConnection1.Connected := BeforeActive;
end;

end.

