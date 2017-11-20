unit uRecipeEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TfrmRecipeEditor = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    Button1: TButton;
    Rectangle2: TRectangle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecipeEditor: TfrmRecipeEditor;

implementation
uses uGlobal, cookplay.statusBar;
{$R *.fmx}

procedure TfrmRecipeEditor.Button1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmRecipeEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmRecipeEditor.FormShow(Sender: TObject);
begin
  // Status Bar »öÀ» ¹Ù²Û´Ù
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);
end;

procedure TfrmRecipeEditor.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

end.
