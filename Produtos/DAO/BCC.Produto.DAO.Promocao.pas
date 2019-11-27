unit BCC.Produto.DAO.Promocao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Produto.Model.Promocao,
  BCC.Conexao.DAO.Dados, System.Generics.Collections, DateUtils;

type
  TDmPromocao = class(TDataModule)
    TbPromocao: TADOQuery;
    TbPromocaoCodigo: TAutoIncField;
    TbPromocaoCodProduto: TIntegerField;
    TbPromocaoCodRegra: TIntegerField;
    TbPromocaoPrecoPromocional: TFloatField;
    TbRegra: TADOQuery;
    TbRegraCodigo: TAutoIncField;
    TbRegraNome: TStringField;
    TbRegraDescricao: TMemoField;
    TbRegraTipo: TIntegerField;
    TbRegraDataInicial: TDateTimeField;
    TbRegraDataFinal: TDateTimeField;
    TbRegraQuantidadeMinima: TFloatField;
    TbRegraDiaSemana: TIntegerField;
    TbPromocaoCodServico: TIntegerField;
  private
    { Private declarations }
    function  DataToPromocao() : TPromocao;
    procedure PromocaoToData(APromocao : TPromocao);

    function  DataToRegra() : TRegraPromocao;
    procedure RegraToData(ARegra : TRegraPromocao);
  public
    { Public declarations }
    function  InserirPromocao(APromocao : TPromocao) : TPromocao;
    function  SelecionarPromocao(ACodigo : Integer) : TPromocao;
    procedure EditarPromocao(APromocao : TPromocao);
    procedure DeletarPromocao(ACodigo : Integer);

    function  InserirRegra(ARegra : TRegraPromocao) : TRegraPromocao;
    function  SelecionarRegra(ACodigo : Integer) : TRegraPromocao;
    procedure EditarRegra(ARegra : TRegraPromocao);

    function SelecionarPromoProd(ACodProduto : Integer) : TObjectList<TPromocao>;
    function SelecionarPromoServ(ACodServico : Integer) : TObjectList<TPromocao>;
  end;

var
  DmPromocao: TDmPromocao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmPromocao }

function TDmPromocao.DataToPromocao: TPromocao;
begin
  Result := TPromocao.Create();
  Result.Codigo := Self.TbPromocaoCodigo.Value;
  Result.CodProduto := Self.TbPromocaoCodProduto.Value;
  Result.Regra := Self.SelecionarRegra(Self.TbPromocaoCodRegra.Value);
  Result.PrecoPromocional := Self.TbPromocaoPrecoPromocional.Value;
end;

function TDmPromocao.DataToRegra: TRegraPromocao;
begin
  Result := TRegraPromocao.Create();
  Result.Codigo           := Self.TbRegraCodigo.Value;
  Result.Nome             := Self.TbRegraNome.Value;
  Result.Descricao        := Self.TbRegraDescricao.Value;
  Result.Tipo             := ETipoPromocao(Self.TbRegraTipo.Value);
  Result.DataInicial      := DateOf(Self.TbRegraDataInicial.AsDateTime);
  Result.DataFinal        := DateOf(Self.TbRegraDataFinal.AsDateTime);
  Result.DiaSemana        := EDiaSemana(Self.TbRegraDiaSemana.Value);
  Result.QuantidadeMinima := Self.TbRegraQuantidadeMinima.Value;
end;

procedure TDmPromocao.DeletarPromocao(ACodigo: Integer);
begin
  Self.SelecionarPromocao(ACodigo);
  Self.TbPromocao.Delete();
end;

procedure TDmPromocao.EditarPromocao(APromocao: TPromocao);
begin
  Self.SelecionarPromocao(APromocao.Codigo);
  Self.TbPromocao.Edit();
  Self.PromocaoToData(APromocao);
  Self.TbPromocao.Post();
end;

procedure TDmPromocao.EditarRegra(ARegra: TRegraPromocao);
begin
  Self.SelecionarRegra(ARegra.Codigo);
  Self.TbRegra.Edit();
  Self.RegraToData(ARegra);
  Self.TbRegra.Post();
end;

function TDmPromocao.InserirPromocao(APromocao: TPromocao): TPromocao;
begin
  Self.TbPromocao.Close();
  Self.TbPromocao.SQL.Clear();
  Self.TbPromocao.SQL.Text := 'SELECT * FROM Promocao WHERE -1 = 1';
  Self.TbPromocao.Open();
  Self.TbPromocao.Append();
  Self.PromocaoToData(APromocao);
  Self.TbPromocao.Post();

  Result := Self.DataToPromocao();
end;

function TDmPromocao.InserirRegra(ARegra: TRegraPromocao): TRegraPromocao;
begin
  Self.TbRegra.Close();
  Self.TbRegra.SQL.Clear();
  Self.TbRegra.SQL.Text := 'SELECT * FROM Regras_Promocao WHERE -1 = 1';
  Self.TbRegra.Open();
  Self.TbRegra.Append();
  Self.RegraToData(ARegra);
  Self.TbRegra.Post();

  Result := Self.DataToRegra();
end;

procedure TDmPromocao.PromocaoToData(APromocao: TPromocao);
begin
  if APromocao.CodProduto > 0 then
  begin
    Self.TbPromocaoCodProduto.Value := APromocao.CodProduto;
  end
  else
  begin
    Self.TbPromocaoCodProduto.Clear();
  end;

  if APromocao.CodServico > 0 then
  begin
    Self.TbPromocaoCodServico.Value := APromocao.CodServico;
  end
  else
  begin
    Self.TbPromocaoCodServico.Clear();
  end;

  Self.TbPromocaoCodRegra.Value         := APromocao.Regra.Codigo;
  Self.TbPromocaoPrecoPromocional.Value := APromocao.PrecoPromocional;
end;

procedure TDmPromocao.RegraToData(ARegra: TRegraPromocao);
begin
  Self.TbRegraNome.Value             := ARegra.Nome;
  Self.TbRegraDescricao.Value        := ARegra.Descricao;
  Self.TbRegraTipo.Value             := Integer(ARegra.Tipo);
  Self.TbRegraDataInicial.Value      := ARegra.DataInicial;
  Self.TbRegraDataFinal.Value        := ARegra.DataFinal;
  Self.TbRegraQuantidadeMinima.Value := ARegra.QuantidadeMinima;
  Self.TbRegraDiaSemana.Value        := Integer(ARegra.DiaSemana);
end;

function TDmPromocao.SelecionarPromocao(ACodigo: Integer): TPromocao;
begin
  Self.TbPromocao.Close();
  Self.TbPromocao.SQL.Clear();
  Self.TbPromocao.SQL.Text := 'SELECT * FROM Promocao' + #13 +
                              'WHERE Codigo = ' + ACodigo.ToString();
  Self.TbPromocao.Open();

  Result := Self.DataToPromocao();
end;

function TDmPromocao.SelecionarRegra(ACodigo: Integer): TRegraPromocao;
begin
  Self.TbRegra.Close();
  Self.TbRegra.SQL.Clear();
  Self.TbRegra.SQL.Text := 'SELECT * FROM Regras_Promocao' + #13 +
                           'WHERE Codigo = ' + ACodigo.ToString();
  Self.TbRegra.Open();

  Result := Self.DataToRegra();
end;

function TDmPromocao.SelecionarPromoProd(ACodProduto: Integer): TObjectList<TPromocao>;
var
  Promocoes : TObjectList<TPromocao>;
begin
  Self.TbPromocao.Close();
  Self.TbPromocao.SQL.Clear();
  Self.TbPromocao.SQL.Text := 'SELECT * FROM Promocao' + #13 +
                              'WHERE CodProduto = ' + ACodProduto.ToString();
  Self.TbPromocao.Open();

  Result := TObjectList<TPromocao>.Create(True);

  if Self.TbPromocao.RecordCount > 0 then
  begin
    for var I := 0 to Self.TbPromocao.RecordCount - 1 do
    begin
      Result.Add(Self.DataToPromocao());
    end;
  end;
end;

function TDmPromocao.SelecionarPromoServ(ACodServico: Integer): TObjectList<TPromocao>;
var
  Promocoes : TObjectList<TPromocao>;
begin
  Self.TbPromocao.Close();
  Self.TbPromocao.SQL.Clear();
  Self.TbPromocao.SQL.Text := 'SELECT * FROM Promocao' + #13 +
                              'WHERE CodServico = ' + ACodServico.ToString();
  Self.TbPromocao.Open();

  Result := TObjectList<TPromocao>.Create(True);

  if Self.TbPromocao.RecordCount > 0 then
  begin
    for var I := 0 to Self.TbPromocao.RecordCount - 1 do
    begin
      Result.Add(Self.DataToPromocao());
    end;
  end;
end;

end.
