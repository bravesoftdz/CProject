program CookPlayProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uIntro in 'uIntro.pas' {frmIntro},
  uGlobal in 'uGlobal.pas',
  uFacebook in 'uFacebook.pas' {frmFacebook},
  uMain in 'uMain.pas' {frmMain},
  uScale in 'uScale.pas' {frmScale},
  uFrameToastMessage in 'uFrameToastMessage.pas' {frameToastMessage: TFrame},
  uTest in 'uTest.pas' {frmTest},
  cookplay.StatusBar in 'cookplay.StatusBar.pas',
  uCPScale in '..\..\00.Library\uCPScale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmIntro, frmIntro);
  Application.CreateForm(TfrmScale, frmScale);
  Application.CreateForm(TfrmTest, frmTest);
  Application.Run;
end.
