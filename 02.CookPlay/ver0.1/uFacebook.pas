unit uFacebook;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Client, REST.Authenticator.OAuth, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Controls.Presentation, FMX.WebBrowser,
  FMX.Layouts, REST.Utils, FMX.Objects, REST.json, FMX.TabControl, System.JSON,
  uGlobal;

type
  TfrmFacebook = class(TForm)
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    RESTRequest: TRESTRequest;
    OAuth2_Facebook: TOAuth2Authenticator;
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    WebBrowser: TWebBrowser;
    Timer1: TTimer;
    recBackground: TRectangle;
    Panel1: TPanel;
    lblCaption: TLabel;
    AniIndicator1: TAniIndicator;
    procedure WebBrowserShouldStartLoadWithRequest(ASender: TObject;
      const URL: string);
    procedure RESTRequestAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestHTTPProtocolError(Sender: TCustomRESTRequest);
    procedure WebBrowserDidFinishLoad(ASender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FAccessToken: string;
    procedure GetUserInfo;
  public
    { Public declarations }
    property AccessToken: string read FAccessToken write FAccessToken;
  end;

var
  frmFacebook: TfrmFacebook;

implementation
{$R *.fmx}

procedure TfrmFacebook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AniIndicator1.Enabled := False;
end;

procedure TfrmFacebook.FormShow(Sender: TObject);
begin
  recBackground.Align := TAlignLayout.Client;
  WebBrowser.URL := 'about:blank';
  Timer1.Enabled := True;
end;

procedure TfrmFacebook.GetUserInfo;
begin
  if FAccessToken <> '' then
  begin
    RESTRequest.ResetToDefaults;
    RESTClient.ResetToDefaults;
    RESTResponse.ResetToDefaults;

    RESTClient.BaseURL := 'https://graph.facebook.com/';
    RESTClient.Authenticator := OAuth2_Facebook;
    RESTRequest.Resource := 'me?fields=id,name,birthday,email,gender,picture';
    OAuth2_Facebook.AccessToken := FAccessToken;

    RESTRequest.Execute;
  end;
end;

procedure TfrmFacebook.RESTRequestAfterExecute(Sender: TCustomRESTRequest);
var
  Msg, sname: string;
begin
  try
    if assigned(RESTResponse.JSONValue) then
      Msg := 'json : ' + Msg + TJson.Format(RESTResponse.JSONValue)
    else
      Msg := 'text : ' + Msg + RESTResponse.Content;

    RESTResponse.JSONValue.TryGetValue('id', _Global.FacebookUser.id);
    RESTResponse.JSONValue.TryGetValue('name', _Global.FacebookUser.name);
    RESTResponse.JSONValue.TryGetValue('birthday', _Global.FacebookUser.birthday);
    RESTResponse.JSONValue.TryGetValue('gender', _Global.FacebookUser.gender);
    RESTResponse.JSONValue.TryGetValue('email', _Global.FacebookUser.email);
    _Global.FacebookUser.picture := 'http://graph.facebook.com/' + _Global.FacebookUser.id + '/picture?type=large';

    ModalResult := mrOK;
  except
    ModalResult := mrAbort;
  end;
end;

procedure TfrmFacebook.RESTRequestHTTPProtocolError(Sender: TCustomRESTRequest);
begin
  ModalResult := mrAbort;
end;

procedure TfrmFacebook.Timer1Timer(Sender: TObject);
var
  LURL: string;
begin
  Timer1.Enabled := False;
  AniIndicator1.Enabled := True;
  TabControl1.TabIndex := 1;

  FAccessToken := '';

  LURL := 'https://www.facebook.com/v2.10/dialog/oauth'
          + '?client_id=' + URIEncode('342699346162649')
          + '&response_type=token'
          + '&scope=' + URIEncode('user_about_me,email,user_birthday')
          + '&redirect_uri=' + URIEncode('https://www.facebook.com/connect/login_success.html');
  WebBrowser.Navigate(LURL);
end;

procedure TfrmFacebook.WebBrowserDidFinishLoad(ASender: TObject);
begin
  if (Pos('/login', WebBrowser.URL) > 0) and (TabControl1.TabIndex <> 0) then
    TabControl1.TabIndex := 0;
end;

procedure TfrmFacebook.WebBrowserShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  LToken: string;
  LATPos: integer;
begin
  try
    LATPos := Pos('access_token=', URL);
    if LATPos > 0 then
    begin
      if Pos('login_success.html#', URL) > 0 then
        WebBrowser.Stop;

      LToken := copy(URL, LATPos + 13, Length(URL));

      if (Pos('&', LToken) > 0) then
        LToken := copy(LToken, 1, Pos('&', LToken) - 1);

      FAccessToken := LToken;
      if (LToken <> '') then
        GetUserInfo;
    end;
  except
    ModalResult := mrAbort;
  end;

end;

end.
