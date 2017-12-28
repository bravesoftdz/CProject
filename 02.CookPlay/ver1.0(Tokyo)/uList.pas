unit uList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal, FMX.ListBox, Data.DB;

type
  TfrmList = class(TForm)
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    Layout12: TLayout;
    txtFormTitle: TText;
    ListBox: TListBox;
    ListBoxItem1: TListBoxItem;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure layoutBackButtonClick(Sender: TObject);
  private
    { Private declarations }
    FListType: TListType;
    FCallbackFunc: TCallbackFunc;

    procedure OnListboxItemClick(Sender: TObject);
    procedure OnImagePaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure MakeRecipeList;
  public
    { Public declarations }
    procedure Init(AListType: TListType; ATitle: string; ACallback: TCallbackFunc);
  end;

var
  frmList: TfrmList;

implementation
uses cookplay.StatusBar, ClientModuleUnit, FireDAC.Comp.Client, cookplay.S3;
{$R *.fmx}

procedure TfrmList.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmList.FormShow(Sender: TObject);
begin
  // Status Bar »öÀ» ¹Ù²Û´Ù
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  Timer1.Enabled := True;
end;

procedure TfrmList.Init(AListType: TListType; ATitle: string;
  ACallback: TCallbackFunc);
begin
  FListType := AListType;

  txtFormTitle.Text := ATitle;
  FCallbackFunc := ACallback;

  ListBox.Items.Clear;
end;

procedure TfrmList.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmList.MakeRecipeList;
var
  data: TFDMemTable;
  item: TListBoxItem;
  photo: TImage;
  title: TText;
begin
  ListBox.Items.Clear;
  ListBox.BeginUpdate;

  data := CM.memMyRecipe;
  if data.IsEmpty then
    Exit;

  data.First;
  while not data.eof do
  begin
    item := TListboxItem.Create(ListBox);
    item.StyleLookup := 'listboxitemnodetail';
    item.Selectable := True;
    item.OnClick := OnListboxItemClick;
    item.Height := 80;
    item.Tag := CM.memMyRecipeSerial.AsLargeInt; // Recipe Serial
    item.TagString := CM.memMyRecipeTitle.AsString; // Recipe Title

    item.Padding.Left := 20;
    item.Padding.Right := 20;
    item.Padding.Top := 5;
    item.Padding.Bottom := 5;

    // Recipe Image
    photo := TImage.Create(item);
    photo.Parent := item;
    photo.Width := 70;
    photo.Height := 70;
    photo.Align := TAlignLayout.Left;
    photo.HitTest := False;
    photo.TagString := CM.memMyRecipePictureSquare.AsString;
//    photo.OnPaint := OnImagePaint;
    frmS3.LoadImageFromS3(BUCKET_RECIPE, CM.memMyRecipePictureSquare.AsString, photo.Bitmap);

    // title
    title := TText.Create(item);
    title.Parent := item;
    title.HitTest := False;
    title.Margins.Left := 15;
    title.Align := TAlignLayout.Client;
    title.TextSettings.HorzAlign := TTextAlign.Leading;
    title.TextSettings.Font.Size := 16;
    title.Text := CM.memMyRecipeTitle.AsString;

    ListBox.AddObject(item);

    data.Next;
  end;

  ListBox.EndUpdate;
end;

procedure TfrmList.OnImagePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (Sender is TImage) and (not TImage(Sender).TagString.IsEmpty) then
  begin
    TThread.Synchronize(nil,
      procedure
      begin
        frmS3.LoadImageFromS3(BUCKET_RECIPE, TImage(Sender).TagString, TImage(Sender).Bitmap);
        TImage(Sender).TagString := '';
      end
    );
  end;
end;

procedure TfrmList.OnListboxItemClick(Sender: TObject);
var
  strList: TStringList;
begin
  strList := TStringList.Create;
  strList.Add(TListBoxItem(Sender).Tag.ToString);

  if Assigned(FCallbackFunc) then
    FCallbackFunc(strList);

  close;
end;

procedure TfrmList.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  case FListType of
    ltMyRecipe: MakeRecipeList;
  end;
end;

end.
