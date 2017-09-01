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
  CookPlay.S3 in 'CookPlay.S3.pas' {dmS3: TDataModule};

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
  Application.Run;
end.
