program CookPlay_Manager;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  CookPlay.Global in 'CookPlay.Global.pas',
  uSetup in 'uSetup.pas' {frmSetup},
  uEncryption in 'uEncryption.pas',
  uDB in 'uDB.pas' {dmDB: TDataModule},
  uUser in 'uUser.pas' {frmUser},
  uRecipe in 'uRecipe.pas' {frmRecipe},
  CookPlay.S3 in 'CookPlay.S3.pas' {dmS3: TDataModule},
  uIngredient in 'uIngredient.pas' {frmIngredient},
  uExplain in 'uExplain.pas' {frmExplain},
  uSelectIngredient in 'uSelectIngredient.pas' {frmMethodSelectIngredient},
  uSelectRecipe in 'uSelectRecipe.pas' {frmSelectRecipe},
  uAddTime in 'uAddTime.pas' {frmAddTime},
  uAddTemperature in 'uAddTemperature.pas' {frmAddTemperature},
  uLogin in 'uLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TdmDB, dmDB);
  Application.CreateForm(TfrmUser, frmUser);
  Application.CreateForm(TfrmRecipe, frmRecipe);
  Application.CreateForm(TdmS3, dmS3);
  Application.CreateForm(TfrmIngredient, frmIngredient);
  Application.CreateForm(TfrmExplain, frmExplain);
  Application.CreateForm(TfrmMethodSelectIngredient, frmMethodSelectIngredient);
  Application.CreateForm(TfrmSelectRecipe, frmSelectRecipe);
  Application.CreateForm(TfrmAddTime, frmAddTime);
  Application.CreateForm(TfrmAddTemperature, frmAddTemperature);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
