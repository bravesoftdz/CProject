unit uTimerFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani, FMX.Layouts, uGlobal;

type
  TframeTimer = class(TFrame)
    Layout1: TLayout;
    ScaleScaledLayout: TScaledLayout;
    arcBase: TArc;
    arcPosition: TArc;
    FloatAnimationArc: TFloatAnimation;
    Circle2: TCircle;
    txtTime: TText;
    txtPlayStartPause: TText;
    lineMaxPosition: TLine;
    linePosition: TLine;
    circlePosition: TCircle;
    FloatAnimationLine: TFloatAnimation;
    layoutTop: TLayout;
    txtIngredientExplain: TText;
    layoutClose: TLayout;
    imgClose: TImage;
    txtTitle: TText;
    layoutViewAction: TLayout;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    txtViewStartPause: TText;
    Text4: TText;
    layoutTimer: TLayout;
    layoutPlayAction: TLayout;
    imgPlayActionNormal: TImage;
    FloatAnimationPlayAction: TFloatAnimation;
    procedure imgPlayActionNormalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TimerList: TStringList;
    FOnNextButton: TNotifyEvent;

    procedure Clear;
    procedure TimerOpen(aOnNextButton: TNotifyEvent);
    procedure TimerClose;
    procedure Resize(aMeasureType: TScaleMeasureType);
    procedure movePosition(aTitle: string; aCurTime, aTotalTime: Integer; aStart: Boolean);
    procedure ActionStart(aStart: Boolean);

    property OnNextButton: TNotifyEvent read FOnNextButton write FOnNextButton;
  end;

implementation
{$R *.fmx}

{ TframeTimer }

procedure TframeTimer.ActionStart(aStart: Boolean);
begin
  if aStart then
  begin
    txtPlayStartPause.Text := 'STOP';
    txtViewStartPause.Text := '정지';
  end
  else
  begin
    txtPlayStartPause.Text := 'START';
    txtViewStartPause.Text := '시작';
  end;
end;

procedure TframeTimer.Clear;
begin
  txtTitle.Text := '';
  txtTime.Text := INIT_TIME_STR;
  txtPlayStartPause.Visible := False;
  layoutViewAction.Visible := False;
  layoutPlayAction.Visible := False;
  layoutTop.Visible := False;

  ActionStart(False);
end;

procedure TframeTimer.imgPlayActionNormalClick(Sender: TObject);
begin
  if Assigned(FOnNextButton) then
    FOnNextButton(self);
end;

procedure TframeTimer.movePosition(aTitle: string; aCurTime, aTotalTime: Integer;
   aStart: Boolean);
var
  aRatio: Single;
  aHour, aMin, aSec: integer;
  aSignal: string;
begin
  if aCurTime < 0 then
    aSignal := '-'
  else
  begin
    aSignal := '';

    aRatio := 360 * ((aTotalTime - aCurTime) / aTotalTime);

    FloatAnimationArc.StopValue := -360 + aRatio;
    FloatAnimationArc.Start;

    FloatAnimationLine.StopValue := 90 + aRatio;
    FloatAnimationLine.Start;
  end;

  aHour := aCurTime div (60*60); // 시간을 구한다
  aMin := aCurTime div 60; // 분을 구한다
  aSec := aCurTime - (aHour * 60 * 60) - (aMin * 60);

  aHour := abs(aHour);
  aMin := abs(aMin);
  aSec := abs(aSec);

  txtTime.Text := aSignal + FormatFloat('00', aHour) + ':' + FormatFloat('00', aMin) + ':' + FormatFloat('00', aSec);

  if aTitle <> txtTitle.Text then
    txtTitle.Text := aTitle;

  ActionStart(aStart);
end;

procedure TframeTimer.Resize(aMeasureType: TScaleMeasureType);
var
  aSize, aRatio: Single;
begin
  if aMeasureType = smPlay then
    aSize := 160
  else
    asize := 100;

  aRatio := (layoutTimer.Width - aSize) / ScaleScaledLayout.OriginalWidth;

  ScaleScaledLayout.Align := TAlignLayout.None;
  ScaleScaledLayout.Scale.X := aRatio;
  ScaleScaledLayout.Scale.Y := aRatio;
  ScaleScaledLayout.Align := TAlignLayout.Center;

  txtPlayStartPause.Visible := (aMeasureType = smPlay);
  layoutViewAction.Visible := (aMeasureType = smViewMeasure);
  layoutPlayAction.Visible := (aMeasureType = smPlay);
  layoutTop.Visible := (aMeasureType = smViewMeasure);
  txtTitle.Visible := True;

  // Play 시의 Action Button 의 위치를 세팅한다
  layoutPlayAction.Margins.Top := (ScaleScaledLayout.OriginalHeight + 110) * aRatio;
end;

procedure TframeTimer.TimerClose;
begin
  FOnNextButton := nil;
end;

procedure TframeTimer.TimerOpen(aOnNextButton: TNotifyEvent);
begin
  FOnNextButton := aOnNextButton;
end;

end.
