unit BCC.Sala.DAO.Reserva;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Sala.Model.Reserva, System.Generics.Collections;

type
  TDmReserva = class(TDataModule)
    TbReserva: TADOQuery;
    TbReservaID_Reserva: TAutoIncField;
    TbReservaID_Sala: TIntegerField;
    TbReservaID_Cliente: TIntegerField;
    TbReservaDataHora: TDateTimeField;
    TbReservaTempo: TDateTimeField;
  private
    { Private declarations }
    procedure ObjToData(AReserva : TReserva);
    function  DataToObj(): TReserva;
  public
    { Public declarations }
    function  Inserir(AReserva : TReserva) : TReserva;
    function  Selecionar(ACodigo : Integer) : TReserva;
    function  SelecionarTodos() : TObjectList<TReserva>;
    function  SelecionarData(AData : TDate) : TObjectList<TReserva>;
    procedure Editar(AReserva : TReserva);

    function  ValidarData(AReserva : TReserva) : Boolean;
  end;

var
  DmReserva: TDmReserva;

implementation

{$R *.dfm}

{ TDmReserva }

function TDmReserva.DataToObj: TReserva;
begin
  Result := TReserva.Create();
  Result.Codigo        := Self.TbReservaID_Reserva.Value;
  Result.CodSala       := Self.TbReservaID_Sala.Value;
  Result.CodCliente    := Self.TbReservaID_Cliente.Value;
  Result.DataHora      := Self.TbReservaDataHora.Value;
  Result.DataHoraFinal := Self.TbReservaTempo.AsDateTime;
end;

procedure TDmReserva.Editar(AReserva: TReserva);
begin
  Self.Selecionar(AReserva.Codigo);
  Self.TbReserva.Edit();
  Self.ObjToData(AReserva);
  Self.TbReserva.Post();
end;

function TDmReserva.Inserir(AReserva: TReserva): TReserva;
begin
  Self.TbReserva.Close();
  Self.TbReserva.SQL.Clear();
  Self.TbReserva.SQL.Text := 'SELECT * FROM Reserva' + #13 +
                             '  WHERE -1 = 1';
  Self.TbReserva.Open();
  Self.TbReserva.Append();
  Self.ObjToData(AReserva);
  Self.TbReserva.Post();

  Result := Self.DataToObj();
end;

procedure TDmReserva.ObjToData(AReserva: TReserva);
begin
  Self.TbReservaID_Sala.Value    := AReserva.CodSala;
  Self.TbReservaID_Cliente.Value := AReserva.CodCliente;
  Self.TbReservaDataHora.Value   := AReserva.DataHora;
  Self.TbReservaTempo.Value      := AReserva.DataHoraFinal;
end;

function TDmReserva.Selecionar(ACodigo: Integer): TReserva;
begin
  Self.TbReserva.Close();
  Self.TbReserva.SQL.Clear();
  Self.TbReserva.SQL.Text := 'SELECT * FROM Reserva' + #13 +
                             '  WHERE ID_Reserva = ' + ACodigo.ToString();
  Self.TbReserva.Open();

  Result := Self.DataToObj();
end;

function TDmReserva.SelecionarData(AData : TDate): TObjectList<TReserva>;
begin
  Self.TbReserva.Close();
  Self.TbReserva.SQL.Clear();
  Self.TbReserva.SQL.Text := 'SELECT * FROM Reserva' + #13 +
                             '  WHERE DataHora BETWEEN ' + QuotedStr(DateToStr(AData) + ' 00:00:00') +
                             '    AND ' + QuotedStr(DateToStr(AData) + ' 23:59:59');
  Self.TbReserva.Open();

  Result := TObjectList<TReserva>.Create(True);
  Self.TbReserva.First();
  for var I := 0 to Self.TbReserva.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbReserva.Next();
  end;
end;

function TDmReserva.SelecionarTodos: TObjectList<TReserva>;
begin
  Self.TbReserva.Close();
  Self.TbReserva.SQL.Clear();
  Self.TbReserva.SQL.Text := 'SELECT * FROM Reserva';
  Self.TbReserva.Open();

  Result := TObjectList<TReserva>.Create(True);
  Self.TbReserva.First();
  for var I := 0 to Self.TbReserva.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbReserva.Next();
  end;
end;

function TDmReserva.ValidarData(AReserva : TReserva): Boolean;
begin
  Self.TbReserva.Close();
  Self.TbReserva.SQL.Clear();
  Self.TbReserva.SQL.Text := 'SELECT * FROM Reserva' + #13 +
                             'WHERE ((DataHora BETWEEN ' + QuotedStr(DateTimeToStr(AReserva.DataHora)) + #13 +
                             '  AND ' + QuotedStr(DateTimeToStr(AReserva.DataHoraFinal)) + ')'         + #13 +
                             '  OR (Tempo BETWEEN ' + QuotedStr(DateTimeToStr(AReserva.DataHora))      + #13 +
                             '  AND ' + QuotedStr(DateTimeToStr(AReserva.DataHoraFinal)) + '))'        + #13 +
                             'AND ID_Reserva != ' + AReserva.Codigo.ToString() + #13 +
                             'AND ID_Sala = ' + AReserva.CodSala.ToString();
  Self.TbReserva.Open();

  Result := Self.TbReserva.RecordCount = 0;
end;

end.
