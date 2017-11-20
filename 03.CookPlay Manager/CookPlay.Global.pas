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

  TPictureType = record
  const
    still = 0;
    movie = 1;
  end;

  TMakingLevelType = record
  const
    level0 = 0;
    level1 = 1;
    level2 = 2;
  end;

  TMakingTimeType = record
  const
    level0 = 0;
    level1 = 1;
    level2 = 2;
    level3 = 3;
    level4 = 4;
  end;

  TRecipeType = record
  const
    etc = 999;
    unPublished = 0;
    publish = 1;
    unDeleted = 0;
    deleted = 1;
    weight_mg = 0;
    weight_g = 1;
    weight_kg = 2;
    weight_lbs = 3;
    weight_oz = 4;
    temperature_C = 20;
    time_sec = 10;
    notSeq = -1;
    notLinked = -1;
    ingredient = 0;
    ingredient_source = 1;
    ingredient_temperature=2;
    ingredient_time=3;
    firstSeq = 0;
    item0 = 0;
    methodExplain = 0;
    methodIngredient = 1;
    methodTime = 2;
    methodTemperature = 3;
    methodLinked = 9;
    feedStory = 0;
    feedRecipe = 1;
    feedCookbook = 2;
    methodStep = 0;
    methodPicture = 1;
  public
    Picture: TPictureType;
    MakingLevel: TMakingLevelType;
    MakingTime: TMakingTimeType;
  end;

const
  cKEY_NAME = '\Software\EastSeaSoftware\CookPlay\';
  BUCKET_USER = 'cookplay-users';
  BUCKET_RECIPE = 'cookplay-recipe';

  BUCKET_NAME = 'delphitest1';
  CompressionQuality = 70;

  DS_NONE = 'none';
  DS_INSERT = 'insert';
  DS_EDIT = 'update';
  DS_DELETE = 'delete';

var
  _SysInfo: TSysInfo;
  _type: TRecipeType;

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
