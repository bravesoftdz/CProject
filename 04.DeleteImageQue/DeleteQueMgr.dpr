program DeleteQueMgr;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMian};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMian, frmMian);
  Application.Run;
end.
