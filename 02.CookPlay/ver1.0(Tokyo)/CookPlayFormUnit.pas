unit CookPlayFormUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal;

type
  TCookPlayForm = class(TForm)
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    Layout12: TLayout;
    txtFormTitle: TText;
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CookPlayForm: TCookPlayForm;

implementation
uses cookplay.StatusBar;

{$R *.fmx}

procedure TCookPlayForm.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TCookPlayForm.FormShow(Sender: TObject);
begin
  // Status Bar »öÀ» ¹Ù²Û´Ù
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);
end;

procedure TCookPlayForm.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

end.
