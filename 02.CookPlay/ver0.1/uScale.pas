unit uScale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  uGlobal, uCPScale, FMX.Effects, uScaleConnect;

type
  TfrmScale = class(TForm)
    RectBase: TRectangle;
    Layout1: TLayout;
    PieBase: TPie;
    PieValue: TPie;
    Circle1: TCircle;
    ValueScale: TLabel;
    GetWeight: TText;
    LB_Unit: TLabel;
    Line1: TLine;
    RectBottom: TRectangle;
    BT_Send: TImage;
    RectTop: TRectangle;
    Rect_BT_ScaleSC: TRectangle;
    BT_Connect: TSpeedButton;
    Status_ScaleText: TText;
    FloatAni_Con: TFloatAnimation;
    IngreName: TText;
    RectHead: TRectangle;
    BT_CloseFrame: TImage;
    MTopText: TText;
    ToastLayout: TLayout;
    MessageRect: TRoundRect;
    ShadowEffect1: TShadowEffect;
    MsgText: TText;
    Timer1: TTimer;
    timeConnectScale: TTimer;
    Text1: TText;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BT_ConnectClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure timeConnectScaleTimer(Sender: TObject);
    procedure BT_SendClick(Sender: TObject);
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
    procedure ToastMessageActive(msg: string);
    procedure ToastMessageDeactive(msg: string);
    procedure ToastMessage(msg: string);
    procedure ConnectScale;
  public
    { Public declarations }
    MaxWeight : single;
  end;

var
  frmScale: TfrmScale;

implementation
{$R *.fmx}

{ TfrmScale }

procedure TfrmScale.BT_ConnectClick(Sender: TObject);
begin
  ConnectScale;
end;

{$REGION 'Scale Events'}
procedure TfrmScale.BT_SendClick(Sender: TObject);
begin
  _Global.Scale.SendtoDevice(cmdRW);
end;

procedure TfrmScale.ConnectScale;
begin
  BT_Connect.Enabled := False;
  Application.ProcessMessages;

  if _Global.Scale.IsConnected then
  begin
    _Global.Scale.DisconnectDevice;
    timeConnectScale.Enabled := True;
  end
  else
    timeConnectScale.OnTimer(timeConnectScale);
end;

procedure TfrmScale.DoNotScaleAuthorized(Sender: TObject);
begin
//
end;

procedure TfrmScale.DoResponse(AResult: TModalResult; AMessage: string);
begin
  if AResult = mrContinue then
    ToastMessageDeactive(AMessage)
  else
    ToastMessageActive(AMessage);
end;

procedure TfrmScale.DoScaleAuthorized(Sender: TObject);
begin
//
end;

procedure TfrmScale.DoScaleConnected(Sender: TObject);
begin
  ToastMessage('전자저울이 연결되었습니다!');

  BT_Connect.Enabled := True;

//  FloatAni_Con.Start;
  Status_ScaleText.Text := '전자저울 연결 되어 있습니다';

  _Global.Scale.SendtoDevice(cmdRW); // 초기 값을 가져온다
end;

procedure TfrmScale.DoScaleDisconnected(Sender: TObject);
begin
  ToastMessage('전자저울 연결이 종료되었습니다');

//  FloatAni_Con.Stop;
  Status_ScaleText.Text := '저울연결 되어있지 않습니다';

  PieValue.EndAngle := 0;
  ValueScale.Text := '0';
end;

procedure TfrmScale.DoScaleNextButton(const AMessage: TWeightMessage);
begin
//
end;

procedure TfrmScale.DoScaleRead(const s: string);
begin
//
end;

procedure TfrmScale.DoScaleReadWeight(const AMessage: TWeightMessage);
var
  AWeight: double;
begin
  AWeight := AMessage.Weight;

  case LB_Unit.Tag of
    1    : begin    // kg
             ValueScale.Text := Format('%3.03f', [AWeight]);
             PieValue.EndAngle := (AWeight * 300) / ( MaxWeight/1000 );    // 단위 kg
           end;
    1000 : begin    // g
             ValueScale.Text := (AWeight * 1000).ToString;
             PieValue.EndAngle := ( AWeight) * 300 / ( MaxWeight/1000 );    // 단위 kg
           end;
  end;

  if AWeight > ( MaxWeight/1000 * 0.5 ) then
  begin
     PieValue.Fill.Color  := $FFa0300e; // 무게초과
     ValueScale.FontColor := $FFa0300e;
  end
  else
  begin
    PieValue.Fill.Color  := TAlphaColorRec.Chocolate;
    ValueScale.FontColor := TAlphaColorRec.Chocolate;
  end;

  if PieValue.EndAngle > 300 then
     PieValue.EndAngle := 300
  else if PieValue.EndAngle < 0 then
    PieValue.EndAngle := 0;
end;

procedure TfrmScale.DoScaleReadWeightChanged(const AMessage: TWeightMessage);
begin
  // Changed;
end;
{$ENDREGION}

procedure TfrmScale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(_Global.Scale) then
    _Global.Scale.EventsRestore;
end;

procedure TfrmScale.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;


procedure TfrmScale.timeConnectScaleTimer(Sender: TObject);
begin
  timeConnectScale.Enabled := False;

  if not _Global.BluetoothDiscoverDevices then
    ToastMessageActive('전자저울을 찾을 수 없습니다!');
end;

procedure TfrmScale.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  // Toast Layout을 보이지 않게 한다
  ToastLayout.Opacity := 0;
  PieValue.EndAngle := 0;
  MaxWeight := 6000;  // 단위 g

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

    try
      // Discovery & Connect
      if _Global.Scale.IsConnected then
      begin
//        FloatAni_Con.Stop;
        Status_ScaleText.Text := '전자저울이 연결되어 있습니다';

        _Global.Scale.SendtoDevice(cmdRW) // 초기 값을 가져온다
      end
      else
        ConnectScale;
    except
      ToastMessage('블루투스를 연결할 수 없습니다!');
    end;
  end
  else
    ToastMessage('기기에 블루투스 장치가 활성화 되지 않았습니다!');
end;

procedure TfrmScale.ToastMessage(msg: string);
begin
  TThread.Synchronize(nil, procedure
    begin
      MsgText.Text := msg;
      ToastLayout.Opacity := 1.0;
      TAnimator.Create.AnimateFloatDelay( ToastLayout, 'Opacity', 0.0, 0.5, 1.0 );  // 사라지는시간, 보여준시간
    end
  );
end;

procedure TfrmScale.ToastMessageActive(msg: string);
begin
  BT_Connect.Enabled := True;
  ToastMessage(msg);
end;

procedure TfrmScale.ToastMessageDeactive(msg: string);
begin
  BT_Connect.Enabled := False;
  ToastMessage(msg);
end;

end.
