unit uMain;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmMain = class(TForm)
    memoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddingLog(sLog: string);
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.AddingLog(sLog: string);
begin
  if memoLog.Lines.Count > 200 then
    memoLog.Lines.Clear;

  memoLog.Lines.Insert(0, sLog);

  memoLog.SelStart := Length(memoLog.Lines[0]);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memoLog.Clear;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AddingLog('Starting Server at (' + FormatDateTime( 'YYYY-MM-DD hh:mm:ss', now ) + ')');
end;

end.

