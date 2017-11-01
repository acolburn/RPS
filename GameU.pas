unit GameU;

interface

type
  TGame=class
    Constructor Create;
    private
    public
    player_score:integer;
    computer_score:integer;
    tie_score:integer;
  end;

implementation

  uses Math;

  constructor TGame.Create;
  begin
    Randomize;
  end;

end.
