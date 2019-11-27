unit BCC.Model.Competidores;

interface

type
  TCompetidor = class
    private
      FCodigo: Integer;
      FPontuacao: Integer;
      FCodCliente: Integer;
      FCodCampeonato: Integer;
      FPartidas: Integer;
      FVitorias: Integer;
      FDerrotas: Integer;
      FEmpates: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Pontuacao: Integer read FPontuacao write FPontuacao;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property CodCampeonato: Integer read FCodCampeonato write FCodCampeonato;
      property Partidas: Integer read FPartidas write FPartidas;
      property Vitorias: Integer read FVitorias write FVitorias;
      property Derrotas: Integer read FDerrotas write FDerrotas;
      property Empates: Integer read FEmpates write FEmpates;
  end;

implementation

end.
