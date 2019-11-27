unit BCC.Sala.Model.Reserva;

interface

type
  TReserva = class
    private
      FCodigo: Integer;
      FCodSala: Integer;
      FCodCliente: Integer;
      FDataHora: TDateTime;
      FDataHoraFinal: TDateTime;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property CodSala: Integer read FCodSala write FCodSala;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property DataHora: TDateTime read FDataHora write FDataHora;
      property DataHoraFinal: TDateTime read FDataHoraFinal write FDataHoraFinal;
  end;

implementation

end.
