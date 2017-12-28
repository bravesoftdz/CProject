unit uScaleFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects, FMX.Layouts, uGlobal, cookplay.scale,
  System.Bluetooth, FMX.Controls.Presentation, FMX.Edit, FMX.EditBox,
  FMX.NumberBox, System.StrUtils;

type
  TScaleStatus = (ssConnecting, ssConnected, ssDisconnected, ssNotConnected);
  TScaleMessageType = (smtNothing, smtConnecting, smtConnected, smtDisconnected);
  TPlayAction = (paConnecting, paNormal, paFit);

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
    txtViewIngredientExplain: TText;
    FloatAnimationArc: TFloatAnimation;
    layoutTop: TLayout;
    layoutClose: TLayout;
    imgClose: TImage;
    layoutLongConnecting: TLayout;
    Layout4: TLayout;
    AniIndicatorViewConnecting: TAniIndicator;
    Text2: TText;
    layoutLongConnected: TLayout;
    Layout5: TLayout;
    Circle1: TCircle;
    Text3: TText;
    layoutLongDisconnected: TLayout;
    Layout6: TLayout;
    Circle3: TCircle;
    Text4: TText;
    Layout3: TLayout;
    Layout7: TLayout;
    timerRW: TTimer;
    imgViewReconnecting: TImage;
    FloatAnimationViewReconnecting: TFloatAnimation;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    layoutViewAction: TLayout;
    recViewAction: TRoundRect;
    layoutPlayAction: TLayout;
    recPlayIngredientExplain: TRectangle;
    txtPlayIngredientExplain: TText;
    AniIndicatorPlayConnecting: TAniIndicator;
    imgPlayActionNormal: TImage;
    imgPlayActionFit: TImage;
    imgPlayActionReconnecting: TImage;
    FloatAnimationPlayReconnecting: TFloatAnimation;
    txtViewAction: TText;
    FloatAnimationPlayAction: TFloatAnimation;
    FloatAnimationScaleWeight: TFloatAnimation;
    FloatAnimationViewAction: TFloatAnimation;
    procedure recZeroClick(Sender: TObject);
    procedure timerRWTimer(Sender: TObject);
    procedure imgViewReconnectingClick(Sender: TObject);
    procedure FloatAnimationViewReconnectingFinish(Sender: TObject);
    procedure txtScaleWeightClick(Sender: TObject);
    procedure imgPlayActionReconnectingClick(Sender: TObject);
    procedure imgPlayActionNormalClick(Sender: TObject);
    procedure FloatAnimationScaleWeightFinish(Sender: TObject);
    procedure txtViewActionClick(Sender: TObject);
  private
    { Private declarations }
    FScaleMeasureType: TScaleMeasureType;
    FIngredientWeight: Single;
    FWeight: Single;
    FWeightUnit: TIngredientUnit;

    FOnNextButton: TWeightEvent;

    FBeforeScaleEvents: TBluetoothLEEvents;

    FPositionAngle: Single;  // Position Angle

    procedure DisplayUnit;
    procedure DisplayWeight(const aWeight: Single);
    procedure movePosition(aPosition: Single);
    procedure HideMessageWindow;
    procedure ShowMessageWindow(aScaleMessageType: TScaleMessageType);
    procedure SetControlWithScaleType(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit);
    procedure DisplayPlayAction(aPlayAction: TPlayAction);

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

    procedure ScaleOpen(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit; aOnNextButton: TWeightEvent);
    procedure ScaleNext(aIngredientText: string; aIngredientWeight: Single;
      aWeightUnit: TIngredientUnit);
    procedure CloseScale;

    property Weight: Single read FWeight;

    property OnNextButton: TWeightEvent read FOnNextButton write FOnNextButton;
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

procedure TframeScale.CloseScale;
begin
  // 이전 이벤트 Restore
  _Scale.EventsRestore(FBeforeScaleEvents);

  DisplayWeight(0);
end;

procedure TframeScale.ScaleOpen(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit; aOnNextButton: TWeightEvent);
var
  aUnit: TIngredientUnit;
begin
  // 초기화 ------------------------------------------
  if not BluetoothLE.Enabled then
    BluetoothLE.Enabled := True;

  FOnNextButton := aOnNextButton;

  Resize(aScaleMeasureType);

  ResetControls;

  SetControlWithScaleType(aScaleMeasureType, aIngredientText, aIngredientWeight, aWeightUnit);

  if _info.login.scale.UserWeightUnit = TIngredientUnit.wuNone then
  begin
    _info.login.scale.UserWeightUnit := _scale.WeightUnit;
    _info.login.SaveInfo;
  end;

  DisplayUnit;

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

  DisplayWeight(0);

  if not _Scale.IsConnected then
  begin
    // 블루투스가 켜 있어야 실행한다
    if BluetoothLE.CurrentManager.Current.ConnectionState = TBluetoothConnectionState.Connected then
    begin
      ShowMessageWindow(TScaleMessageType.smtConnecting);
      BluetoothLE.DiscoverDevices(TIME_Discover);
      timerRW.Enabled := True;
    end
    else
    begin
      ShowMessageWindow(TScaleMessageType.smtDisconnected);
      ShowMessage('블루투스 권한을 허용해 주십시오!');
    end;
  end
  else
    DoScaleConnected(self);
end;

procedure TframeScale.ResetControls;
begin
  FScaleMeasureType := TScaleMeasureType.smViewSetup;

  FWeight := 0;
  FIngredientWeight := 0;
  FPositionAngle := 0;

  recGradient.BeginUpdate;

  txtViewIngredientExplain.Text := '';
  txtPlayIngredientExplain.Text := '';
  txtScaleWeight.Text := '';
  txtIngredientWeight.Text := '';

  // Play 용 블루투스 연결 메시지 초기화
  layoutLongConnecting.Position := TPosition.Create(PointF(0, -layoutLongConnecting.Height));
  layoutLongConnected.Position := TPosition.Create(PointF(0, -layoutLongConnected.Height));
  layoutLongDisconnected.Position := TPosition.Create(PointF(0, -layoutLongDisconnected.Height));

  layoutLongConnecting.Visible := False;
  layoutLongConnected.Visible := False;
  layoutLongDisconnected.Visible := False;

  // 재료설명을 감춘다
  recPlayIngredientExplain.Visible := False;
  txtViewIngredientExplain.Visible := False;

  // 목표 무게 표시를 감춘다
  circleTarget.Visible := False;
  // 재료 무게 표시를 감춘다
  txtIngredientWeight.Visible := False;

  // Indicator 를 감춘다
  AniIndicatorPlayConnecting.Enabled := False;
  AniIndicatorViewConnecting.Enabled := False;
  AniIndicatorViewConnecting.Visible := False;

//  // 레시피 재료 이동 이미지를 숨긴다
//  imgPriorIngredient.Visible := False;
//  imgNextIngredient.Visible := False;

  // Play Action, View Action 버턴을 감춘다
  layoutPlayAction.Visible := False;
  layoutViewAction.Visible := False;

  // Play Action Image 들의 위치를 잡아준다
  imgPlayActionNormal.align := TAlignLayout.Center;
  imgPlayActionFit.Align := TAlignLayout.Center;
  imgPlayActionReconnecting.Align := TAlignLayout.Center;

  imgPlayActionNormal.Visible := False;
  imgPlayActionFit.Visible := False;
  imgPlayActionReconnecting.Visible := False;

  recGradient.EndUpdate;
end;

procedure TframeScale.Resize(aMeasureType: TScaleMeasureType);
var
  aSize, aRatio: Single;
begin
  if aMeasureType = smPlay then
    aSize := 160
  else
    asize := 100;

  if recGradient.Width < recGradient.Height then
    aRatio := (recGradient.Width - aSize) / ScaleScaledLayout.OriginalWidth
  else
    aRatio := (recGradient.Height - aSize) / ScaleScaledLayout.OriginalHeight;

  ScaleScaledLayout.Align := TAlignLayout.None;
  ScaleScaledLayout.Scale.X := aRatio;
  ScaleScaledLayout.Scale.Y := aRatio;
  ScaleScaledLayout.Align := TAlignLayout.Center;

  layoutLongConnecting.Width := recGradient.Width;
  layoutLongConnected.Width := recGradient.Width;
  layoutLongDisconnected.Width := recGradient.Width;

  // Play 시의 Action Button 의 위치를 세팅한다
  layoutPlayAction.Margins.Top := (ScaleScaledLayout.OriginalHeight + 80) * aRatio;
end;

procedure TframeScale.timerRWTimer(Sender: TObject);
begin
  // 처음 연결 시 무게값이 0이 아닐 경우, 무게값을 가져오기 위한 Timer
  // 처음 연결시 enable 되어서 0.5초 마다 'RW' 신호를 보내며,
  // 무게값이 올 경우 disable 시킨다
  if _Scale.IsConnected then
    _Scale.SendtoDevice(cmdRW);
end;

procedure TframeScale.txtScaleWeightClick(Sender: TObject);
begin
  FloatAnimationScaleWeight.Start;
end;

procedure TframeScale.txtViewActionClick(Sender: TObject);
begin
  FloatAnimationViewAction.Start;
end;

procedure TframeScale.ScaleNext(aIngredientText: string;
  aIngredientWeight: Single; aWeightUnit: TIngredientUnit);
begin
  // 측정하고자 하는 무게값 세팅
  FIngredientWeight := aIngredientWeight;
  FWeightUnit := aWeightUnit;

  txtPlayIngredientExplain.Text := aIngredientText;

  DisplayWeight(0);

  if _Scale.IsConnected then
    _Scale.SendtoDevice(cmdRW);
end;

procedure TframeScale.SetControlWithScaleType(aScaleMeasureType: TScaleMeasureType; aIngredientText: string;
      aIngredientWeight: Single; aWeightUnit: TIngredientUnit);
begin
  FScaleMeasureType := aScaleMeasureType;

  // 측정하고자 하는 무게값 세팅
  FIngredientWeight := aIngredientWeight;
  FWeightUnit := aWeightUnit;

  // Play 일 경우 Close image 를 보이지 않게 한다
  layoutTop.Visible := not (aScaleMeasureType = TScaleMeasureType.smplay);

  if FScaleMeasureType = TScaleMeasureType.smPlay then
  begin
    recPlayIngredientExplain.Visible := True;
    txtPlayIngredientExplain.Text := aIngredientText;

    txtIngredientWeight.Visible := True;

//    imgPriorIngredient.Visible := True;
//    imgNextIngredient.Visible := True;

    circleTarget.Visible := True;
  end
  else
  begin
    txtViewIngredientExplain.Visible := True;
    txtViewIngredientExplain.Text := aIngredientText;

    // View Action Image Setting
    case FScaleMeasureType of
      smViewRatio:
        begin
          recViewAction.Fill.Color := COLOR_GRAY_UNSELECTED1;
          recViewAction.HitTest := False;

          recViewAction.Width := 140;
          txtViewAction.Text := '무게 비율 변경';
          // Target 무게 표시를 보여준다
          circleTarget.Visible := True;
        end;
      smViewMeasure:
        begin
          recViewAction.Fill.Color := COLOR_ORANGE_UNSELECTED1;
          recViewAction.HitTest := True;

          recViewAction.Width := 120;
          recViewAction.HitTest := True;
          txtViewAction.Text := '적용';
        end;
    end;

    if FScaleMeasureType <> TScaleMeasureType.smViewSetup then
    begin
      circleTarget.Visible := True;
      txtIngredientWeight.Visible := True;

      layoutViewAction.Visible := True;
    end;
  end;
end;

procedure TframeScale.ShowMessageWindow(aScaleMessageType: TScaleMessageType);
begin
  HideMessageWindow;

  case aScaleMessageType of
    smtConnecting:
      begin
        if FScaleMeasureType = TScalemeasureType.smPlay then
        begin
          AniIndicatorPlayConnecting.Enabled := True;
          AniIndicatorPlayConnecting.Visible := True;
        end
        else
        begin
          AniIndicatorViewConnecting.Enabled := True;
          AniIndicatorViewConnecting.Visible := True;

          layoutLongConnecting.Visible := True;
          AniIndicatorViewConnecting.Enabled := True;
          TAnimator.Create.AnimateFloat(layoutLongConnecting, 'Position.Y', 0, 0.5);
        end;
      end;
    smtConnected:
      begin
        if FScaleMeasureType = TScalemeasureType.smPlay then
        begin
          AniIndicatorPlayConnecting.Enabled := False;
          AniIndicatorPlayConnecting.Visible := False;
          DisplayPlayAction(TPlayAction.paNormal);
        end
        else
        begin
          layoutLongConnected.Visible := True;
          TAnimator.Create.AnimateFloat(layoutLongConnected, 'Position.Y', 0, 0.5);
        end;
      end;
    smtDisconnected:
      begin
        if FScaleMeasureType = TScalemeasureType.smPlay then
          DisplayPlayAction(TPlayAction.paConnecting)
        else
        begin
          layoutLongDisconnected.Visible := True;
          TAnimator.Create.AnimateFloat(layoutLongDisconnected, 'Position.Y', 0, 0.5);
        end;
      end;
  end;
end;

procedure TframeScale.DisplayPlayAction(aPlayAction: TPlayAction);
begin
  layoutPlayAction.Visible := True;

  imgPlayActionNormal.Visible := (aPlayAction = TPlayAction.paNormal);
  imgPlayActionFit.Visible := (aPlayAction = TPlayAction.paFit);
  imgPlayActionReconnecting.Visible := (aPlayAction = TPlayAction.paConnecting);
end;

procedure TframeScale.DisplayUnit;
begin
  case _info.login.scale.UserWeightUnit of
    TIngredientUnit.wu01G: txtUnit.Text := 'g';
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
  aBaseIngredientWeight: Single;
  sTemp: string;
begin
  FWeight := aWeight;

  // 전자저울의 무게값과 재료의 무게 값을 보여준다
  txtScaleWeight.Text := ConvertWeightString(_info.login.scale.WeightUnit, _info.login.scale.UserWeightUnit, aWeight);
  txtIngredientWeight.Text := ConvertWeightString(FWeightUnit, _info.login.scale.UserWeightUnit, FIngredientWeight);

  // 무게값을 현재 상태에 맞추어 소수점 자리수를 정리한다
  // 천단위 구분을 삭제한 후 Single 로 만든다
  sTemp := ReplaceStr(txtScaleWeight.Text, ',', '');
  FWeight := sTemp.ToSingle;

  sTemp := ReplaceStr(txtIngredientWeight.Text, ',', '');
  aBaseIngredientWeight := sTemp.ToSingle;

  // 재료무게 를 기준으로 Target Angle을 구한다
  FPositionAngle := (FWeight / aBaseIngredientWeight) * Angle_ArcGood;

  // Position 이 Max 값을 넘기면, Position을 Max 값에 고정시킨다
  if FPositionAngle > Angle_ArcMax then
    FPositionAngle := Angle_ArcMax;

  if FPositionAngle < 0 then
    FPositionAngle := 0;

//  if FScaleMeasureType = TScaleMeasureType. then

  // Position 을 이동한다
  movePosition(FPositionAngle);

  // 무게비율변경일 때, 무게값이 0이면 바탕이 회색으로 바뀐다
  if recViewAction.Visible then
  begin
    if (FPositionAngle = 0) and (FScaleMeasureType = smViewRatio) then
    begin
      recViewAction.Fill.Color := COLOR_GRAY_UNSELECTED1;
      recViewAction.HitTest := False;
    end
    else
    begin
      recViewAction.Fill.Color := COLOR_ORANGE_UNSELECTED1;
      recViewAction.HitTest := True;
    end
  end;

  if FWeight = aBaseIngredientWeight then
  begin
    circlePosition.Fill.Color := COLOR_SCALE_GOOD;
    circleTarget.Stroke.Color := COLOR_SCALE_GOOD;

    // Play 상태일 때
    if imgPlayActionNormal.Visible then
    begin
      imgPlayActionNormal.Visible := False;
      imgPlayActionFit.Visible := True;
    end;
  end
  else
  begin
    // Play 상태일 때
    if imgPlayActionFit.Visible then
    begin
      imgPlayActionNormal.Visible := True;
      imgPlayActionFit.Visible := False;
    end;

    if FWeight < aBaseIngredientWeight then
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

  if cirCleTarget.Visible and (aPosition > Angle_ArcGood) then // 동그라미는 Good position 에서 움직이지 않는다
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

  _Scale.SendtoDevice(cmdRW);

  timerRW.Enabled := True;
end;

procedure TframeScale.DoScaleDisconnected(Sender: TObject);
begin
  ShowMessageWindow(TScaleMessageType.smtDisconnected);
end;

procedure TframeScale.DoScaleNextButton(const AMessage: TWeightMessage);
begin
  if Assigned(FOnNextButton) then
    FOnNextButton(AMessage);
end;

procedure TframeScale.DoScaleRead(const s: string);
begin
//
end;

procedure TframeScale.DoScaleReadWeight(const AMessage: TWeightMessage);
begin
  // 처음 연결 시 무게값이 0이 아닐 경우, 무게값을 가져오기 위한 Timer
  // 무게값을 가져오면 enabled = false 시킨다
  timerRW.Enabled := False;

  DisplayWeight(aMessage.Weight * 1000);
//  txtScaleWeight.Text := FormatFloat('#,0.000', AMessage.Weight);
//  txtIngredientExplain.Text := AMessage.Text;
end;

procedure TframeScale.DoScaleReadWeightChanged(const AMessage: TWeightMessage);
begin
//
end;

procedure TframeScale.FloatAnimationScaleWeightFinish(Sender: TObject);
begin
  if _info.login.scale.UserWeightUnit = TIngredientUnit.wu01G then
    _info.login.scale.UserWeightUnit := TIngredientUnit.wuG
  else
    _info.login.scale.UserWeightUnit := TIngredientUnit.wu01G;

  _info.login.SaveInfo;

  DisplayUnit;
  DisplayWeight(FWeight);
end;

procedure TframeScale.FloatAnimationViewReconnectingFinish(Sender: TObject);
begin
  if not _Scale.IsConnected then                   // 최초 연결시도
  begin
    imgPlayActionReconnecting.Opacity := 1;
    imgPlayActionReconnecting.Visible := False;

    if BluetoothLE.CurrentManager.Current.ConnectionState = TBluetoothConnectionState.Connected then
    begin
      ShowMessageWindow(TScaleMessageType.smtConnecting);
      BluetoothLE.DiscoverDevices(TIME_Discover);
    end
    else
    begin
      ShowMessageWindow(TScaleMessageType.smtDisconnected);
      ShowMessage('블루투스 권한을 허용해 주십시오!');
    end;
  end
  else
    DoScaleConnected(self);
end;

procedure TframeScale.HideMessageWindow;
begin
  // 모든 Indicator 를 감춘다
  AniIndicatorViewConnecting.Enabled := False;
  AniIndicatorViewConnecting.Visible := False;
  AniIndicatorPlayConnecting.Enabled := False;
  AniIndicatorPlayConnecting.Visible := False;

  // Message 를 감춘다
  if layoutLongConnecting.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongConnecting, 'Position.Y', -layoutLongConnecting.Height, 0.3);

  if layoutLongConnected.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongConnected, 'Position.Y', -layoutLongConnected.Height, 0.3);

  if layoutLongDisconnected.Position.Y = 0 then
    TAnimator.Create.AnimateFloat(layoutLongDisconnected, 'Position.Y', -layoutLongDisconnected.Height, 0.3);

  // Play 의 Indicator 와 Reconnecting Image를 감춘다
  imgPlayActionReconnecting.Visible := False;
end;

procedure TframeScale.imgPlayActionNormalClick(Sender: TObject);
begin
  FloatAnimationPlayAction.Start;
end;

procedure TframeScale.imgPlayActionReconnectingClick(Sender: TObject);
begin
  FloatAnimationPlayReconnecting.Start;
end;

procedure TframeScale.imgViewReconnectingClick(Sender: TObject);
begin
  FloatAnimationViewReconnecting.Start;
end;

end.
