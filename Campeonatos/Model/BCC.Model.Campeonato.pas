unit BCC.Model.Campeonato;

interface

type
  EFormato = (CmpPontosCorridos, CmpEliminacao);
  EEstado = (CmpEspera, CmpIniciado, CmpFinalizado, CmpCancelado, CmpTodos);

  TCampeonato = class
    private
      FCodigo: Integer;
      FIdentificacao: String;
      FNumParticipantes: Integer;
      FCodJogo: Integer;
      FFormato: EFormato;
      FEstado: EEstado;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Identificacao: String read FIdentificacao write FIdentificacao;
      property NumParticipantes: Integer read FNumParticipantes write FNumParticipantes;
      property CodJogo: Integer read FCodJogo write FCodJogo;
      property Formato: EFormato read FFormato write FFormato;
      property Estado: EEstado read FEstado write FEstado;
  end;

implementation

end.
