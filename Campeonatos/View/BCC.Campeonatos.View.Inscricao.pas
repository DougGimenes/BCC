unit BCC.Campeonatos.View.Inscricao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Vcl.Grids,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBGrids, Vcl.StdCtrls, Math,
  BCC.DAO.Campeonatos, System.Generics.Collections, BCC.Model.Campeonato,
  BCC.DAO.Jogo, Data.Win.ADODB, BCC.Conexao.DAO.Dados, BCC.Controller.Campeonatos,
  BCC.DAO.Competidores;

type
  TFrmInscricaoCampeonato = class(TFraBase)
    LblTitulo: TLabel;
    DbgCampeonatos: TDBGrid;
    DsCampeonatos: TDataSource;
    EdtPesquisa: TEdit;
    BtnInscrever: TButton;
    BtnPesquisar: TButton;
    QryInscricao: TADOQuery;
    QryInscricaoID_Campeonato: TAutoIncField;
    QryInscricaoCampeonato: TStringField;
    QryInscricaoID_Jogo: TAutoIncField;
    QryInscricaoJogo: TStringField;
    QryInscricaoFormato: TStringField;
    PnlConteudo: TPanel;
    procedure FrameResize(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnInscreverClick(Sender: TObject);
  private
    { Private declarations }
    procedure PadronizarColunas();
    procedure AbrirTabela();
  public
    { Public declarations }
  end;

var
  FrmInscricaoCampeonato: TFrmInscricaoCampeonato;

implementation

{$R *.dfm}

{ TFrmInscricaoCampeonato }

{ TFrmInscricaoCampeonato }

procedure TFrmInscricaoCampeonato.AbrirTabela;
begin
  Self.QryInscricao.Close();
  Self.QryInscricao.SQL.Text := 'SELECT' + #13 +
                                '  c.ID_Campeonato,' + #13 +
                                '  c.Identificacao AS Campeonato,' + #13 +
                                '  j.ID_Jogo,' + #13 +
                                '  j.Identificacao AS Jogo,' + #13 +
                                '  (CASE' + #13 +
                                '    WHEN c.Formato = 0 THEN ''Pontos Corridos''' + #13 +
                                '    WHEN c.Formato = 1 THEN ''Eliminatoria''' + #13 +
                                '  END) AS Formato' + #13 +
                                'FROM Campeonatos c' + #13 +
                                '  INNER JOIN Jogos j' + #13 +
                                '    ON c.ID_Jogo = j.ID_Jogo' + #13 +
                                'WHERE c.Estado = 0' + #13 +
                                '  AND c.ID_Campeonato NOT IN' + #13 +
                                '   (SELECT' + #13 +
                                '      cc.ID_Campeonato' + #13 +
                                '    FROM Competidores_Campeonato cc' + #13 +
                                '      WHERE ID_Cliente = ' + DmDados.Usuario.CodCli.ToString() + ')';
  Self.QryInscricao.Open();
end;

procedure TFrmInscricaoCampeonato.BtnInscreverClick(Sender: TObject);
begin
  inherited;
  if TDmCampeonato.Create(nil).Selecionar(Self.QryInscricaoID_Campeonato.Value).NumParticipantes < TDmCompetidores.Create(nil).SelecionarCampeonato(Self.QryInscricaoID_Campeonato.Value).Count then
  begin
    if TControllerCampeonatos.InscreverCliente(DmDados.Usuario.CodCli, Self.QryInscricaoID_Campeonato.Value) then
    begin
      Application.MessageBox(PChar('Inscrição realizada com sucesso!'), PChar('Board Café Control'));
    end;
  end
  else
  begin
    raise Exception.Create('O limite de competidores já foi atingido para esse campeonato!');
  end;

  Self.AbrirTabela();
end;

procedure TFrmInscricaoCampeonato.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  Self.QryInscricao.DisableControls();
  Self.QryInscricao.Filtered := False;

  if Self.EdtPesquisa.Text <> '' then
  begin
    Self.QryInscricao.Filter := ('Campeonato LIKE ' + QuotedStr('%' +Self.EdtPesquisa.Text + '%') +
                                 '  OR Jogo LIKE ' + QuotedStr('%' +Self.EdtPesquisa.Text + '%') +
                                 '  OR Formato LIKE ' + QuotedStr('%' +Self.EdtPesquisa.Text + '%'));
    Self.QryInscricao.Filtered := True;
  end;
  Self.QryInscricao.EnableControls();
end;

procedure TFrmInscricaoCampeonato.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PadronizarColunas();
  Self.AbrirTabela();
end;

procedure TFrmInscricaoCampeonato.PadronizarColunas;
begin
  Self.DbgCampeonatos.Columns[0].Width := 150;
  Self.DbgCampeonatos.Columns[1].Width := Ceil((Screen.WorkAreaWidth - 520) * (40 / 100));
  Self.DbgCampeonatos.Columns[2].Width := Floor((Screen.WorkAreaWidth - 520) * (35 / 100));
  Self.DbgCampeonatos.Columns[3].Width := Floor((Screen.WorkAreaWidth - 520) * (25 / 100));
end;

end.
