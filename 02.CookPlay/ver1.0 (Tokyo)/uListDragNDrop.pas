unit uListDragNDrop;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.StdCtrls, uGlobal, FMX.ScrollBox, FMX.Memo;

type
  TfrmListDragNDrop = class(TForm)
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    Layout12: TLayout;
    txtFormTitle: TText;
    imgGrab: TImage;
    GlowEffect1: TGlowEffect;
    recWhite: TRectangle;
    recBody: TRectangle;
    ImageList1: TImageList;
    btnDone: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure recBodyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recBodyMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure btnDoneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure layoutBackButtonClick(Sender: TObject);
  private
    { Private declarations }
    FGrab: Boolean; // 현재 움직이고 있는지 상태를 저장한다
    FMovingLayout: TLayout; // 현재 움직이고 있는 원래 Layout을 지정한다
    FOffset: TPointF;

    FList: TStringList;
    FScroll: TVertScrollBox;
    FCallBackFunc: TCallBackFunc;

    procedure ClearControls;

    procedure OnLayoutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  public
    { Public declarations }
    procedure Init(aTextList: TStringList; aCallBackFunc: TCallBackFunc);
  end;

var
  frmListDragNDrop: TfrmListDragNDrop;

implementation
uses cookplay.StatusBar;

{$R *.fmx}

procedure TfrmListDragNDrop.ClearControls;
var
  i: integer;
begin
  FGrab := False;

  imgGrab.Parent := frmListDragNDrop;
  imgGrab.Visible := False;
  recWhite.Parent := frmListDragNDrop;
  recWhite.Visible := False;

  if Assigned(FList) then
  begin
    for i := FList.Count-1 downto 0 do
    begin
      FList.Objects[i].DisposeOf;
      FList.Delete(i);
    end;
    FList.DisposeOf;
  end;

  if Assigned(FScroll) then
    FScroll.DisposeOf;
end;

procedure TfrmListDragNDrop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ClearControls;
end;

procedure TfrmListDragNDrop.FormCreate(Sender: TObject);
begin
  ClearControls;
end;

procedure TfrmListDragNDrop.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmListDragNDrop.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  FGrab := False;
end;

procedure TfrmListDragNDrop.Init(aTextList: TStringList;
  aCallBackFunc: TCallBackFunc);
var
  i, n: integer;
  aBodyLayout, aMovingLayout: TLayout;
  aText: TText;
  aMovingImage: TImage;
  aLine: TLine;
  nNextTopPosition: integer;
  tempMemo: TMemo;
  str: string;
begin
  ClearControls;

  FCallBackFunc := aCallBackFunc;

  FScroll := TVertScrollBox.Create(recBody);
  FScroll.Parent := recBody;
  FScroll.Align := TAlignLayout.Client;

  FList := TStringList.Create;

  nNextTopPosition := 0;
  for i := 0 to aTextList.Count-1 do
  begin
    aBodyLayout := TLayout.Create(FScroll);
    aBodyLayout.Parent := FScroll;
    aBodyLayout.Position.Y := nNextTopPosition;
    aBodyLayout.Height := 50;
    aBodyLayout.Align := TAlignLayout.Top;
    aBodyLayout.Tag := i; // 초기 리스트 순서를 저장, 0부터 시작한다

    nNextTopPosition := nNextTopPosition + 50;

    begin
      aText := TText.Create(aBodyLayout);
      aText.Parent := aBodyLayout;

      tempMemo := TMemo.Create(self);
      tempMemo.Parent := nil;
      tempMemo.Visible := False;
      tempMemo.Lines.Text := aTextList[i].Trim;

      for n := 0 to tempMemo.Lines.Count-1 do
        if n = 0 then
          str := tempMemo.Lines[0]
        else if n = 1 then
          str := str + ' ' + tempMemo.Lines[1];

      tempMemo.DisposeOf;

      if str.Length > 50 then
        aText.Text := copy(str, 1, 50) + '...'
      else
        aText.Text := str;

      aText.HitTest := False;
      aText.Margins.Left := 15;
//      aText.Margins.Right := 10;
      aText.Align := TAlignLayout.Client;
      aText.TextSettings.Font.Size := 14;
      aText.TextSettings.HorzAlign := TTextAlign.Leading;

      aMovingLayout := TLayout.Create(aBodyLayout);
      aMovingLayout.Parent := aBodyLayout;
      aMovingLayout.HitTest := True;
      aMovingLayout.Width := 70;
      aMovingLayout.Align := TAlignLayout.Right;

      aMovingLayout.OnMouseDown := OnLayoutMouseDown;

      begin
        aMovingImage := TImage.Create(aMovingLayout);
        aMovingImage.Parent := aMovingLayout;
        aMovingImage.HitTest := False;
        aMovingImage.Width := 32;
        aMovingImage.Height := 32;
        aMovingImage.Align := TAlignLayout.Center;
        aMovingImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(64,64), 0);
      end;

      aLine := TLine.Create(aBodyLayout);
      aLine.Parent := aBodyLayout;
      aLine.LineType := TLineType.Bottom;
      aLine.Height := 1;
      aLine.Stroke.Color := COLOR_UNDERBAR;
      aLine.Align := TAlignLayout.Bottom;
      aLine.BringToFront;
    end;

    FList.AddObject(i.ToString, aBodyLayout);
  end;
end;

procedure TfrmListDragNDrop.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListDragNDrop.OnLayoutMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMovingLayout := TLayout(TLayout(Sender).Parent);
  FMovingLayout.BringToFront;

  FOffset.X := X;
  FOffset.Y := Y;

  imgGrab.Parent := FScroll;
  imgGrab.Position.X := 0;
  imgGrab.Position.Y := FMovingLayout.Position.Y;
  imgGrab.Width := FMovingLayout.Width;
  imgGrab.Height := FMovingLayout.Height;
  imgGrab.Bitmap := FMovingLayout.MakeScreenshot;

  recWhite.Parent := FMovingLayout;
  recWhite.Position.X := 0;
  recWhite.Position.Y := 0;
  recWhite.Width := FMovingLayout.Width;
  recWhite.Height := FMovingLayout.Height;
  recWhite.BringToFront;
  recWhite.Visible := True;

  imgGrab.Visible := True;
  imgGrab.BringToFront;

  recBody.Root.Captured := recBody;

  FGrab := True;
  FScroll.AniCalculations.TouchTracking := [];
end;

procedure TfrmListDragNDrop.recBodyMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  TopPosition: Single;
  curY: Single;
begin
  if FGrab and (ssleft in Shift) then
  begin
    TopPosition := FScroll.ViewportPosition.Y;

    if Y < -20 then
      curY := (TopPosition -20)
    else if Y > (recBody.Height -40) then
      curY := TopPosition + recBody.Height - 40
    else
      curY := TopPosition + Y - FOffset.Y;

    imgGrab.Position.Y := curY;

    recBody.BeginUpdate;
    FMovingLayout.Position.Y := curY;
    recBody.EndUpdate;
  end;
end;

procedure TfrmListDragNDrop.recBodyMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FGrab := False;
  FScroll.AniCalculations.TouchTracking := [ttVertical];

  imgGrab.Parent := frmListDragNDrop;
  imgGrab.Visible := False;
  recWhite.Parent := frmListDragNDrop;
  recWhite.Visible := False;
end;

procedure TfrmListDragNDrop.btnDoneClick(Sender: TObject);
var
  strList: TStringList;
  i: integer;
  x, y: integer;
begin
  strList := TStringList.Create;

  for x := 0 to FList.Count-1 do
    for y := x+1 to FList.Count-1 do
      if TLayout(FList.Objects[x]).Position.Y > TLayout(FList.Objects[y]).Position.Y then
        FList.Exchange(x, y);

  for i := 0 to FList.Count-1 do
    strList.Add(TLayout(FList.Objects[i]).Tag.ToString);

  if Assigned(FCallBackFunc) then
    FCallBackFunc(strList);

  Close;
end;

end.



