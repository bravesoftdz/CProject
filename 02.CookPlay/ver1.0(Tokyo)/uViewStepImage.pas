unit uViewStepImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Gestures;

type
  TfrmViewStepImage = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    ImageBack: TImage;
    btnShare: TButton;
    ScrollBox: TScrollBox;
    imgView: TImage;
    GestureManager1: TGestureManager;
    Timer1: TTimer;
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FLastDistance: Integer;
    procedure ImageResize(aDistance: Integer; var aWidth: Single; var aHeight: Single);
  public
    { Public declarations }
    procedure Init(aImageName: String; aWidth, aHeight: Single);
  end;

var
  frmViewStepImage: TfrmViewStepImage;

implementation
uses uGlobal, cookplay.S3;
{$R *.fmx}

procedure TfrmViewStepImage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  imgView.Bitmap.Assign(nil);
end;

procedure TfrmViewStepImage.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  LObj: IControl;
  LImage: TImage;
  LImageCenter: TPointF;
  aWidth, aHeight: Single;
begin
  if EventInfo.GestureID = igiZoom then
  begin
    LObj := Self.ObjectAtPoint(ClientToScreen(EventInfo.Location));
    if LObj is TImage then
    begin
      if (not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags)) and
        (not(TInteractiveGestureFlag.gfEnd in EventInfo.Flags)) then
      begin
        { zoom the image }
        LImage := TImage(LObj.GetObject);
        LImageCenter := LImage.Position.Point + PointF(LImage.Width / 2,
          LImage.Height / 2);

        aWidth := LImage.Width;
        aHeight := LImage.Height;

        ImageResize((EventInfo.Distance - FLastDistance) * 3, aWidth, aHeight);

        LImage.Width := aWidth;
        LImage.Height := aHeight;

        if LImage.Width < (ScrollBox.Width/2) then
        begin
          ImageResize(Round((ScrollBox.Width/2) - aWidth), aWidth, aHeight);
          LImage.Width := aWidth;
          LImage.Height := aHeight;
        end;

        LImage.Position.X := LImageCenter.X - LImage.Width / 2;
        LImage.Position.Y := LImageCenter.Y - LImage.Height / 2;
      end;

      if TInteractiveGestureFlag.gfEnd in EventInfo.Flags then
        Timer1.Enabled := True;

      FLastDistance := EventInfo.Distance;
    end;
  end
  else if EventInfo.GestureID = igiDoubleTap then
  begin
    LObj := Self.ObjectAtPoint(ClientToScreen(EventInfo.Location));
    if LObj is TImage then
    begin
      LImage := TImage(LObj.GetObject);
      LImageCenter := LImage.Position.Point + PointF(LImage.Width / 2,
        LImage.Height / 2);

      aWidth := LImage.Width;
      aHeight := LImage.Height;

      if aWidth > aHeight then
      begin
        if aWidth < (ScrollBox.Width * 3) then
        begin
          ImageResize(Round((ScrollBox.Width * 3) - aWidth), aWidth, aHeight);
          LImage.Width := aWidth;
          LImage.Height := aHeight;
        end
        else
        begin
          ImageResize(Round(ScrollBox.Width - (ScrollBox.Width * 3)), aWidth, aHeight);
          LImage.Width := aWidth;
          LImage.Height := aHeight;
        end;
      end
      else
      begin
        if aHeight < (ClientHeight * 3) then
        begin
          ImageResize(Round((ScrollBox.Height * 3) - aHeight), aWidth, aHeight);
          LImage.Width := aWidth;
          LImage.Height := aHeight;
        end
        else
        begin
          ImageResize(Round(ScrollBox.Height - (ScrollBox.Height * 3)), aWidth, aHeight);
          LImage.Width := aWidth;
          LImage.Height := aHeight;
        end;
      end;

      LImage.Position.X := LImageCenter.X - LImage.Width / 2;
      LImage.Position.Y := LImageCenter.Y - LImage.Height / 2;
    end;
  end;
end;

procedure TfrmViewStepImage.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmViewStepImage.ImageResize(aDistance: Integer; var aWidth,
  aHeight: Single);
var
  d: integer;
begin
  d := aDistance;
  if aWidth > aHeight then
  begin
    aHeight := aHeight + (d * aHeight / aWidth);
    aWidth := aWidth + d;
  end
  else
  begin
    aWidth := aWidth + (d * aWidth / aHeight);
    aHeight := aHeight + d;
  end;
end;

procedure TfrmViewStepImage.Init(aImageName: String; aWidth, aHeight: Single);
begin
  frmS3.LoadImageFromS3Ref(BUCKET_RECIPE, aImageName, imgView.Bitmap,
    procedure
    begin
      aHeight := aHeight - Rectangle1.Height;

      if imgView.Bitmap.Width > imgView.Bitmap.Height then
      begin
        if imgView.Bitmap.Width < aWidth then
        begin
          imgView.Width := imgView.Bitmap.Width;
          imgView.Height := imgView.Bitmap.Height;
        end
        else
        begin
          imgView.Width := aWidth;
          imgView.Height := imgView.Bitmap.Height * (aWidth / imgView.Bitmap.Width);
        end;
      end
      else
      begin
        if imgView.Bitmap.Height < aHeight then
        begin
          imgView.Width := imgView.Bitmap.Width;
          imgView.Height := imgView.Bitmap.Height;
        end
        else
        begin
          imgView.Height := aHeight;
          imgView.Width := imgView.Bitmap.Width * (aHeight / imgView.Bitmap.Height);
        end;
      end;
    end
    );
end;

procedure TfrmViewStepImage.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewStepImage.Timer1Timer(Sender: TObject);
var
  aWidth, aHeight: Single;
begin
  Timer1.Enabled := False;

  aWidth := imgView.Width;
  aHeight := imgView.Height;

  if aWidth > aHeight then
  begin
    if aWidth < ScrollBox.Width then
    begin
      ImageResize(Round(ScrollBox.Width - aWidth), aWidth, aHeight);

      imgView.Width := aWidth;
      imgView.Height := aHeight;
    end
    else if aWidth > (ScrollBox.Width * 3) then
    begin
      ImageResize(Round((ScrollBox.Width * 3) - aWidth), aWidth, aHeight);

      imgView.Width := aWidth;
      imgView.Height := aHeight;
    end;
  end
  else
  begin
    if aHeight < ScrollBox.Height then
    begin
      ImageResize(Round(ScrollBox.Height - aHeight), aWidth, aHeight);

      imgView.Width := aWidth;
      imgView.Height := aHeight;
    end
    else if aHeight > (ScrollBox.Height * 3) then
    begin
      ImageResize(Round((ScrollBox.Height * 3) - aHeight), aWidth, aHeight);

      imgView.Width := aWidth;
      imgView.Height := aHeight;
    end;
  end;
end;

end.
