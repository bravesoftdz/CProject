unit uIngredient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  dxSkinXmas2008Blue, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDBEdit, cxMemo,
  Vcl.ExtCtrls, cxSpinEdit, Cookplay.Global, Data.DB;

type
  TfrmIngredient = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxLabel7: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxTitle: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBSpinEdit1: TcxDBSpinEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    btnClearLink: TButton;
    cxcboLinkedRecipe: TcxDBLookupComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnClearLinkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIngredient: TfrmIngredient;

implementation
uses uRecipe, uDB, CookPlay.S3;
{$R *.dfm}

procedure TfrmIngredient.btnCancelClick(Sender: TObject);
begin
  frmRecipe.memIngredient.Cancel;
  Close;
end;

procedure TfrmIngredient.btnClearLinkClick(Sender: TObject);
begin
  frmRecipe.memIngredientLinkedRecipe.AsLargeInt := -1;
end;

procedure TfrmIngredient.btnSaveClick(Sender: TObject);
begin
  if trim(frmRecipe.memIngredientTitle.AsString) = '' then
  begin
    ShowMessage('Title을 입력하십시오!');
    Exit;
  end;

  ModalResult := mrOK;
end;

end.
