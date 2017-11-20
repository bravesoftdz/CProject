program CookPlay;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  cookplay.StatusBar in '..\..\00.Library\cookplay.StatusBar.pas',
  uGlobal in 'uGlobal.pas',
  cookplay.Scale in '..\..\00.Library\cookplay.Scale.pas',
  uWeb in 'uWeb.pas' {frmWeb},
  uDB in 'uDB.pas' {DM: TDataModule},
  ClientClassesUnit in 'ClientClassesUnit.pas',
  ClientModuleUnit in 'ClientModuleUnit.pas' {CM: TDataModule},
  uRecipeEditor in 'uRecipeEditor.pas' {frmRecipeEditor},
  uSetup in 'uSetup.pas' {frmSetup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TCM, CM);
  Application.CreateForm(TfrmWeb, frmWeb);
  Application.Run;
end.
