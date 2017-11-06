unit GameU;

interface

type
  TMove=(rock,paper,scissors);

  TGame=class
    Constructor Create;
    private
    procedure computerWins;
    procedure playerWins;
    procedure tie;
    public
    player_score:integer;
    computer_score:integer;
    tie_score:integer;
    result_message:string;
    computer_move:TMove;
    procedure ComputerTurn;
    procedure PlayerTurn (player_move:TMove);
  end;

implementation

  uses Math;

  constructor TGame.Create;
  begin
    Randomize;
  end;

  procedure TGame.ComputerTurn;
var
  i:integer;
begin
  //0 is rock, 1 is paper, 2 is scissors
   i:=Random(3);
   computer_move := TMove(i);
end;


  procedure TGame.PlayerTurn (player_move:TMove);
begin
ComputerTurn;
if (computer_move=player_move) then tie;
if ((player_move=rock) and (computer_move=scissors)) or ((player_move=paper) and (computer_move=rock)) or ((player_move=scissors) and (computer_move=paper)) then self.playerWins;
if ((player_move=rock) and (computer_move=paper)) or ((player_move=paper) and (computer_move=scissors)) or ((player_move=scissors) and (computer_move=rock)) then self.computerWins;
end;

procedure TGame.computerWins;
begin
   Inc(computer_score);
   result_message:='Computer wins!';
end;

procedure TGame.playerWins;
begin
  Inc(player_score);
  result_message:='You win!';
end;

procedure TGame.tie;
begin
  Inc(tie_score);
  result_message:='Tie!';
end;


end.
