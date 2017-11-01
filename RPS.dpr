program RPS;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainU in 'MainU.pas' {Form1},
  GameU in 'GameU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
