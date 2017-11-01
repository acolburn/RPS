unit MainU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, IOUtils, IniFiles,
  GameU;

type
  TForm1 = class(TForm)
    ImageRock: TImage;
    ImagePaper: TImage;
    ImageScissors: TImage;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    GlowEffect3: TGlowEffect;
    ImageControl1: TImageControl;
    LabelResult: TLabel;
    EditCompWins: TEdit;
    Label1: TLabel;
    EditPlayerWins: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditTie: TEdit;
    Label5: TLabel;
    procedure ImageRockClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImagePaperClick(Sender: TObject);
    procedure ImageScissorsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function ComputerTurn:integer;
    procedure ComputerWins;
    procedure PlayerWins;
    procedure Tie;
  public
    { Public declarations }
    game: TGame;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
uses Math;

procedure UpdateDisplay;
begin
   EditCompWins.Text:=IntToStr(game.computer_score);
   EditPlayerWins.Text:=IntToStr(game.player_score);
   EditTie.Text:=IntToStr(game.tie_score);
end;

function TForm1.ComputerTurn:integer;
var
  i:integer;
begin
   i:=Random(3);
   if (i=0) then ImageControl1.LoadFromFile('rock.gif')
   else if (i=1) then ImageControl1.LoadFromFile('paper.gif')
   else if (i=2) then ImageControl1.LoadFromFile('scissors.gif')
   else showmessage('error');
   result := i;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini:TIniFile;
begin
  ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'user.dat'));
  try
     Ini.WriteInteger( 'Form', 'Top', Top);
     Ini.WriteInteger( 'Form', 'Left', Left);
     Ini.WriteInteger( 'Form', 'Height', Height );
     Ini.WriteInteger('Form','Width',Width);
      ini.WriteInteger('Scores','player_score',game.player_score);
      ini.WriteInteger('Scores','computer_score',game.computer_score);
      ini.WriteInteger('Scores','tie_score',game.tie_score);
   finally
     Ini.Free;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini:TIniFile;
begin
  game:=TGame.Create;
  Randomize;

  ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'user.dat'));
  try
     Top     := Ini.ReadInteger( 'Form', 'Top', 100 );
     Left    := Ini.ReadInteger( 'Form', 'Left', 100 );
     Height := Ini.ReadInteger( 'Form', 'Height', 700 );
     Width := ini.ReadInteger('Form','Width',400);
    game.player_score := ini.ReadInteger('Scores','player_score',0);
    game.computer_score := ini.ReadInteger('Scores','computer_score',0);
    game.tie_score := ini.ReadInteger('Scores','tie_score',0);
   finally
     Ini.Free;
   end;
   UpdateDisplay;

end;

procedure TForm1.ImagePaperClick(Sender: TObject);
var
  comp:integer;
begin
   comp:=ComputerTurn;
   if (comp=0) then begin
   LabelResult.Text:='Paper beats rock';
   PlayerWins;
   end
   else if (comp=1) then begin
   LabelResult.Text:='Tie';
   Tie;
   end
   else if (comp=2) then begin
   LabelResult.Text:='Scissors cut paper';
   ComputerWins;
   end
   else LabelResult.Text:='error';
end;

procedure TForm1.ImageRockClick(Sender: TObject);
var
  comp:integer;
begin
   comp:=ComputerTurn;
   if (comp=0) then begin
   LabelResult.Text := 'Tie';
   Tie;
   end
   else if (comp=1) then begin
   LabelResult.Text:='Paper beats rock';
   ComputerWins;
   end
   else if (comp=2) then begin
   LabelResult.Text:='Rock beats scissors';
   PlayerWins;
   end
   else LabelResult.Text:='error';

end;

procedure TForm1.ImageScissorsClick(Sender: TObject);
var
  comp:integer;
begin
  comp:=ComputerTurn;
  if (comp=0) then begin
  LabelResult.Text:='Rock beats scissors';
  ComputerWins;
  end
  else if (comp=1) then begin
  LabelResult.Text:='Scissors cut paper';
  PlayerWins;
  end
  else if (comp=2) then begin
  LabelResult.Text:='Tie';
  Tie;
  end
  else LabelResult.Text:='error';
end;

procedure TForm1.ComputerWins;
begin
  game.computer_score:=game.computer_score+1;
  UpdateDisplay;
end;

procedure TForm1.PlayerWins;
begin
  game.player_score:=game.player_score+1;
  UpdateDisplay;
end;

procedure TForm1.Tie;
begin
  game.tie_score:=game.tie_score+1;
  UpdateDisplay;
end;

end.
