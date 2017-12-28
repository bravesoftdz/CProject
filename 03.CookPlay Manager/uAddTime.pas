unit uAddTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxDBEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxTimeEdit, cxLabel;

type
  TfrmAddTime = class(TForm)
    cxLabel4: TcxLabel;
    btnSave: TButton;
    btnCancel: TButton;
    cxLabel8: TcxLabel;
    cxTime: TcxTimeEdit;
    cxDBSpinEdit1: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxTitle: TcxTextEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddTime: TfrmAddTime;

implementation
uses uDB, uRecipe, cookplay.global;

{$R *.dfm}

procedure TfrmAddTime.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAddTime.btnSaveClick(Sender: TObject);
begin
  if cxTime.EditText = '00:00:00' then
    ShowMessage('시간을 입력하세요!')
  else if Trim(cxTitle.Text) = '' then
    ShowMessage('설명을 입력하세요!')
  else
  begin
    frmRecipe.memIngredientItemTimeValue.AsString := cxTime.EditText;
    ModalResult := mrOK;
  end;
end;

procedure TfrmAddTime.FormShow(Sender: TObject);
begin
  cxTime.Text := frmRecipe.memIngredientItemTimeValue.AsString;
  cxTitle.Text := frmRecipe.memIngredientTitle.AsString;
end;

end.
