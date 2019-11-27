unit BCC.Produto.Model.Promocao;

interface

type
  ETipoPromocao = (PrmDiaSemana, PrdData, PrdQuantidade);
  EDiaSemana = (PrmDomingo = 1, PrmSegunda = 2, PrmTerca = 3, PrmQuarta = 4, PrmQuinta = 5, PrmSexta = 6, PrmSabado = 7);

  TRegraPromocao = class
    private
      FCodigo: Integer;
      FTipo: ETipoPromocao;
      FDataInicial: TDate;
      FDataFinal: TDate;
      FDiaSemana: EDIaSemana;
      FQuantidadeMinima: Double;
      FNome: String;
      FDescricao: String;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property Descricao: String read FDescricao write FDescricao;
      property Tipo: ETipoPromocao read FTipo write FTipo;
      property DataInicial: TDate read FDataInicial write FDataInicial;
      property DataFinal: TDate read FDataFinal write FDataFinal;
      property DiaSemana: EDIaSemana read FDiaSemana write FDiaSemana;
      property QuantidadeMinima: Double read FQuantidadeMinima write FQuantidadeMinima;
  end;

  TPromocao = class
    private
      FCodigo: Integer;
      FCodProduto: Integer;
      FRegra: TRegraPromocao;
      FPrecoPromocional: Double;
      FCodServico: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property CodProduto: Integer read FCodProduto write FCodProduto;
      property CodServico: Integer read FCodServico write FCodServico;
      property Regra: TRegraPromocao read FRegra write FRegra;
      property PrecoPromocional: Double read FPrecoPromocional write FPrecoPromocional;
  end;

implementation

end.
