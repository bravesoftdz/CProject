unit uTest;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  uGlobal, uCPScale, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmTest = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure DoScaleConnected(Sender: TObject);
    procedure DoScaleDisconnected(Sender: TObject);
    procedure DoScaleAuthorized(Sender: TObject);
    procedure DoNotScaleAuthorized(Sender: TObject);
    procedure DoScaleRead(const s: string);
    procedure DoScaleReadWeight(const AMessage: TWeightMessage);
    procedure DoScaleReadWeightChanged(const AMessage: TWeightMessage);
    procedure DoScaleNextButton(const AMessage: TWeightMessage);
    procedure DoResponse(AResult: TModalResult; AMessage: string);
  public
    { Public declarations }
  end;

var
  frmTest: TfrmTest;

implementation
{$R *.fmx}

{ TForm1 }

procedure TfrmTest.DoNotScaleAuthorized(Sender: TObject);
begin

end;

procedure TfrmTest.DoResponse(AResult: TModalResult; AMessage: string);
begin

end;

procedure TfrmTest.DoScaleAuthorized(Sender: TObject);
begin

end;

procedure TfrmTest.DoScaleConnected(Sender: TObject);
begin

end;

procedure TfrmTest.DoScaleDisconnected(Sender: TObject);
begin

end;

procedure TfrmTest.DoScaleNextButton(const AMessage: TWeightMessage);
begin

end;

procedure TfrmTest.DoScaleRead(const s: string);
begin

end;

procedure TfrmTest.DoScaleReadWeight(const AMessage: TWeightMessage);
var
  AWeight: double;
begin
  AWeight := AMessage.Weight;

  Label1.Text := (AWeight * 1000).ToString;
end;

procedure TfrmTest.DoScaleReadWeightChanged(const AMessage: TWeightMessage);
begin

end;

procedure TfrmTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(_Global.Scale) then
    _Global.Scale.EventsRestore
end;

procedure TfrmTest.FormShow(Sender: TObject);
begin
  if _Global.BluetoothLE.Enabled and Assigned(_Global.Scale) then
  begin
    _Global.Scale.EventsBackup;

    _Global.Scale.OnResponse := DoResponse;

    _Global.Scale.OnConnected := DoScaleConnected;
    _Global.Scale.OnDisconnected := DoScaleDisconnected;
    _Global.Scale.OnAuthorized := DoScaleAuthorized;
    _Global.Scale.OnNotAuthorized := DoNotScaleAuthorized;

    _Global.Scale.OnRead := DoScaleRead;
    _Global.Scale.OnWeight := DoScaleReadWeight;
    _Global.Scale.OnWeightChanged := DoScaleReadWeightChanged;
    _Global.Scale.OnNextButton := DoScaleNextButton;
  end;
end;

end.
