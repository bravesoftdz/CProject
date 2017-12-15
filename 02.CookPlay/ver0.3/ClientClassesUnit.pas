//
// Created by the DataSnap proxy generator.
// 2017-12-07 ¿ÀÈÄ 9:41:37
//

unit ClientClassesUnit;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGetQueryLargeIntCommand: TDBXCommand;
    FGetQueryStringCommand: TDBXCommand;
    FUpdateQueryCommand: TDBXCommand;
    FGetCountCommand: TDBXCommand;
    FLastInsertIDCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetQueryLargeInt(AQuery: string; AFieldName: string): Int64;
    function GetQueryString(AQuery: string; AFieldName: string): string;
    function UpdateQuery(aQuery: string): Boolean;
    function GetCount(aQuery: string): Integer;
    function LastInsertID: Int64;
  end;

implementation

function TServerMethods1Client.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetQueryLargeInt(AQuery: string; AFieldName: string): Int64;
begin
  if FGetQueryLargeIntCommand = nil then
  begin
    FGetQueryLargeIntCommand := FDBXConnection.CreateCommand;
    FGetQueryLargeIntCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetQueryLargeIntCommand.Text := 'TServerMethods1.GetQueryLargeInt';
    FGetQueryLargeIntCommand.Prepare;
  end;
  FGetQueryLargeIntCommand.Parameters[0].Value.SetWideString(AQuery);
  FGetQueryLargeIntCommand.Parameters[1].Value.SetWideString(AFieldName);
  FGetQueryLargeIntCommand.ExecuteUpdate;
  Result := FGetQueryLargeIntCommand.Parameters[2].Value.GetInt64;
end;

function TServerMethods1Client.GetQueryString(AQuery: string; AFieldName: string): string;
begin
  if FGetQueryStringCommand = nil then
  begin
    FGetQueryStringCommand := FDBXConnection.CreateCommand;
    FGetQueryStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetQueryStringCommand.Text := 'TServerMethods1.GetQueryString';
    FGetQueryStringCommand.Prepare;
  end;
  FGetQueryStringCommand.Parameters[0].Value.SetWideString(AQuery);
  FGetQueryStringCommand.Parameters[1].Value.SetWideString(AFieldName);
  FGetQueryStringCommand.ExecuteUpdate;
  Result := FGetQueryStringCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.UpdateQuery(aQuery: string): Boolean;
begin
  if FUpdateQueryCommand = nil then
  begin
    FUpdateQueryCommand := FDBXConnection.CreateCommand;
    FUpdateQueryCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateQueryCommand.Text := 'TServerMethods1.UpdateQuery';
    FUpdateQueryCommand.Prepare;
  end;
  FUpdateQueryCommand.Parameters[0].Value.SetWideString(aQuery);
  FUpdateQueryCommand.ExecuteUpdate;
  Result := FUpdateQueryCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods1Client.GetCount(aQuery: string): Integer;
begin
  if FGetCountCommand = nil then
  begin
    FGetCountCommand := FDBXConnection.CreateCommand;
    FGetCountCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetCountCommand.Text := 'TServerMethods1.GetCount';
    FGetCountCommand.Prepare;
  end;
  FGetCountCommand.Parameters[0].Value.SetWideString(aQuery);
  FGetCountCommand.ExecuteUpdate;
  Result := FGetCountCommand.Parameters[1].Value.GetInt32;
end;

function TServerMethods1Client.LastInsertID: Int64;
begin
  if FLastInsertIDCommand = nil then
  begin
    FLastInsertIDCommand := FDBXConnection.CreateCommand;
    FLastInsertIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLastInsertIDCommand.Text := 'TServerMethods1.LastInsertID';
    FLastInsertIDCommand.Prepare;
  end;
  FLastInsertIDCommand.ExecuteUpdate;
  Result := FLastInsertIDCommand.Parameters[0].Value.GetInt64;
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetQueryLargeIntCommand.DisposeOf;
  FGetQueryStringCommand.DisposeOf;
  FUpdateQueryCommand.DisposeOf;
  FGetCountCommand.DisposeOf;
  FLastInsertIDCommand.DisposeOf;
  inherited;
end;

end.

