unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Bluetooth, System.Bluetooth.Components, uGlobal, uCPScale, uFacebook,
  FMX.Effects, FMX.Objects, FMX.Layouts, FMX.Ani, FMX.StdCtrls,
  System.ImageList, FMX.ImgList, FMX.Controls.Presentation, FMX.TabControl;

type
  TfrmMain = class(TForm)
    ImageList1: TImageList;
    Button1: TButton;
    tabControlLeftMenu: TTabControl;
    tabLeftMen: TTabItem;
    MenuRightRect: TRectangle;
    MenuLeftRect: TRectangle;
    Circle_UserImg: TCircle;
    MenuLayout2: TLayout;
    UIDText: TText;
    MenuLayout3: TLayout;
    BT_LoginCall: TRectangle;
    LoginCallText: TText;
    SignRect: TRectangle;
    SignText: TText;
    MenuLayout4: TLayout;
    Text3: TText;
    Line1: TLine;
    txtScale: TText;
    Line2: TLine;
    Line3: TLine;
    TabItem2: TTabItem;
    ToastLayout: TLayout;
    MessageRect: TRoundRect;
    ShadowEffect1: TShadowEffect;
    MsgText: TText;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuRightRectClick(Sender: TObject);
    procedure txtScaleClick(Sender: TObject);
    procedure Text3Click(Sender: TObject);
  private
    { Private declarations }
    procedure ToastMessage(msg: string);
    procedure LeftMenuOpen;
    procedure LeftMenuClose;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses uIntro, uScale, uTest;
{$R *.fmx}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  LeftMenuOpen;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmIntro.Close;
end;

{$REGION 'BackKey 눌렸을 때'}
// BackKey 가 눌렸을 때, 프로그램 종료
procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    if tabControlLeftMenu.Visible then
      LeftMenuClose
    else
    begin
      MessageDlg( '종료 하시겠습니까 ?',
                   TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
       procedure(const AResult: TModalResult)
       begin
         case AResult of
           mrYES : Close;
         end;
       end);
    end;
  end;
end;
{$ENDREGION}

procedure TfrmMain.FormResize(Sender: TObject);
begin
  tabControlLeftMenu.Position.X := 0;
  tabControlLeftMenu.Position.Y := 0;
  tabControlLeftMenu.Width  := frmMain.ClientWidth;
  tabControlLeftMenu.Height := frmMain.ClientHeight;
  tabControlLeftMenu.Padding.Bottom := 0;

  MenuLeftRect.Height := frmMain.ClientHeight;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  try
    // Toast Layout을 보이지 않게 한다
    ToastLayout.Opacity := 0;
    // Global Class를 초기화 한다
    _Global := TGlobal.Create(self);

    // Left Menu 정리
    tabControlLeftMenu.TabIndex := 0;
    tabControlLeftMenu.TabPosition := TTabPosition.None;

    LeftMenuClose;
  except
    ShowMessage('서비스 초기화에 실패앴습니다!');
    Close;
  end;
end;

{$REGION 'Left Menu'}
procedure TfrmMain.LeftMenuClose;
begin
  TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', MenuLeftRect.Width * -1, 0.25 );
  tabControlLeftMenu.Visible := False;
end;

procedure TfrmMain.LeftMenuOpen;
begin
  tabControlLeftMenu.Visible := True;
  TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', 0, 0.25 );
end;

procedure TfrmMain.MenuRightRectClick(Sender: TObject);
begin
  LeftMenuClose;
end;
{$ENDREGION}

{$REGION 'Toast Message'}
// Toast Message
procedure TfrmMain.Text3Click(Sender: TObject);
begin
  if Assigned(_Global.Scale) then
  begin
    frmTest.Show;
    LeftMenuClose;
  end;
end;

procedure TfrmMain.ToastMessage(msg: string);
begin
  ToastLayout.Width := frmMain.ClientWidth;
//  ToastLayout.Align := TAlignLayout.Center;
  MsgText.Text := msg;
  ToastLayout.Opacity := 1.0;
  TAnimator.Create.AnimateFloatDelay( ToastLayout, 'Opacity', 0.0, 0.5, 1.0 );  // 사라지는시간, 보여준시간
end;
{$ENDREGION}

procedure TfrmMain.txtScaleClick(Sender: TObject);
begin
  if Assigned(_Global.Scale) then
  begin
    frmScale.Show;
    LeftMenuClose;
  end;
end;

end.
