unit uScaleFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects, FMX.Layouts, uGlobal, cookplay.scale,
  System.Bluetooth, FMX.Controls.Presentation, FMX.Edit, FMX.EditBox,
  FMX.NumberBox;

type
  TScaleStatus = (ssConnecting, ssConnected, ssDisconnected, ssNotConnected);
  TScaleMessageType = (smtConnecting, smtConnected, smtDisconnected);

  TframeScale = class(TFrame)
    recGradient: TRectangle;
    Circle2: TCircle;
    arcBase: TArc;
    circleTarget: TCircle;
    linePosition: TLine;
    FloatAnimationLine: TFloatAnimation;
    circlePosition: TCircle;
    lineMaxPosition: TLine;
    ScaleScaledLayout: TScaledLayout;
    recZero: TRoundRect;
    Text1: TText;
    Layout1: TLayout;
    txtScaleWeight: TText;
    txtIngredientWeight: TText;
    txtUnit: TText;
    arcPosition: TArc;
    ColorAnimation1: TColorAnimation;
    txtIngredientExplain: TText;
    FloatAnimationArc: TFloatAnimation;
    txtUnit2: TText;
    Layout2: TLayout;
    layoutClose: TLayout;
    imgClose: TImage;
    layoutLongConnecting: TLayout;
    Layout4: TLayout;
    AniIndicatorConnecting: TAniIndicator;
    Text2: TText;
    layoutLongConnected: TLayout;
    Layout5: TLayout;
    Circle1: TCircle;
    Text3: TText;
    layoutLongDisconnected: TLayout;
    Layout6: TLayout;
    Circle3: TCircle;
    Text4: TText;
    Button1: TButton;
    Layout3: TLayout;
    Layout7: TLayout;
    recLongConnecting: TRectangle;
    recLongDisconnected: TRectangle;
    recLongConnected: TRectangle;
    Button2: TButton;
    procedure recZeroClick(Sender: TObject);
    procedure txtUnitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FScaleMeasureType: TScaleMeasureType;
    FIngredientWeight: Single;
    FWeight: Single;
    FWeightUnit: TIngredientUnit;

    FBeforeScaleEvents: TBluetoothLEEvents;

    FPositionAngle: Single;  // Position Angle

    procedure DisplayUnit;
    procedure DisplayWeight(const aWeight: Single);
    procedure movePosition(aPosition: Single);
    procedure HideMessageWindow;
    procedure ShowMessageWindow(aScaleMessageType: TScaleMessageType);

    procedure DoScaleConnected(Sender: TObject);
    procedure DoScaleDisconnected(Sender: TObject);
    procedure DoScaleAuthorized(Sender: TObject);
    procedure DoNotScaleAuthorized(Sender: TObject);
    procedure DoScaleRead(const s: string);
    procedure DoScaleReadWeight(const AMessage: TWeightMessage);
    procedure DoScaleReadWeightChanged(const AMessage: TWeightMessage);
    procedure DoScaleNextButton(const AMessage: TWeightMessage);
    procedure DoInfoChanged(Sender: TObject);
  public
    { Public declarations }
    procedure ResetControls;
    procedure Resize(aMeasureType: TScaleMeasureType);

    procedure OpenScale(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit);
    procedure CloseScale;
  end;
const
  Angle_ArcMin  = 0;
  Angle_ArcGood = 230;
  Angle_ArcMax  = 280;
  Angle_LineMin = -50;
  Angle_LineGood = 180;
  Angle_LineMax = 230;

  TIME_Discover = 3000;

implementation

{$R *.fmx}

procedure TframeScale.Button1Click(Sender: TObject);
begin
  if not _Scale.IsConnected then                   // 최초 연결시도
  begin
    ShowMessageWindow(TScaleMessageType.smtConnecting);
    BluetoothLE.DiscoverDevices(TIME_Discover);
  end
  else
    DoScaleConnected(self);
end;

procedure TframeScale.Button2Click(Sender: TObject);
begin
  HideMessageWindow;
end;

procedure TframeScale.CloseScale;
begin
  // 이전 이벤트 Restore
  _Scale.EventsRestore(FBeforeScaleEvents);
end;

procedure TframeScale.OpenScale(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit);
var
  aUnit: TIngredientUnit;
begin
  // 초기화 ------------------------------------------
  if not BluetoothLE.Enabled then
    BluetoothLE.Enabled := True;

  Resize(aScaleMeasureType);

  ResetControls;

  layoutClose.Visible := not (aScaleMeasureType = TScaleMeasureType.smplay);
  recLongConnecting.Visible := (aScaleMeasureType = TScaleMeasureType.smplay);
  recLongConnected.Visible := (aScaleMeasureType = TScaleMeasureType.smplay);
  recLongDisConnected.Visible := (aScaleMeasureType = TScaleMeasureType.smplay);

  FScaleMeasureType := aScaleMeasureType;

  txtIngredientExplain.Text := aIngredientText;
  txtIngredientWeight.Text := aIngredientWeight.ToString;

  // 측정하고자 하는 무게값 세팅
  FIngredientWeight := aIngredientWeight;
  FWeightUnit := aWeightUnit;

  if _info.login.scale.UserWeightUnit = TIngredientUnit.wuNone then
  begin
    _info.login.scale.UserWeightUnit := _scale.WeightUnit;
    _info.login.SaveInfo;
  end;

  DisplayUnit;
  DisplayWeight(0);

  // 이전 이벤트 Backup
  _Scale.EventsBackup(FBeforeScaleEvents);

  // 새로운 이벤트 세팅
  _Scale.OnConnected := DoScaleConnected;
  _Scale.OnDisconnected := DoScaleDisconnected;
  _Scale.OnAuthorized := DoScaleAuthorized;
  _Scale.OnNotAuthorized := DoNotScaleAuthorized;
  _Scale.OnRead := DoScaleRead;
  _Scale.OnWeight := DoScaleReadWeight;
  _Scale.OnWeightChanged := DoScaleReadWeightChanged;
  _Scale.OnNextButton := DoScaleNextButton;
  _Scale.OnInfoChangled := DoInfoChanged;

  if not _Scale.IsConnected then                   // 최초 연결시도
  begin
    ShowMessageWindow(TScaleMessageType.smtConnecting);
    BluetoothLE.DiscoverDevices(TIME_Discover);
  end
  else
    DoScaleConnected(self);
end;

procedure TframeScale.ResetControls;
begin
  FScaleMeasureType := TScaleMeasureType.smView;
  FWeight := 0;
  FIngredientWeight := 0;
  FPositionAngle := 0;

  txtIngredientExplain.Text := '';
  txtScaleWeight.Text := '';
  txtIngredientWeight.Text := '';

  layoutLongConnecting.Position := TPosition.Create(PointF(0, -layoutLongConnecting.Height));
  layoutLongConnected.Position := TPosition.Create(PointF(0, -layoutLongConnected.Height));
  layoutLongDisconnected.Position := TPosition.Create(PointF(0, -layoutLongDisconnected.Height));
end;

procedure TframeScale.Resize(aMeasureType: TScaleMeasureType);
var
  aSize, aRatio: Single;
begin
  case aMeasureType of
    smView: aSize := 100;
    smPlay: aSize := 190;
//    smPlay: aSize := 140;
    else aSize := 140;
  end;

  aRatio := (recGradient.Width - aSize) / ScaleScaledLayout.OriginalWidth;

  ScaleScaledLayout.Align := TAlignLayout.None;
  ScaleScaledLayout.Scale.X := aRatio;
  ScaleScaledLayout.Scale.Y := aRatio;
  ScaleScaledLayout.Align := TAlignLayout.Center;

  layoutLongConnecting.Width := recGradient.Width;
  layoutLongConnected.Width := recGradient.Width;
  layoutLongDisconnected.Width := recGradient.Width;

  recLongConnecting.Position := TPosition.Create(PointF(0,0));
  recLongConnecting.Width := layoutLongConnecting.Width;
  recLongConnecting.Height := layoutLongConnecting.Height;

  recLongConnected.Position := TPosition.Create(PointF(0,0));
  recLongConnected.Width := layoutLongConnected.Width;
  recLongConnected.Height := layoutLongConnected.Height;

  recLongDisconnected.Position := TPosition.Create(PointF(0,0));
  recLongDisconnected.Width := layoutLongDisconnected.Width;
  recLongDisconnected.Height := layoutLongDisconnected.Height;

end;

procedure TframeScale.txtUnitClick(Sender: TObject);
begin
  if _info.login.scale.UserWeightUnit = TIngredientUnit.wu01G then
    _info.login.scale.UserWeightUnit := TIngredientUnit.wuG
  else
    _info.login.scale.UserWeightUnit := TIngredientUnit.wu01G;

  _info.login.SaveInfo;

  DisplayUnit;
  DisplayWeight(FWeight);
end;

procedure TframeScale.ShowMessageWindow(aScaleMessageType: TScaleMessageType);
begin
  HideMessageWindow;

  case aScaleMessageType of
    smtConnecting: TAnimator.Create.AnimateFloat(layoutLongConnecting, 'Position.Y', 0, 0.5);
    smtConnected: TAnimator.Create.AnimateFloat(layoutLongConnected, 'Position.Y', 0, 0.5);
    smtDisconnected: TAnimator.Create.AnimateFloat(layoutLongDisconnected, 'Position.Y', 0, 0.5);
  end;
end;

procedure TframeScale.DisplayUnit;
  procedure HideUnit2;
  begin
    TAnimator.Create.AnimateFloat(txtUnit2, 'Opacity', 0.4, 0.1);
  end;
  procedure ShowUnit2;
  begin
    TAnimator.Create.AnimateFloat(txtUnit2, 'Opacity', 1, 0.1);
  end;
begin
  HideUnit2;
  case _info.login.scale.UserWeightUnit of
    TIngredientUnit.wu01G:
      begin txtUnit.Text := 'g'; ShowUnit2; end;
    TIngredientUnit.wuKg: txtUnit.Text := 'kg';
    TIngredientUnit.wuPound: txtUnit.Text := 'lb';
    TIngredientUnit.wuOunce: txtUnit.Text := 'oz';
    else
      txtUnit.Text := 'g';
  end;
end;

procedure TframeScale.DisplayWeight(const aWeight: Single);
  function GetDecimalDigit(aSmallWeight: Single): integer;
  var
    nP, nLen, i: integer;
  begin
    nP := aSmallWeight.ToString.IndexOf('.'); // abc.d -> return 3
    if np > -1 then
      result := aSmallWeight.ToString.Length - nP - 1  // length 5, return 3, 5 - 3- 1 = 1
    else
      result := 0;
  end;

  function GetWeightFormat(aCount: integer): string;
  var
    i: integer;
  begin
    if aCount > 0 then
      result := ',0.'
    else
      result := ',0';

    for i := 1 to aCount do
      result := result + '0';
  end;

  function ConvertWeightString(aSor, aTar: TIngredientUnit; aDisplayWeight: Single): string;
  begin
    case aSor of
      TIngredientUnit.wu01G:
        case aTar of
          TIngredientUnit.wuG: result := FormatFloat(GetWeightFormat(0), aDisplayWeight);
          TIngredientUnit.wuKg: result := FormatFloat(GetWeightFormat(4), aDisplayWeight * 0.001);
          TIngredientUnit.wuPound: result := FormatFloat(GetWeightFormat(5), aDisplayWeight * 0.0022046226218);
          TIngredientUnit.wuOunce: result := FormatFloat(GetWeightFormat(4), aDisplayWeight * 0.03527396195);
          else // 그외는 0.1g으로 처리
            result := FormatFloat(GetWeightFormat(1), aDisplayWeight);
        end;
      TIngredientUnit.wuKg:
        case aTar of
          TIngredientUnit.wu01G: result := FormatFloat(GetWeightFormat(1), aDisplayWeight * 1000);
          TIngredientUnit.wuKg, TIngredientUnit.wuNone: result := FormatFloat(GetWeightFormat(0), aDisplayWeight);
          TIngredientUnit.wuPound: result := FormatFloat(GetWeightFormat(1), aDisplayWeight * 2.2046226218);
          TIngredientUnit.wuOunce: result := FormatFloat(GetWeightFormat(1), aDisplayWeight * 35.27396195);
          else // 그외는 g으로 처리
             result := FormatFloat(GetWeightFormat(0), aDisplayWeight * 1000);
        end;
      TIngredientUnit.wuPound:
        case aTar of
          TIngredientUnit.wu01G: result := FormatFloat(GetWeightFormat(1), aDisplayWeight * 453.59237);
          TIngredientUnit.wuKg: result := FormatFloat(GetWeightFormat(2), aDisplayWeight * 0.45359237);
          TIngredientUnit.wuPound, TIngredientUnit.wuNone: result := FormatFloat(GetWeightFormat(0), aDisplayWeight);
          TIngredientUnit.wuOunce: result := FormatFloat(GetWeightFormat(0), aDisplayWeight * 16);
          else // 그외는 g으로 처리
            result := FormatFloat(GetWeightFormat(0), aDisplayWeight * 453.59237);
        end;
      TIngredientUnit.wuOunce:
        case aTar of
          TIngredientUnit.wu01G: result := FormatFloat(GetWeightFormat(1), aDisplayWeight * 28.349523125);
          TIngredientUnit.wuKg: result := FormatFloat(GetWeightFormat(3), aDisplayWeight * 0.028349523125);
          TIngredientUnit.wuPound: result := FormatFloat(GetWeightFormat(3), aDisplayWeight * 0.0625);
          TIngredientUnit.wuOunce, TIngredientUnit.wuNone: result := FormatFloat(GetWeightFormat(0), aDisplayWeight);
          else // 그외는 g으로 처리
            result := FormatFloat(GetWeightFormat(0), aDisplayWeight * 28.349523125);
        end;
      else // 그외는 모두 g으로 표시한다
        case aTar of
          TIngredientUnit.wu01G: result := FormatFloat(GetWeightFormat(1), aDisplayWeight);
          TIngredientUnit.wuKg: result := FormatFloat(GetWeightFormat(3), aDisplayWeight * 0.001);
          TIngredientUnit.wuPound: result := FormatFloat(GetWeightFormat(4), aDisplayWeight * 0.0022046226218);
          TIngredientUnit.wuOunce: result := FormatFloat(GetWeightFormat(3), aDisplayWeight * 0.03527396195);
          else // 그외는 g으로 처리
            result := FormatFloat(GetWeightFormat(0), aDisplayWeight);
        end;
    end;
  end;
var
  aScaleFormat, aIngredientFormat: string;
  aScaleDecimalDigits, aIngredientDecimalDigits: integer;
  aBaseScaleWeight, aBaseIngredientWeight: Single;
begin
  FWeight := aWeight;

  // 전자저울의 무게값과 재료의 무게 값을 보여준다
  txtScaleWeight.Text := ConvertWeightString(_info.login.scale.WeightUnit, _info.login.scale.UserWeightUnit, aWeight);
  txtIngredientWeight.Text := ConvertWeightString(FWeightUnit, _info.login.scale.UserWeightUnit, FIngredientWeight);

  aBaseScaleWeight := txtScaleWeight.Text.ToSingle;
  aBaseIngredientWeight := txtIngredientWeight.Text.ToSingle;

  // 재료무게 를 기준으로 Target Angle을 구한다
  FPositionAngle := (aBaseScaleWeight / aBaseIngredientWeight) * Angle_ArcGood;

  // Position 이 Max 값을 넘기면, Position을 Max 값에 고정시킨다
  if FPositionAngle > Angle_ArcMax then
    FPositionAngle := Angle_ArcMax;

  if FPositionAngle < 0 then
    FPositionAngle := 0;

  // Position 을 이동한다
  movePosition(FPositionAngle);

  if aBaseScaleWeight = aBaseIngredientWeight then
  begin
    circlePosition.Fill.Color := COLOR_SCALE_GOOD;
    circleTarget.Stroke.Color := COLOR_SCALE_GOOD;
  end
  else if aBaseScaleWeight < aBaseIngredientWeight then
  begin
    circlePosition.Fill.Color := COLOR_SCALE_NORMAL;
    circleTarget.Stroke.Color := COLOR_SCALE_NORMAL;
  end
  else
  begin
    circlePosition.Fill.Color := COLOR_SCALE_OVER;
    circleTarget.Stroke.Color := COLOR_SCALE_OVER;
  end;
end;

procedure TframeScale.recZeroClick(Sender: TObject);
begin
  ColorAnimation1.Start;
  // 전자저울 값을 0 으로 만든다
  _Scale.SendtoDevice(cmdMZ);
end;

procedure TframeScale.movePosition(aPosition: Single);
begin
  FloatAnimationArc.StopValue := aPosition + Angle_ArcMin; // ArcMin = 0;
  FloatAnimationArc.Start;

  if aPosition > Angle_ArcGood then // 동그라미는 Good position 에서 움직이지 않는다
    aPosition := Angle_ArcGood;

  FloatAnimationLine.StopValue := aPosition + Angle_LineMin; // LineMin = -50;
  FloatAnimationLine.Start;
end;

procedure TframeScale.DoInfoChanged(Sender: TObject);
begin
  // 이곳에서 사용자 저울 무게관련 정보를 저장한다 (iniFile)
  // 전자저울 단위는 바꾸지 않는다 - 처음에는 어떻하지?
  _info.login.scale.MaxWeight := _Scale.MaxWeight;
  _info.login.scale.SmallWeight := _Scale.SmallWeight;
  _info.login.scale.WeightUnit := _scale.WeightUnit;

  _info.login.SaveInfo;

  DisplayWeight(FWeight);
end;

procedure TframeScale.DoNotScaleAuthorized(Sender: TObject);
begin
//
end;

procedure TframeScale.DoScaleAuthorized(Sender: TObject);
begin
//
end;

procedure TframeScale.DoScaleConnected(Sender: TObject);
begin
  ShowMessageWindow(TScaleMessageType.smtConnected);
  _scale.SendtoDevice(cmdRW);
end;

procedure TframeScale.DoScaleDisconnected(Sender: TObject);
begin
  ShowMessageWindow(TScaleMessageType.smtDisconnected);
end;

procedure TframeScale.DoScaleNextButton(const AMessage: TWeightMessage);
begin
//
end;

procedure TframeScale.DoScaleRead(const s: string);
begin
//
end;

procedure TframeScale.DoScaleReadWeight(const AMessage: TWeightMessage);
begin
  DisplayWeight(aMessage.Weight * 1000);
//  txtScaleWeight.Text := FormatFloat('#,0.000', AMessage.Weight);
//  txtIngredientExplain.Text := AMessage.Text;
end;

procedure TframeScale.DoScaleReadWeightChanged(const AMessage: TWeightMessage);
begin
//
end;

procedure TframeScale.HideMessageWindow;
begin
  if layoutLongConnecting.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongConnecting, 'Position.Y', -layoutLongConnecting.Height, 0.3);


  if layoutLongConnected.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongConnected, 'Position.Y', -layoutLongConnected.Height, 0.3);

  if layoutLongDisconnected.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongDisconnected, 'Position.Y', -layoutLongDisconnected.Height, 0.3);
end;

end.
