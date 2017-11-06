unit MainU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, IOUtils, IniFiles,
  GameU;

type
  //TMove=(rock,paper,scissors);

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
    procedure UpdateDisplay;
  public
    { Public declarations }
    game: TGame;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
uses Math;

procedure TForm1.UpdateDisplay;
begin
   EditCompWins.Text:=IntToStr(game.computer_score);
   EditPlayerWins.Text:=IntToStr(game.player_score);
   EditTie.Text:=IntToStr(game.tie_score);
   LabelResult.Text:=game.result_message;
   if (game.computer_move=rock) then ImageControl1.LoadFromFile('rock.gif')
   else if (game.computer_move=paper) then ImageControl1.LoadFromFile('paper.gif')
   else if (game.computer_move=scissors) then ImageControl1.LoadFromFile('scissors.gif')
   else showmessage('error');
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
   game.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini:TIniFile;
begin
  game:=TGame.Create;

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
begin
  game.playerTurn(paper);
  UpdateDisplay;
end;

procedure TForm1.ImageRockClick(Sender: TObject);
begin
   game.PlayerTurn(rock);
   UpdateDisplay;

end;

procedure TForm1.ImageScissorsClick(Sender: TObject);
begin
  game.PlayerTurn(scissors);
  UpdateDisplay;
end;

end.
