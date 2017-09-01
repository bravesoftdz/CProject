program CookPlayProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uIntro in 'uIntro.pas' {frmIntro},
  uGlobal in 'uGlobal.pas',
  uFacebook in 'uFacebook.pas' {frmFacebook},
  uCPScale in '..\00.Library\uCPScale.pas',
  uMain in 'uMain.pas' {frmMain},
  uScale in 'uScale.pas' {frmScale},
  uFrameToastMessage in 'uFrameToastMessage.pas' {frameToastMessage: TFrame},
  uTest in 'uTest.pas' {frmTest};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmIntro, frmIntro);
  Application.CreateForm(TfrmScale, frmScale);
  Application.CreateForm(TfrmTest, frmTest);
  Application.Run;
end.
