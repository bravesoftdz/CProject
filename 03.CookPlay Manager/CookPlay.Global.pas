unit CookPlay.Global;

interface
uses Registry, Windows;

type
  TEditingMode = (edInsert, edUpdate);

  TDatabaseInfo = record
    DriverName: string;
    Server: string;
    Database: string;
    UserID: string;
    Password: string;
    Port: Integer;
  public
    procedure Init;
  end;

  TSysInfo = class
    Database: TDatabaseInfo;
  public
    constructor Create;
    function LoadSystemInformation: Boolean;
    function SaveSystemInformation: Boolean;
  end;

const
  cKEY_NAME = '\Software\EastSeaSoftware\CookPlay\';
  BUCKET_USER_NAME = 'cookplay-users';
  BUCKET_RECIPE_NAME = 'cookplay-recipe';

  BUCKET_NAME = 'delphitest1';
  CompressionQuality = 70;

var
  oSysInfo: TSysInfo;

implementation
uses uEncryption;
{ TSysInfo }

constructor TSysInfo.Create;
begin
  Database.Init;
  LoadSystemInformation;
end;

function TSysInfo.LoadSystemInformation: Boolean;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_CURRENT_USER;

  try
    if r.OpenKey(cKEY_NAME, False) then
    begin
      Database.DriverName := r.ReadString('Database.Drivername');
      Database.Server := r.ReadString('Database.Server');
      Database.Database := r.ReadString('Database.Database');
      Database.UserID := r.ReadString('Database.UserID');
      Database.Password := Decoding(r.ReadString('Database.Password'));
      Database.Port := r.ReadInteger('Database.Port');

      result := true;
    end
    else
      result := false;
  except
    result := false;
  end;

  r.CloseKey;
  r.Free;
end;

function TSysInfo.SaveSystemInformation: Boolean;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_CURRENT_USER;

  try
    r.OpenKey(cKEY_NAME, True);

    r.WriteString('Database.Drivername', Database.DriverName);
    r.WriteString('Database.Server', Database.Server);
    r.WriteString('Database.Database', Database.Database);
    r.WriteString('Database.UserID', Database.UserID);
    r.WriteString('Database.Password', Encoding(Database.Password));
    r.WriteInteger('Database.Port', Database.Port);

    result := true;
  except
    result := false;
  end;

  r.CloseKey;
  r.Free;
end;

{ TDatabaseInfo }

procedure TDatabaseInfo.Init;
begin
  DriverName := 'MySQL';
  Server := 'db2.cookplay.net';
  Database := 'cookplay';
  UserID := 'root';
  Password := 'cookpassword';
  Port := 3306;
end;

end.
