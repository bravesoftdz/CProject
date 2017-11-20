unit uAddTemperature;

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
  dxSkinXmas2008Blue, cxMaskEdit, cxSpinEdit, cxDBEdit, Vcl.StdCtrls,
  cxTextEdit, cxCurrencyEdit, cxLabel;

type
  TfrmAddTemperature = class(TForm)
    cxLabel5: TcxLabel;
    cxTemperature: TcxDBCurrencyEdit;
    btnCancel: TButton;
    btnSave: TButton;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxLabel8: TcxLabel;
    cxLabel1: TcxLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cxTemperaturePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddTemperature: TfrmAddTemperature;

implementation
uses uDB, uRecipe, cookplay.global;

{$R *.dfm}

procedure TfrmAddTemperature.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAddTemperature.btnSaveClick(Sender: TObject);
begin
  if (cxTemperature.EditValue = 0) or (trim(cxTemperature.EditingText) = '') then
    showmessage('온도를 입력하십시오!')
  else
    ModalResult := mrOK;
end;

procedure TfrmAddTemperature.cxTemperaturePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if DisplayValue > 999 then
  begin
    ShowMessage('온도가 너무 높습니다!');
    DisplayValue := 0;
    cxTemperature.SetFocus;
  end
  else if DisplayValue < -100 then
  begin
    ShowMessage('온도가 너무 낮습니다!');
    DisplayValue := 0;
    cxTemperature.SetFocus;
  end;

  Error := False;
end;

end.
