unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  /// Helpers for Android implementations by FMX.
  FMX.Helpers.Android,
  // Java Native Interface permite a programas
  // ejecutados en la JVM interactue con otros lenguajes
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  // Obtiene datos de telefonia del dispositivo
  Androidapi.JNI.Telephony;

type
  TfrmSms = class(TForm)
    tbarHeader: TToolBar;
    btnExit: TButton;
    btnSend: TButton;
    edtNumber: TEdit;
    memMessage: TMemo;
    Label1: TLabel;
    procedure SendSMS(target, message: string);
    procedure btnSendClick(Sender: TObject);
    procedure memMessageKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmSms: TfrmSms;
  t: integer;
  c: string;

implementation

{$R *.fmx}

procedure TfrmSms.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSms.btnSendClick(Sender: TObject);
begin
  // llamar a SendSMS que recibe 2 paramentros
  // target: Destinatario de SMS; message: contenido del SMS;
  SendSMS(edtNumber.Text, memMessage.Text);
end;

procedure TfrmSms.memMessageKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  c := memMessage.Text;
  t := c.Length;
  Label1.Text := 'Total de caracteres: ' + IntToStr(t) + ' de 160';
end;

procedure TfrmSms.SendSMS(target, message: string);
var
  smsManager: JSmsManager; // declarar administrador de mensajes
  smsTo: JString; // variable destinatario del SMS
begin
  try
    // inicializar administrador de mensajes
    smsManager := TJSmsManager.JavaClass.getDefault;
    // convertir target a tipo Jstring tipo de dato usado por JNI
    smsTo := StringToJString(target);
    // pasar parametros a administrador para enviar mensaje
    smsManager.sendTextMessage(smsTo, nil, StringToJString(message), nil, nil);
    ShowMessage('Mensaje enviado');
  except
    on E: Exception do
      ShowMessage(E.ToString);
  end;
end;

end.
