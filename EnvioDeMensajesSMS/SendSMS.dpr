program SendSMS;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmSms};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSms, frmSms);
  Application.Run;
end.
