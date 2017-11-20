unit ClientModuleUnit;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.DSConnect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Dialogs;

type
  TCM = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSFindUser: TClientDataSet;
    DSProviderConnection: TDSProviderConnection;
    memUser: TFDMemTable;
    memUserSerial: TLargeintField;
    memUserID: TStringField;
    memUserPwd: TStringField;
    memUserNational: TStringField;
    memUserBirthday: TStringField;
    memUserGender: TStringField;
    memUserIP: TStringField;
    memUserEmail: TStringField;
    memUserIntroduction: TStringField;
    memUserPicture: TStringField;
    memUserSSO: TBooleanField;
    memUserCreatedDate: TDateTimeField;
    memUserLastUpdatedDate: TDateTimeField;
    memUserWithdrawaldate: TDateTimeField;
    memUserWithdrawal: TBooleanField;
    memUserDeleted: TBooleanField;
    memUserLevel: TStringField;
    memUserNickname: TWideStringField;
    memUserName: TWideStringField;
    DSCount: TClientDataSet;
    DSSetup: TClientDataSet;
    DSSetupInsert: TClientDataSet;
    memUserAgreeMarketing: TBooleanField;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;

    function Login(email, password: string; var Msg: string): Boolean;
    procedure GetCount(UserSerial: LargeInt; var Follow, Follower, Recipe, Cookbook, Notice: integer);
    procedure GetSetup(UserSerial: LargeInt; var AlaramOn: Boolean);
    procedure SetSetup(UserSerial: LargeInt; AlaramOn: Boolean);

end;

var
  CM: TCM;

implementation
{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TCM.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TCM.Destroy;
begin
  FServerMethods1Client.Free;
  inherited;
end;

procedure TCM.GetCount(UserSerial: LargeInt; var Follow, Follower, Recipe, Cookbook, Notice: integer);
begin
  Follow := 0;
  Follower := 0;
  Recipe := 0;
  Cookbook := 0;

  try
    DSCount.Close;
    DSCount.ParamByName('UserSerial').Value := UserSerial;
    DSCount.Open;

    if not DSCount.IsEmpty then
    begin
      Follow := DSCount.FieldByName('FollowNo').AsInteger;
      Follower := DSCount.FieldByName('FollowerNo').AsInteger;
      Recipe := DSCount.FieldByName('RecipeNo').AsInteger;
      Cookbook := DSCount.FieldByName('CookbookNo').AsInteger;
      Notice := DSCount.FieldByName('NoticeNo').AsInteger;
    end;
  finally
    DSCount.Close;
    SQLConnection.Close;
  end;
end;

function TCM.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
  begin
    SQLConnection.Open;
    FServerMethods1Client:= TServerMethods1Client.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethods1Client;
end;

procedure TCM.GetSetup(UserSerial: LargeInt; var AlaramOn: Boolean);
begin
  AlaramOn := True;

  try
    DSSetup.Close;
    DSSetup.ParamByName('UserSerial').Value := UserSerial;
    DSSetup.Open;

    if not DSSetup.IsEmpty then
      AlaramOn := DSSetup.FieldByName('AlaramOn').AsBoolean;

  finally
    DSSetup.Close;
    SQLConnection.Close;
  end;
end;

function TCM.Login(email, password: string; var Msg: string): Boolean;
var
  i: integer;
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;

  memUser.Close;

  try
    try
      DSFindUser.Close;
      DSFindUSer.ParamByName('EMAIL').Value := email;
      DSFindUser.ParamByName('PWD').Value := password;
      DSFindUser.Open;

      if DSFindUser.IsEmpty then
      begin
        Msg := '잘못 입력하셨습니다!';
        result := False;
      end
      else
      begin
        memUser.Open;
        memUser.Insert;
        for i := 0 to DSFinduser.FieldCount-1 do
          if (DSFindUser.Fields[i].DataType = ftWideString) or (DSFindUser.Fields[i].DataType = ftString) then
            memUser.Fields[i].AsString := DSFindUser.Fields[i].AsString
//            memUser.Fields[i].AsString := UTF8Decode(DSFindUser.Fields[i].AsString)
          else
            memUser.Fields[i].Value := DSFindUser.Fields[i].Value;
        memUser.Post;

        result := True;
      end;
    except
      Msg := '에러가 발생했습니다!';
      memUser.Close;
      result := false;
    end;
  finally
    DSFindUser.Close;
    SQLConnection.Close;
  end;
end;

procedure TCM.SetSetup(UserSerial: LargeInt; AlaramOn: Boolean);
begin
  try
    DSSetup.Close;
    DSSetup.ParamByName('UserSerial').Value := UserSerial;
    DSSetup.Open;

    if not DSSetup.IsEmpty then
    begin
      DSSetup.Edit;
      DSSetup.FieldByName('AlaramOn').AsBoolean := AlaramOn;
      DSSetup.Post;
    end
    else if UserSerial >= 0 then
    begin
      DSSetupInsert.Close;
      DSSetupInsert.ParamByName('UserSerial').Value := UserSerial;
      DSSetupInsert.ParamByName('AlaramOn').Value := AlaramOn;
      DSSetupInsert.Execute;
    end;
  finally
    DSSetup.Close;
    DSSetupInsert.Close;
    SQLConnection.Close;
  end;
end;

end.
