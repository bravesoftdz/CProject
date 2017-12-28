unit uMenuBottom;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal;

type
  TMenuButton = class
    recBody: TRectangle;
    txtTitle: TText;
    lineBar: TLine;
  public
    constructor Create;
  end;

  TfrmMenuBottom = class(TForm)
    Rectangle1: TRectangle;
    layoutBody: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure Rectangle1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    FCallbackRef: TCallbackRefFunc;
    FList: TStringList;

    procedure ClearControls;
    procedure DoTextMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  public
    { Public declarations }
    procedure Init(aItemList: TStringList; aCallbackRef: TCallbackRefFunc=nil);
  end;

var
  frmMenuBottom: TfrmMenuBottom;

implementation

{$R *.fmx}

{ TMenuBotton }

constructor TMenuButton.Create;
begin
  recBody := TRectangle.Create(frmMenuBottom.layoutBody);
  recBody.Parent := frmMenuBottom.layoutBody;
  recBody.Height := 56;
  recBody.Position.Y := 0;
  recBody.Align := TAlignLayout.Bottom;
  recBody.Stroke.Kind := TBrushKind.None;
  recBody.Fill.Color := TAlphaColorRec.White;

  lineBar := TLine.Create(recBody);
  lineBar.Parent := recBody;
  lineBar.LineType := TLineType.Top;
  lineBar.Height := 1;
  lineBar.Align := TAlignLayout.Top;
  lineBar.Stroke.Color := COLOR_GRAY_LINE;
  lineBar.Stroke.Thickness := 0.8;

  txtTitle := TText.Create(recBody);
  txtTitle.Parent := recBody;
  txtTitle.Align := TAlignLayout.Client;
  txtTitle.TextSettings.FontColor := COLOR_GRAY_UNSELECTED2;
  txtTitle.TextSettings.Font.Size := 16;

  txtTitle.OnMouseUp := frmMenuBottom.DoTextMouseUp;
end;

{ TfrmMenuBottom }

procedure TfrmMenuBottom.ClearControls;
begin
  while FList.Count > 0 do
  begin
    TMenuButton(FList.Objects[0]).recBody.DisposeOf;
    FList.Objects[0].DisposeOf;
    FList.Delete(0);
  end;
end;

procedure TfrmMenuBottom.DoTextMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  aList: TStringList;
begin
  if Assigned(frmMenuBottom.FCallbackRef) then
  begin
    aList := TStringList.Create;
    aList.Add(TText(Sender).Tag.ToString);

    FCallbackRef(aList);

    Close;
  end;
end;

procedure TfrmMenuBottom.FormCreate(Sender: TObject);
begin
  FList := TStringList.Create;
end;

procedure TfrmMenuBottom.Init(aItemList: TStringList;
  aCallbackRef: TCallbackRefFunc);
var
  i: integer;
  aItem: TMenuButton;
begin
  ClearControls;

  FCallbackRef := aCallbackRef;

  if Assigned(aItemList) then
    for i := aItemList.Count-1 downto 0 do
    begin
      aItem := TMenuButton.Create;
      aItem.txtTitle.Tag := i;
      aItem.txtTitle.Text := aItemList[i];

      FList.AddObject('', aItem);
    end;
end;

procedure TfrmMenuBottom.Rectangle1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Close;
end;

end.


