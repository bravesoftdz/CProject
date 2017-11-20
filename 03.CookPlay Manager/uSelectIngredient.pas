unit uSelectIngredient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, dxmdaset, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxDBEdit, cxLabel, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Vcl.Grids, Vcl.DBGrids, cxSpinEdit, Vcl.ExtCtrls;

type
  TfrmMethodSelectIngredient = class(TForm)
    memIngredient: TdxMemData;
    cxLabel7: TcxLabel;
    btnSave: TButton;
    Button2: TButton;
    dsIngredient: TDataSource;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    memIngredientSerial: TLargeintField;
    memIngredientRecipe_Serial: TLargeintField;
    memIngredientLinkedRecipe: TLargeintField;
    memIngredientSeq: TIntegerField;
    memIngredientIngredientType: TSmallintField;
    memIngredientTitle: TWideStringField;
    memIngredientAmount: TWideStringField;
    memIngredientUnit: TWideStringField;
    memIngredientWeightType: TSmallintField;
    memIngredientWeight: TIntegerField;
    memIngredientPictureType: TSmallintField;
    memIngredientPicture: TWideStringField;
    memIngredientPictureRectangle: TWideStringField;
    memIngredientPictureSquare: TWideStringField;
    memIngredientContents: TWideStringField;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxLabel8: TcxLabel;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FBeforeIngredientSerial: LargeInt;
  public
    { Public declarations }
  end;

var
  frmMethodSelectIngredient: TfrmMethodSelectIngredient;

implementation
uses uDB, uRecipe, Cookplay.Global;
{$R *.dfm}

procedure TfrmMethodSelectIngredient.btnSaveClick(Sender: TObject);
var
  serial: LargeInt;
begin
  serial := frmRecipe.memMethodRecipeIngredient_Serial.AsLargeInt;

  if serial = -1 then
    ShowMessage('재료를 선택하셔야 저장할 수 있습니다!')
  else
  begin
    if serial <> FBeforeIngredientSerial then
    begin
      frmRecipe.memIngredient.First;
      if frmRecipe.memIngredient.Locate('serial', FBeforeIngredientSerial, [loCaseInsensitive]) then
      begin
        frmRecipe.memIngredient.Edit;
        frmRecipe.memIngredientUsed.AsBoolean := False;
        frmRecipe.memIngredient.Post;
      end;

      frmRecipe.memIngredient.First;
      if frmRecipe.memIngredient.Locate('serial', serial, [loCaseInsensitive]) then
      begin
        frmRecipe.memIngredient.Edit;
        frmRecipe.memIngredientUsed.AsBoolean := True;
        frmRecipe.memIngredient.Post;
      end;
    end;

    ModalResult := mrOk;
  end;
end;

procedure TfrmMethodSelectIngredient.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmMethodSelectIngredient.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  memIngredient.Close;
end;

procedure TfrmMethodSelectIngredient.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfrmMethodSelectIngredient.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  Timer1.Enabled := False;

  FBeforeIngredientSerial := frmRecipe.memMethodRecipeIngredient_Serial.AsLargeInt;

  memIngredient.Open;

  frmRecipe.memIngredient.First;
  while not frmRecipe.memIngredient.Eof do
  begin
    // 사용안된 것과 해당 방법에서 사용된 것 만 보여준다
    if ((not frmRecipe.memIngredientUsed.AsBoolean) and (frmRecipe.memIngredientStateCur.AsString <> DS_DELETE))
      or (frmRecipe.memIngredientSerial.AsLargeInt = FBeforeIngredientSerial) then
    begin
      memIngredient.Insert;

      for i := 0 to memIngredient.FieldCount-1 do
        memIngredient.Fields[i].Value := frmRecipe.memIngredient.Fields[i].Value;

      memIngredient.Post;
    end;

    frmRecipe.memIngredient.Next;
  end;
end;

end.
