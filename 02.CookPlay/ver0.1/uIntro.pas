unit uIntro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uGlobal,
  system.Bluetooth, System.Bluetooth.Components, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects;

type
  TfrmIntro = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure ScaleEndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
  public
    { Public declarations }
  end;

var
  frmIntro: TfrmIntro;

implementation
uses uCPScale, uMain, uFacebook;
{$R *.fmx}

procedure TfrmIntro.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfrmIntro.ScaleEndDiscoverDevices(const Sender: TObject;
  const ADeviceList: TBluetoothLEDeviceList);
var
  i, k: integer;
begin
  if ADeviceList.Count < 1 then
  begin
    ShowMessage( 'CookPlay 전자울을 찾지 못했습니다!');
    Exit;
  end
  else
  begin
    for i:=0 to ADeviceList.Count-1 do
      for k := 0 to Length(BLE)-1 do
      begin
        if Uppercase(ADeviceList.Items[i].DeviceName) = UpperCase(BLE[k].DeviceName) then
        begin
          _Global.Scale.ConnectDevice(ADeviceList.Items[i]);
          Break;
        end;
      end;
  end;
end;

procedure TfrmIntro.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  try
    Application.CreateForm(TfrmMain, frmMain);
    Application.CreateForm(TfrmFacebook, frmFacebook);

    frmMain.Show;
    frmIntro.Visible := False;
  except
    ShowMessage('서비스 초기화에 실패앴습니다!');
    Close;
  end;
end;

end.
